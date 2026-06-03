/* Task 39 - Reflection in Java */

import java.lang.reflect.Method;
class Student {
    public void show() {
        System.out.println("Student Method Called");
    }
}

public class ReflectionEg {
    public static void main(String[] args) {
        try {
            Class<?> cls = Class.forName("Student");
            Method[] methods = cls.getDeclaredMethods();
            for (Method m : methods) {
                System.out.println("Method Name: " + m.getName());
            }
            Object obj = cls.getDeclaredConstructor().newInstance();
            Method method = cls.getDeclaredMethod("show");
            method.invoke(obj);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}