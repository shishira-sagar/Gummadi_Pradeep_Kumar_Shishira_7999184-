/* Task 33 - Transaction Handling in JDBC */

import java.sql.*;
public class TransactionHandling {
    public static void main(String[] args) {
        Connection con = null;
        try {
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/bankdb",
                    "root",
                    "1234");
            con.setAutoCommit(false);

            PreparedStatement debit = con.prepareStatement("UPDATE accounts SET balance = balance - 500 WHERE id = 1");

            PreparedStatement credit = con.prepareStatement("UPDATE accounts SET balance = balance + 500 WHERE id = 2");

            debit.executeUpdate();
            credit.executeUpdate();
            con.commit();
            System.out.println("Transaction Successful");

        } catch (Exception e) {
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                System.out.println(ex);
            }
            System.out.println("Transaction Failed: " + e);
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }
}