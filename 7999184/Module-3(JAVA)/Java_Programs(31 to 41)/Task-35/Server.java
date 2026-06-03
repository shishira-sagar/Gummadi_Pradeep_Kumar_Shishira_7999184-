/* Task 35 - TCP Client Server Chat */
//Server

import java.io.*;
import java.net.*;

public class Server {
    public static void main(String[] args) {
        try {
            ServerSocket server = new ServerSocket(5000);
            System.out.println("Waiting for client...");
            Socket socket = server.accept();
            DataInputStream in = new DataInputStream(socket.getInputStream());
            String msg = in.readUTF();
            System.out.println("Client: " + msg);
            socket.close();
            server.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}