/* Task 10 - Number Guessing Game */

import java.util.Scanner;
import java.util.Random;

public class NumberGuessingGame {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        Random random = new Random();

        int secretNumber = random.nextInt(100) + 1;
        int guess = 0;

        while (guess != secretNumber) {

            System.out.print("Guess a number between 1 and 100: ");
            guess = sc.nextInt();

            if (guess > secretNumber) {
                System.out.println("Too High");
            }
            else if (guess < secretNumber) {
                System.out.println("Too Low");
            }
            else {
                System.out.println("Correct! You guessed the number.");
            }
        }
        sc.close();
    }
}