/* Task 7 - Type Casting Example */

public class TypeCastingEg {
    public static void main(String[] args) {

        double num1 = 10.75;
        int num2 = (int) num1;

        System.out.println("Double Value = " + num1);
        System.out.println("Converted to Int = " + num2);

        int num3 = 25;
        double num4 = num3;

        System.out.println("Int Value = " + num3);
        System.out.println("Converted to Double = " + num4);
    }
}