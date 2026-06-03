/* Task 40 - Virtual Threads */ 

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
public class VirtualThreads {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(100);
        for (int i = 1; i <= 100000; i++) {
            int num = i;
            executor.submit(() -> {
                System.out.println("Task " + num);
            });
        }
        executor.shutdown();
        System.out.println("All Tasks Submitted");
    }
}
