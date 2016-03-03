package com.xiaoyou.util;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailService
{


  public static void sendemail(String inputSubject, String inputContent, String email)
    throws AddressException, MessagingException
  {
	    Properties props = new Properties();
	    props.setProperty("mail.smtp.auth", "true");
	    props.setProperty("mail.transport.protocol", "smtp");
	    Session session = Session.getDefaultInstance(props);
	    session.setDebug(true);
	    Message msg = new MimeMessage(session);
	    msg.setFrom(new InternetAddress("admin@alumninet.net"));
	    msg.setSubject(inputSubject);
	    msg.setContent(inputContent, "text/html;charset=utf-8");
	    Transport transport = session.getTransport();

	    transport.connect("smtp.ym.163.com", 25, "admin@alumninet.net", 
	      "cdc123456");
	    transport.sendMessage
	      (msg, new Address[] { new InternetAddress(email) });

	    transport.close();
  }

  
  
 
}