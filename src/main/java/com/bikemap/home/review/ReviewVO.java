package com.bikemap.home.review;

public class ReviewVO {

	private int noboard;
	private String subject;
	private String userid;
	private String content;
	private int reference;
	private int hit;
	private String writedate;
	private String ip;
	
	//1203 최병대 추가
	private int thumbUp;
	private int thumbDown;
	private String scrap;
	
	private String thumbnailImg ; 
	

	public int getThumbUp() {
		return thumbUp;
	}
	public void setThumbUp(int thumbUp) {
		this.thumbUp = thumbUp;
	}
	public int getThumbDown() {
		return thumbDown;
	}
	public void setThumbDown(int thumbDown) {
		this.thumbDown = thumbDown;
	}
	public String getScrap() {
		return scrap;
	}
	public void setScrap(String scrap) {
		this.scrap = scrap;
	}
	public int getNoboard() {
		return noboard;
	}
	public void setNoboard(int noboard) {
		this.noboard = noboard;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReference() {
		return reference;
	}
	public void setReference(int reference) {
		this.reference = reference;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getThumbnailImg() {
		if(content != null) {
			thumbnailImg = content.substring(content.indexOf(" src=")+6, content.indexOf(" srcset=")-1);
		}
		System.out.println(thumbnailImg);
		return thumbnailImg;
	}
	
	
	public void setThumbnailImg(String thumbnailImg) {
		this.thumbnailImg = thumbnailImg;
	}
}
