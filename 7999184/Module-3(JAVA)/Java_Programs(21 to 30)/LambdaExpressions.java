/* Task 27 - Lambda Expressions */

import java.util.ArrayList;
import java.util.Collections;
public class LambdaExpressions {
    public static void main(String[] args) {
        ArrayList<String> names = new ArrayList<>();
        names.add("Ravi");
        names.add("Anil");
        names.add("Kiran");
        names.add("Bhanu");

        Collections.sort(names, (a, b) -> a.compareTo(b));
        System.out.println("Sorted List:");
        for (String name : names) {
            System.out.println(name);
        }
    }
}
