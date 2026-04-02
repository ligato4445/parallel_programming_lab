package lab5;

import java.util.concurrent.Semaphore;
import java.util.concurrent.atomic.AtomicInteger;

public class lab5_mySemaphore extends Semaphore {
    
    private final AtomicInteger permits;
    private static final int MAX_SPINS = 1000;

    public lab5_mySemaphore(int initialPermits) {
        super(initialPermits);
        this.permits = new AtomicInteger(initialPermits);
    }

    @Override
    public void acquire() throws InterruptedException {
        int spins = 0;
        
        while (true) {
            int current = permits.get();
            
            if (current > 0 && permits.compareAndSet(current, current - 1)) {
                return;
            }
            
            spins++;
            if (spins > MAX_SPINS) {
                Thread.onSpinWait();
                spins = 0;
            }
            
            if (Thread.interrupted()) {
                throw new InterruptedException();
            }
        }
    }

    @Override
    public void release() {
        permits.incrementAndGet();

    }

    @Override
    public int availablePermits() {
        return permits.get();
    }
}