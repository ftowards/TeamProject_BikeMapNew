package com.bikemap.home.admin;

public class AdminSuspendVO {
	private String userid;
	private int endday;
	private String enddayStr;
	private String cause;
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getEndday() {
		
		return endday;
	}
	public void setEndday(int endday) {
		this.endday = endday;
	}
	
	
	public String getCause() {
		return cause;
	}
	public void setCause(String cause) {
		this.cause = cause;
	}
	public String getEnddayStr() {
		return enddayStr;
	}
	public void setEnddayStr(String enddayStr) {
		this.enddayStr = enddayStr;
	}
	
	
}
