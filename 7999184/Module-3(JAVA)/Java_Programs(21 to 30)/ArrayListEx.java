/* Task 24 - ArrayList Example */

import java.util.ArrayList;
import java.util.Scanner;

public class ArrayListEx {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        ArrayList<String> students = new ArrayList<>();
        System.out.print("How many students? ");
        int n = sc.nextInt();
        sc.nextLine();
        for (int i = 0; i < n; i++) {
            System.out.print("Enter name: ");
            String name = sc.nextLine();
            students.add(name);
        }
        System.out.println("Student Names:");
        for (String name : students) {
            System.out.println(name);
        }
    }
}
