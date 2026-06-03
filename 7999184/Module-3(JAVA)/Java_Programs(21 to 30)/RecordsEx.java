/* Task 29 - Records */

import java.util.ArrayList;
import java.util.List;
record Person(String name, int age) {}
public class RecordsEx {
    public static void main(String[] args) {
        List<Person> people = new ArrayList<>();
        people.add(new Person("Ravi", 20));
        people.add(new Person("Anil", 17));
        people.add(new Person("Kiran", 22));
        System.out.println("People age 18 and above:");
        people.stream()
              .filter(p -> p.age() >= 18)
              .forEach(System.out::println);
    }
}