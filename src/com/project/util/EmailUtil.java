package com.project.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

	public void sendWelcomeEmail(String to,String tempwd,String name) {
		
        final String username = "fagunthakkar13@gmail.com";
        final String password = "pbyialhmflntpzho";

        Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS
        
        Session session = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("fagunthakkar13@gmail.com"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );
            message.setSubject("Welcome Email");
            message.setText("Hello "+name+", "
                    + "\n\n Welcome to NTSS. Here is your temporary password.\n\n"+tempwd+"\n\n You need to change it after first login.");

            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            e.printStackTrace();
        }

		
	}

public void sendPaymentConfirmationEmail(String to,String name) {
		
        final String username = "fagunthakkar13@gmail.com";
        final String password = "pbyialhmflntpzho";

        Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS
        
        Session session = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("fagunthakkar13@gmail.com"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );
            message.setSubject("Payment Confirmation Email");
            message.setText("Hello "+name+", "
                    + "\n\n This email is regarding payment confirmation. Your payment has been recieved. Your Application is Pending for Review. ");

            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            e.printStackTrace();
        }

		
	}

public void sendStatuChangeEmail(String to,String status,String feedback,String name) {
	
    final String username = "fagunthakkar13@gmail.com";
    final String password = "pbyialhmflntpzho";

    Properties prop = new Properties();
	prop.put("mail.smtp.host", "smtp.gmail.com");
    prop.put("mail.smtp.port", "587");
    prop.put("mail.smtp.auth", "true");
    prop.put("mail.smtp.starttls.enable", "true"); //TLS
    
    Session session = Session.getInstance(prop,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

    try {

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("fagunthakkar13@gmail.com"));
        message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(to)
        );
        message.setSubject("Event Proposal Review");
        message.setText("Hello "+name+", "
                + "\n\n Your Event proposal has been reviewed by NTSS Staff. "+
        		"\\n\n Status : "+status+
        		"\\n\n Feedback :"+feedback+
        		"\\n\n You can review same thing on protal as well.");

        Transport.send(message);

        System.out.println("Done");

    } catch (MessagingException e) {
        e.printStackTrace();
    }

	
}

public void sendPaymentEmail(String to,String paymentamt,String url,String name) {
	
    final String username = "fagunthakkar13@gmail.com";
    final String password = "pbyialhmflntpzho";

    Properties prop = new Properties();
	prop.put("mail.smtp.host", "smtp.gmail.com");
    prop.put("mail.smtp.port", "587");
    prop.put("mail.smtp.auth", "true");
    prop.put("mail.smtp.starttls.enable", "true"); //TLS
    
    Session session = Session.getInstance(prop,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

    try {

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("fagunthakkar13@gmail.com"));
        message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(to)
        );
        message.setSubject("Payment Email");
        message.setText("Hello "+name+", "
                + "\n\n Your payment information is here. Remaining balance to pay is $"+paymentamt+"\n\n You can pay by login into portal or using this url."+url);

        Transport.send(message);

        System.out.println("Done");

    } catch (MessagingException e) {
        e.printStackTrace();
    }

	
}

}
