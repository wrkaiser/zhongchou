package com.xiaoyou.util;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.SocketException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.event.EventListenerList;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.log4j.Logger;
import org.apache.struts.upload.FormFile;

public class GFtpClient{
	private Logger loger = Logger.getLogger(GFtpClient.class);
	
	private  static final String ip="60.209.7.54";  //27.50.133.219
	
	private  static final   String uname="houftp";  //cdc001
	
	private   static final  String pwd="ftphou";  //cdc
	
	private EventListenerList eventListenerList = new EventListenerList();
	private FTPClient client;
  
	public GFtpClient() {
		client = new FTPClient();
	}

	public void connect() throws SocketException, IOException {
		client.connect(ip, 21);
	}
	
	public void connect(String ip,int port) throws SocketException, IOException {
		client.connect(ip, port);
	}

	public boolean login() throws IOException {
		return client.login(uname, pwd);
	}
	
	public boolean login(String username, String password) throws IOException {
		return client.login(username, password);
	}

	public boolean logout() throws IOException {
		return client.logout();
	}

	public int quit() throws IOException {
		return client.quit();
	}

	public String sendFile(FormFile file, String to, boolean binary, HttpServletRequest req, HttpServletResponse res) throws IOException {
		String status = "";
		client.enterLocalPassiveMode();
		if (binary)
			client.setFileType(client.BINARY_FILE_TYPE);
		
		
		String result;
		//对远程目录的处理
		String remoteFileName =to;
		
		//对远程目录的处理
			if(to.contains("/")){
				String directory = to.substring(0,to.lastIndexOf("/")+1);
				System.out.println("check-dir:"+directory);
				if(!directory.equalsIgnoreCase("/")&&!client.changeWorkingDirectory(directory)){
					//如果远程目录不存在，则递归创建远程服务器目录
					int start=0;
					int end = 0;
					if(directory.startsWith("/")){
						start = 1;
					}else{
						start = 0;
					}
					end = directory.indexOf("/",start);
					while(true){
						String subDirectory = to.substring(start,end);
						if(!client.changeWorkingDirectory(subDirectory)){
							if(client.makeDirectory(subDirectory)){
								client.changeWorkingDirectory(subDirectory);
								System.out.println("change-dir:"+subDirectory);
								
							}else {
								System.out.println("创建目录失败");
								loger.error("创建目录失败");
								return FileUploadStatus.Create_Directory_Fail;
							}
						}
						
						start = end + 1;
						end = directory.indexOf("/",start);
						
						//检查所有目录是否创建完毕
						if(end <= start){
							break;
						}
					}
				}
			}
		
		
		
		//检查远程是否存在文件
		FTPFile[] files = client.listFiles(remoteFileName);
		
		int n = -1;
		long trans = 0;
		//File _file = new File(file);
		long localSize = file.getFileSize();
		client.setBufferSize(1024*4);
		int bufferSize = client.getBufferSize();
		byte[] buffer = new byte[bufferSize];
		TransforEventListener[] listeners = eventListenerList.getListeners(TransforEventListener.class);
		//尝试移动文件内读取指针,实现断点续传
		InputStream is = file.getInputStream();
		
		
		if(files.length == 1){
			
			long remoteSize = files[0].getSize();
			
			if(remoteSize==localSize){
				return FileUploadStatus.File_Exits;
			}else if(remoteSize > localSize){
				return FileUploadStatus.Remote_Bigger_Local;
			}
			
			
			if(is.skip(remoteSize)==remoteSize){
				trans =remoteSize;
				
				FileInputStream fileInputStream = (FileInputStream)is;
				fileInputStream.skip(remoteSize);
				client.setRestartOffset(remoteSize);
				OutputStream outputstream = client.storeFileStream(to);
				int j = 0;
				while ((n = fileInputStream.read(buffer)) != -1) {
					outputstream.write(buffer);
					trans += n;
					j++;
					if(j%10==0){
						for (int i = listeners.length -1; i >= 0  ; i--) {
							listeners[i].update(req, res, to, trans, localSize);
						}
					}
					  
					
				}
				fileInputStream.close();
				outputstream.flush();
				outputstream.close();
				
				for (int i = listeners.length -1; i >= 0  ; i--) {
					listeners[i].update(req,res,to,trans, localSize);
				}
				return FileUploadStatus.Upload_From_Break_Success;
			}
			
			//如果断点续传没有成功，则删除服务器上文件，重新上传
			
			if(!client.deleteFile(remoteFileName)){
				this.loger.error("删除目录文件失败");
				return FileUploadStatus.Delete_Remote_Faild;
			}
			
		}
		
		FileInputStream fileInputStream = (FileInputStream)is;
		OutputStream outputstream = client.storeFileStream(to);
		int j = 0;
		while ((n = fileInputStream.read(buffer)) != -1) {
			outputstream.write(buffer);
			trans += n;
			
			j++;
			if(j%10==0){
			for (int i = listeners.length -1; i >= 0  ; i--) {
				listeners[i].update(req,res,to,trans, localSize);
			}
			}
		}
		fileInputStream.close();
		outputstream.flush();
		outputstream.close();
			
		  for (int i = listeners.length -1; i >= 0  ; i--) {
				listeners[i].update(req,res,to,trans, localSize);
			}
        result = FileUploadStatus.Upload_New_File_Success;
      
        return status;
	}

	public void addListener(TransforEventListener l) {
		eventListenerList.add(TransforEventListener.class, l);
	}

	public void removeListener(TransforEventListener l) {
		eventListenerList.remove(TransforEventListener.class, l);
	}

	public static int getprogressBarint(double sum, double num)
     {
         double x = sum / 100;
         double barint = 0;

         barint = num / x;

         return (int)barint;
     }
	
		/*GFtpClient myFtp = new GFtpClient();
		myFtp.addListener(new TransforEventListener() {
			
			@Override
			public void update(long send, long size) {
				System.out.println("send:"+send+"-size:"+size+":"+getprogressBarint(size,send));
			}
		});
		try {
			myFtp.connect("27.50.133.219", 21);
			
			boolean islogin = myFtp.login("cdc001", "cdc");
			if(islogin){
			String status =	myFtp.sendFile("D:\\os\\b\\chybflb003-test.mp4", "/chybflb003-test.mp4", true);
			System.out.println(status);
				myFtp.logout();
			}else{
				System.out.println("登陆失败");
			}
			
		} catch (IOException e) {
			System.out.println("连接FTP出错："+e.getMessage());
		}catch(Exception e){
			e.printStackTrace();	
		}*/
	
}