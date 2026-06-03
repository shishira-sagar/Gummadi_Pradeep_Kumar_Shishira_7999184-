/* Task 12 - Method Overloading */

public class MethodOverloading {

    static int add(int a, int b) {
        return a + b;
    }

    static double add(double a, double b) {
        return a + b;
    }

    static int add(int a, int b, int c) {
        return a + b + c;
    }

    public static void main(String[] args) {

        System.out.println("Sum of 10 and 20 = " + add(10, 20));

        System.out.println("Sum of 10.5 and 20.5 = " + add(10.5, 20.5));

        System.out.println("Sum of 10, 20 and 30 = " + add(10, 20, 30));
    }
}