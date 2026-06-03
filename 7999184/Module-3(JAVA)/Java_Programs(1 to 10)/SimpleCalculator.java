/* Task 2 - Simple Calculator */

import java.util.Scanner;
public class SimpleCalculator {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter first number: ");
        double num1 = sc.nextDouble();

        System.out.print("Enter second number: ");
        double num2 = sc.nextDouble();

        System.out.println("Addition = " + (num1 + num2));
        System.out.println("Subtraction = " + (num1 - num2));
        System.out.println("Multiplication = " + (num1 * num2));

        if(num2 != 0) {
            System.out.println("Division = " + (num1 / num2));
        } else {
            System.out.println("Cannot divide by zero");
        }
        sc.close();
    }
}