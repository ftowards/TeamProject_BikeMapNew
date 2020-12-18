package com.bikemap.home.mailng;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailHandler {
	private JavaMailSender mailSender ;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;
	
	public MailHandler(JavaMailSender mailSender) throws MessagingException{
		this.mailSender = mailSender;		
		message = this.mailSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	}
	
	// 이메일 제목 설정
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}
	
	// 이메일 본문 설정
	public void setText(String htmlContent) throws MessagingException {
		messageHelper.setText(htmlContent, true);
	}
	
	// 보내는 사람 이메일 / 사이트 관리자 계정?
	public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException{
		messageHelper.setFrom(email, name);
	}

	// 받는 사람 이메일
	public void setTo(String email) throws MessagingException{
		messageHelper.setTo(email);
	}
	
	public void addInLine(String contentId, DataSource dataSource) throws MessagingException{
		messageHelper.addInline(contentId, dataSource);
	}
	
	public void setInline(String contentId, String pathToInline) throws MessagingException, IOException {
        File file = new File(pathToInline);
        FileDataSource fsr = new FileDataSource(file);

        messageHelper.addInline(contentId, fsr);
    }
	
	public void send() throws FileNotFoundException, MessagingException {
		try {
			mailSender.send(message);
		}catch (Exception e) {
			System.out.println("메일 보내기 에러" + e.getMessage());
		}
	}
}