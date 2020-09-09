package iit.lims.util;

// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   AlertApi.java

import java.io.*;
import java.net.Socket;

public class AlertApi extends Thread {

	public AlertApi(String s, int i) {
		strSnd = "";
		ip = "";
		port = 0;
		ip = s;
		port = i;
	}

	public void MakePacket(String s, String s1, int i, String s2, String s3, String s4) {
		boolean flag = false;
		String s5 = "";
		String s6 = Integer.toString(i);
		int k = 4 - s6.length();
		for (int j = 0; j < k; j++)
			s5 = s5 + "0";

		s5 = s5 + s6;
		strSnd = "N" + s + s1 + "^" + s5 + s2 + "^" + s3 + "^" + s4 + "\f\f";
		//System.out.println(strSnd);
	}

	public void SetPacket(String s) {
		strSnd = s;
	}

	public void SendPacket() {
		start();
	}

	public void run() {
		Socket socket = null;
		PrintWriter printwriter = null;
		char c = '\u2710';
		try {
			socket = new Socket(ip, port);
			socket.setSoTimeout(c);
			printwriter = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()));
			System.out.println(strSnd);
			printwriter.println(strSnd);
			printwriter.flush();
		} catch (Exception exception) {
			System.err.println(exception);
		} finally {
			try {
				printwriter.close();
				printwriter = null;
			} catch (Exception exception2) {
			}
			try {
				socket.close();
				socket = null;
			} catch (Exception exception3) {
			}
		}
	}

	private String strSnd;
	private String ip;
	private int port;
}
