package com.bikemap.home.tour;

public class ComplistVO {
	
	private int noboard;
	private String userid;
	private String state;
	
	///////// 리스트 작성용
	
	private int heart;
	private int tourcnt;
	private int age ;
	
	private String gender;
	
	private String eval;
	private String objid;
	
	public int getNoboard() {
		return noboard;
	}
	public void setNoboard(int noboard) {
		this.noboard = noboard;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	public int getHeart() {
		return heart;
	}
	public int getTourcnt() {
		return tourcnt;
	}
	public int getAge() {
		return age;
	}
	public void setHeart(int heart) {
		this.heart = heart;
	}
	public void setTourcnt(int tourcnt) {
		this.tourcnt = tourcnt;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getEval() {
		return eval;
	}
	public void setEval(String eval) {
		this.eval = eval;
	}
	public String getObjid() {
		return objid;
	}
	public void setObjid(String objid) {
		this.objid = objid;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
}
