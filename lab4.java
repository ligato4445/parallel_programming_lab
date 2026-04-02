
import java.util.*;
import java.util.concurrent.*;
import java.util.function.IntBinaryOperator;

public class lab4 {

    public static final int THREADS = 50;
    public static final int ITERATIONS = 100000; 
    public static final double NSEC = 1_000_000_000.0;
    public static final int MAP_SIZE = 3; // Мало ключей для усиления коллизий
    public static final int SAMPLES = 5;

    // Инициализация коллекций
    public static Map<String, Integer> hashMap = new HashMap<>();
    public static Map<String, Integer> hashTable = new Hashtable<>();
    public static Map<String, Integer> syncMap = Collections.synchronizedMap(new HashMap<>());
    public static Map<String, Integer> cHashMap = new ConcurrentHashMap<>();

    public static void main(String[] args) {
        System.out.println("Starting concurrency test...");
        System.out.println("Threads: " + THREADS + ", Iterations per thread: " + ITERATIONS);
        System.out.println("Expected total increments: " + (THREADS * ITERATIONS));
        System.out.println("Collections:");

        // Запускаем тесты для каждой коллекции
        double hashMapTime = compute(hashMap ) / NSEC;
        double hashTableTime = compute(hashTable ) / NSEC;
        double syncMapTime = compute(syncMap) / NSEC;
        double cHashMapTime = compute(cHashMap) / NSEC; 

        System.out.println("\nExecution times:");
        System.out.println(String.format(
                "\tHashMap:           %.3f s\n\tHashTable:         %.3f s\n\tSyncMap:           %.3f s\n\tConcurrentHashMap: %.3f s",
                hashMapTime, hashTableTime, syncMapTime, cHashMapTime));
    }

    private static double compute(Map<String, Integer> map) {

        System.out.println("\n" + map.getClass().getSimpleName()); // ADDED: новая строка перед каждой коллекцией

        long totalTime = 0;

        for (int k = 0; k < SAMPLES; k++) {
            map.clear();

            // Предварительное заполнение (чтобы не было null)
            for (int i = 0; i < MAP_SIZE; i++) {
                map.put("key" + i, 0);
            }

            long start = System.nanoTime();

            ExecutorService executorService = Executors.newFixedThreadPool(THREADS);
            List<Callable<String>> tasks = new ArrayList<>();

            for (int i = 0; i < THREADS; i++) {
                tasks.add(() -> {
                    Random random = new Random();
                    for (int j = 0; j < ITERATIONS; j++) {
                        String key = "key" + random.nextInt(MAP_SIZE);

                        map.merge(key, 1, Integer::sum);
                        //Намеренная гонка: покажет потерю данных
                        /** Integer val = map.get(key);
                        *   map.put(key, val + 1);
                        */
                    }
                    return Thread.currentThread().getName();
                });
            }

            try {
                // Ждем завершения ВСЕХ потоков
                List<Future<String>> results = executorService.invokeAll(tasks);
                for (Future<String> result : results) {
                    result.get(); // Пробрасываем исключения, если были
                }
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            } finally {
                executorService.shutdown();
            }

            long stop = System.nanoTime();
            totalTime += (stop - start);

            // Проверка результата
            int total = map.values().stream().mapToInt(Integer::intValue).sum();
            int expected = THREADS * ITERATIONS;

           // ADDED: красивый построчный вывод
            System.out.print("    Sample " + (k + 1) + ": ");
            System.out.print("total=" + total + " expected=" + expected);

            if (total != expected) {
                int lost = expected - total;
                System.out.print(" <-- ERROR (Lost: " + lost + ")");
            } else {
                System.out.print(" <-- OK");
            }

            System.out.println(); // ADDED: перенос строки
        }

        System.out.println();

        return (double) totalTime / SAMPLES; // Возвращаем среднее время
    }
}