/* Task 30 - Pattern Matching for Switch */

public class PatternMatchingSwitch {
    public static void checkType(Object obj) {

        if (obj instanceof Integer) {
            System.out.println("Integer Value: " + obj);
        } else if (obj instanceof String) {
            System.out.println("String Value: " + obj);
        } else if (obj instanceof Double) {
            System.out.println("Double Value: " + obj);
        } else {
            System.out.println("Unknown Type");
        }
    }

    public static void main(String[] args) {
        checkType(100);
        checkType("Hello");
        checkType(10.5);
    }
}