#define _POSIX_C_SOURCE 199309L

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <math.h>
#include <time.h>       
#include <sys/time.h> 
#include <unistd.h> 

void *heavy_task(void *i) {
  int thread_num = *((int*) i);
  // Long-running task
  for (int i = 0; i < 1e8; i++) {
    sqrt(sqrt(i+i+i)+sqrt(i+i+i));
  }
  //printf("\tThread #%d finished\n", thread_num);
  free(i);
}

void pthreads(int threads_num) {

  pthread_t threads[threads_num];
  int status;

  for (int i = 0; i < threads_num; i++) {

    //printf("MAIN: starting thread %d\n", i);

    int *thread_num = (int*) malloc(sizeof(int));
    *thread_num = i;

    status = pthread_create(&threads[i], NULL, heavy_task, thread_num);

    if (status != 0) {
      fprintf(stderr, "pthread_create failed, error code %d\n", status);
      exit(EXIT_FAILURE);
    }
  }

  for (int i = 0; i < threads_num; i++) {
    pthread_join(threads[i], NULL);
  }
}

int main(int argc, char** argv) {
  int threads_num = atoi(argv[1]);
  struct timespec start, end;
  
  //test pthreads
  clock_gettime(CLOCK_MONOTONIC, &start);
  pthreads(threads_num);
  clock_gettime(CLOCK_MONOTONIC, &end);
  
  double time = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9; 
  printf("Time pthreads: %f seconds\n", time);


  //test normal
  clock_gettime(CLOCK_MONOTONIC, &start);
  for (int i = 0; i < threads_num; i++) {
    int *arg = malloc(sizeof(int));
    *arg = i;
    heavy_task(arg); 
  }
  clock_gettime(CLOCK_MONOTONIC, &end);
 
  time = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
  printf("Time normal: %f seconds\n", time);
  

  return 0;
}