/* Task 31 - Basic JDBC Connection */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class BasicJDBCConnection {
    public static void main(String[] args) {
        try {
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/studentdb",
                    "root",
                    "password");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM students");
            while (rs.next()) {
                System.out.println(
                        rs.getInt("id") + " " +
                        rs.getString("name"));
            }
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

/* Creating Database for task-30 in java
CREATE DATABASE studentdb;

-- Using Db
USE studentdb;

-- Creating Table
CREATE TABLE students (
    id INT,
    name VARCHAR(50)
);

-- Inserting Data into created Table
INSERT INTO students VALUES (10094,'Shishu');
INSERT INTO students VALUES (10095,'Soni');
INSERT INTO students VALUES (10096,'Naini');

-- Verifying Data
SELECT * FROM students;// Use only this command for table output

-- To execute the mysql in vscode i did it via connecting my vscode to mysql for that i used something like:
-- mysql -u root -p
-- then use your sql root password. */