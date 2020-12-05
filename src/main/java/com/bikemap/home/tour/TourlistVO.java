package com.bikemap.home.tour;

public class TourlistVO {

	private int noboard;
	private String title;
	private String userid;
	private String deadline;
	private String departure;
	private String arrive;
	private int room;
	private int party;
	private int que;
	private int margin; // 잔여 인원
	private String state;
	
	public int getNoboard() {
		return noboard;
	}
	public String getTitle() {
		return title;
	}
	public String getUserid() {
		return userid;
	}
	public String getDeadline() {
		return deadline;
	}
	public String getDeparture() {
		return departure;
	}
	public String getArrive() {
		return arrive;
	}
	public int getRoom() {
		return room;
	}
	public int getParty() {
		return party;
	}
	public int getQue() {
		return que;
	}
	public String getState() {
		return state;
	}
	public void setNoboard(int noboard) {
		this.noboard = noboard;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public void setDeparture(String departure) {
		this.departure = departure;
	}
	public void setArrive(String arrive) {
		this.arrive = arrive;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public void setParty(int party) {
		this.party = party;
	}
	public void setQue(int que) {
		this.que = que;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getMargin() {
		return margin;
	}
	public void setMargin(int margin) {
		this.margin = margin;
	}
}
