package com.bikemap.home.admin;

public class AdminQnaVO {
	private int noqna;
	private String userid;
	private String subject;
	private String writedate;
	private String answer;// Y/N
	
	private String content;
	private String answercontent;
	
	private String noqnatype;
	private String typename;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getNoqna() {
		return noqna;
	}
	public void setNoqna(int noqna) {
		this.noqna = noqna;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAnswercontent() {
		return answercontent;
	}
	public void setAnswercontent(String answercontent) {
		this.answercontent = answercontent;
	}
	public String getNoqnatype() {
		return noqnatype;
	}
	public void setNoqnatype(String noqnatype) {
		this.noqnatype = noqnatype;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	
}
