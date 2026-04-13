package lab6;
import java.io.*;
import java.net.*;
import java.util.Scanner;

public class client {
    private static final String SERVER_ADDRES ="localhost";
    private static final int SERVER_PORT = 12346;
    public static void main(String[] args){
        try{
            Socket socket = new Socket(SERVER_ADDRES, SERVER_PORT);
            System.out.println("Connected to the chat server");

            PrintWriter out  = new PrintWriter(socket.getOutputStream(), true);
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));

            new Thread(() -> {
                try{
                    String serverResponse;
                    while ((serverResponse = in.readLine()) != null ) {
                        System.out.println(serverResponse);
                    }
                }catch(IOException e){
                    e.printStackTrace();
                }
            }).start();

            Scanner scanner = new Scanner(System.in);
            String userInput;
            while (true) {
                userInput = scanner.nextLine();
                out.println(userInput);
            }

        }catch(IOException e) {
            e.printStackTrace();
        }
    }

}
