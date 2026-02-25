#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h> // Для gettimeofday

// --- Функции вычислений ---

void normal(float a[], float b[], float c[]) {
    for (int i = 0; i < 4; i++) {
        c[i] = a[i] * b[i];
    }
}

void sse(float a[], float b[], float c[]) {
    asm volatile (
        "movups %[a], %%xmm0\n"
        "movups %[b], %%xmm1\n"
        "mulps %%xmm1, %%xmm0\n"
        "movups %%xmm0, %[c]\n"
        :
        : [a]"m"(*a), [b]"m"(*b), [c]"m"(*c)
        : "%xmm0", "%xmm1", "memory" // Добавили "memory" для надежности
    );
}

// --- Функция для замера времени ---
double get_time() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec + tv.tv_usec / 1000000.0;
}

int main() {
    // 1. Инициализация данных
    float a[4] = {4.0f, 5.0f, 7.0f, 6.0f};
    float b[4] = {40.0f, 50.0f, 70.0f, 60.0f};
    float c[4];
    
    int iterations_num = 100000000; 

    printf("Запуск тестов (%d итераций)...\n\n", iterations_num);

    // --- ТЕСТ 1: Normal ---
    double start = get_time();
    for (int i = 0; i < iterations_num; i++) {
        normal(a, b, c);
    }
    double end = get_time();
    double time_normal = end - start;

    // результат normal
    printf("Normal результат: %f %f %f %f\n", c[0], c[1], c[2], c[3]);
    printf("Normal время:     %.6f сек\n\n", time_normal);


    // --- ТЕСТ 2: SSE ---
    start = get_time();
    for (int i = 0; i < iterations_num; i++) {
        sse(a, b, c);
    }
    end = get_time();
    double time_sse = end - start;

    // результат sse
    printf("SSE результат:    %f %f %f %f\n", c[0], c[1], c[2], c[3]);
    printf("SSE время:        %.6f сек\n\n", time_sse);

    return 0;
}