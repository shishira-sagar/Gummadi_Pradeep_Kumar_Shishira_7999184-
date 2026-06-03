/* Task 32 - Insert and Update Operations in JDBC */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class StudentDAO {
    public static void main(String[] args) {
        try {
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/studentdb",
                    "root",
                    "password");
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO students(id,name) VALUES(?,?)");
            ps.setInt(1, 1);
            ps.setString(2, "Ravi");
            ps.executeUpdate();
            PreparedStatement ps2 = con.prepareStatement("UPDATE students SET name=? WHERE id=?");
            ps2.setString(1, "Kiran");
            ps2.setInt(2, 1);
            ps2.executeUpdate();
            System.out.println("Insert and Update Successful");
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

/* Create Database(we probably have it as we did in previous task) and table then connect the sql run these queries

CREATE DATABASE studentdb;

USE studentdb;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO students(id,name) VALUES(1,'Ravi');

UPDATE students SET name='Kiran' WHERE id=1; */


/* output will be this:
mysql> INSERT INTO students(id,name) VALUES(1,'Ravi');
Query OK, 1 row affected (0.01 sec)

mysql> UPDATE students SET name='Kiran' WHERE id=1;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0 */
