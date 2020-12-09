package com.bikemap.home.notice;

public class NoticeVO {

	private int nonotice;
	private String userid;
	private String idsend;
	private String msg;
	private String writedate;
	private String read;
	private String type="A";
	
	public int getNonotice() {
		return nonotice;
	}
	public String getUserid() {
		return userid;
	}
	public String getIdsend() {
		return idsend;
	}
	public String getMsg() {
		return msg;
	}
	public String getWritedate() {
		return writedate;
	}
	public String getRead() {
		return read;
	}
	public void setNonotice(int nonotice) {
		this.nonotice = nonotice;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setIdsend(String idsend) {
		this.idsend = idsend;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public void setRead(String read) {
		this.read = read;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
