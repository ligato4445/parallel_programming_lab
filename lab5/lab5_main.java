package lab5;


import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class lab5_main {
    public static final int THREADS = 10;
    public static final int COUNT = 3;
    public static Semaphore regularSemaphore = new Semaphore(COUNT);
    public static lab5_mySemaphore mySemaphore = new lab5_mySemaphore(COUNT);

    public static void main(String[] args){
        
        System.out.println("------------\nRegular semaphore\n------------");
        runTask(regularSemaphore);
        System.out.println("------------\nMy semaphore\n------------");
        runTask(mySemaphore);
    }
    private static void runTask(Semaphore semaphore){
        ExecutorService es = Executors.newFixedThreadPool(THREADS);
        
        List<Callable<String>> tasks = new ArrayList<>();
        List<Future<String>> results = new ArrayList<>();

        for (int i = 0; i < THREADS; i++){
            tasks.add(() -> {
                String threadName = Thread.currentThread().getName();
                try {
                    regularSemaphore.acquire(); // захват разрешения
                    System.out.println(threadName + " ------захватил разрешение");
                    Thread.sleep(1000);
                    System.out.println(threadName + " --освободил разрешение");
                    regularSemaphore.release(); // освободил разрешение
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
              
                return "Thread " + threadName + " done";

            });
        } 
        
        try {
            results = es.invokeAll(tasks);
        } catch (InterruptedException ie) {
            ie.printStackTrace();
        }
        es.shutdown();

    }


}
