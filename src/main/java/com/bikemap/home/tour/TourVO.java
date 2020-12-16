package com.bikemap.home.tour;

public class TourVO {
	private int noboard;
	private String title;
	private String userid;
	private int reference;
	private String content;
	private String deadline;
		private String deadlinedate;
		private String deadlineTime;
	private String departure;
		private String departuredate;
		private String departureTime;
	private String arrive;
		private String arrivedate;
		private String arriveTime;
	private String place;
	private String distance;
	private int speed;
	private int budget;
	private int room;
	private String reggender;
		private boolean genderM ;
		private boolean genderF ;
	private String regage;
		private boolean age10;
		private boolean age20;
		private boolean age30;
		private boolean age40;
		private boolean age50;
	private String writedate;
	private String state;
	private String ip;
	private String scrap;
	
	
	
	
	
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getReference() {
		return reference;
	}
	public void setReference(int reference) {
		this.reference = reference;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDeadline() {
		if(deadlineTime != null && deadlinedate != null) {
			if(deadlineTime.length() == 1) {
				deadlineTime = "0"+deadlineTime;
			}
			deadline = deadlinedate + " " + deadlineTime;
		}
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getDeparture() {
		if(departuredate != null && departureTime != null) {
			if(departureTime.length() == 1) {
				departureTime = "0"+departureTime;
			}
			departure = departuredate + " "+ departureTime;
		}
		return departure;
	}
	public void setDeparture(String departure) {
		this.departure = departure;
	}
	public String getArrive() {
		if(arrivedate != null && arriveTime != null) {
			if(arriveTime.length() == 1) {
				arriveTime = "0"+arriveTime;
			}
			arrive = arrivedate + " " + arriveTime;
		}
		return arrive;
	}
	public void setArrive(String arrive) {
		this.arrive = arrive;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getDistance() {
		return distance;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}
	public int getSpeed() {
		return speed;
	}
	public void setSpeed(int speed) {
		this.speed = speed;
	}
	public int getBudget() {
		return budget;
	}
	public void setBudget(int budget) {
		this.budget = budget;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public String getReggender() {
		return reggender;
	}
	public void setReggender(String reggender) {
		this.reggender = reggender;
	}
	public String getRegage() {
		return regage;
	}
	public void setRegage(String regage) {
		this.regage = regage;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getDeadlinedate() {
		if(deadline == null) {return null;}
		return deadline.substring(0, deadline.indexOf(" "));
	}
	public void setDeadlinedate(String deadlinedate) {		
		this.deadlinedate = deadlinedate;
	}
	public String getDeadlineTime() {
		if(deadline == null) {return null;}
		return deadline.substring(deadline.indexOf(" "));
	}
	public void setDeadlineTime(String deadlineTime) {
		this.deadlineTime = deadlineTime;
	}
	public String getDeparturedate() {
		if(departure == null) {return null;}
		try {
			return departure.substring(0, departure.indexOf(" "));}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	public void setDeparturedate(String departuredate) {
		this.departuredate = departuredate;
	}
	public String getDepartureTime() {
		if(departure == null) {return null;}
		try {
			return departure.substring(departure.indexOf(" "));
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}
	public String getArrivedate() {
		if(arrive == null) {return null;}
		
		try {
			return arrive.substring(0, arrive.indexOf(" "));
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	public void setArrivedate(String arrivedate) {
		this.arrivedate = arrivedate;
	}
	public String getArriveTime() {
		if(arrive == null) {return null;}
		try {
			return arrive.substring(arrive.indexOf(" "));
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return null;

	}
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}
	public boolean getGenderM() {
		if(reggender != null  && reggender.indexOf("1") > -1) {
			genderM = true;
			}
		return genderM;
	}
	public boolean getGenderF() {
		if(reggender != null  && reggender.indexOf("2") > -1) {
			genderF = true;
		}
		return genderF;
	}
	public boolean getAge10() {
		if(regage != null && regage.indexOf("1") > -1) {
			age10 = true;
		}
		return age10;
	}
	public boolean getAge20() {
		if(regage != null &&regage.indexOf("2") > -1) {
			age20 = true;
		}
		return age20;
	}
	public boolean getAge30() {
		if(regage != null &&regage.indexOf("3") > -1) {
			age30 = true;
		}
		return age30;
	}
	public boolean getAge40() {
		if(regage != null &&regage.indexOf("4") > -1) {
			age40 = true;
		}
		return age40;
	}
	public boolean getAge50() {
		if(regage != null &&regage.indexOf("5") > -1) {
			age50 = true;
		}
		return age50;
	}

	
	
}