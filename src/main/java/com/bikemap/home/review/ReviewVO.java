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
	private int thumbup;
	private int thumbdown;
	
	private int thumbType;
	
	private String scrap;
	
	private String thumbnailImg ; 


	public int getThumbup() {
		return thumbup;
	}
	public void setThumbup(int thumbup) {
		this.thumbup = thumbup;
	}
	public int getThumbdown() {
		return thumbdown;
	}
	public void setThumbdown(int thumbdown) {
		this.thumbdown = thumbdown;
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
		if(content != null && content.indexOf(" src=") > 0 && content.indexOf(" srcset=") > content.indexOf(" src=") ) {
			thumbnailImg = content.substring(content.indexOf(" src=")+6, content.indexOf(" srcset=")-1);
		}else {
			// 썸네일 없을 때 이미지 설정
		}
		return thumbnailImg;
	}
	public void setThumbnailImg(String thumbnailImg) {
		this.thumbnailImg = thumbnailImg;
	}
	public int getThumbType() {
		return thumbType;
	}
	public void setThumbType(int thumbType) {
		this.thumbType = thumbType;
	}
}
