package com.bikemap.home.tour;

public class PagingVO {

	private int nowPage = 1;
	private int totalRecord ;
	private int totalPage ;
	private int onePageRecord = 8; // 한 페이지에 표시할 레코드 숫자
	private int onePageNumCount = 5; // 한 번에 표시할 페이지 숫자
	private int startPageNum = 1;
	private int lastPageRecordCount = 8; // 마지막 페이지 레코드 숫자
	
	private String order = "noboard" ;
	
	private int noboard ;

	/// 검색 단
	private String departure;
		private String departuredate;
		private String departureTime;
	private String arrive;
		private String arrivedate;
		private String arriveTime;
	private String place;
	private int distance1;
	private int distance2;
	private String reggender;
	private String regage;

	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
		// 시작 페이지 계산
		setStartPageNum((nowPage-1)/onePageNumCount*onePageNumCount+1);
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		setTotalPage();
		
		if(nowPage != totalPage) {
			lastPageRecordCount = onePageRecord;
		} else if(totalRecord%onePageRecord == 0){
			lastPageRecordCount = onePageRecord;
		} else {
			lastPageRecordCount = totalRecord%onePageRecord;
		}
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage() {
		this.totalPage = (int) Math.ceil((double) totalRecord / onePageRecord);
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getOnePageNumCount() {
		return onePageNumCount;
	}
	public void setOnePageNumCount(int onePageNumCount) {
		this.onePageNumCount = onePageNumCount;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getLastPageRecordCount() {
		return lastPageRecordCount;
	}
	public void setLastPageRecordCount(int lastPageRecordCount) {
		this.lastPageRecordCount = lastPageRecordCount;
	}
	
	public void setDeparture(String departure) {
		this.departure = departure;
	}
	
	public String getDeparture() {
		if(departuredate != null && departureTime != null) {
			if(departureTime.length() == 1) {
				departureTime = "0"+departureTime;
			}
			departure = departuredate+" "+ departureTime;
		}
		return departure;
	}
	
	public String getDeparturedate() {
		return departuredate;
	}
	public void setDeparturedate(String depaturedate) {
		this.departuredate = depaturedate;
	}
	public String getDepartureTime() {
		return departureTime;
	}
	public void setDepartureTime(String depatureTime) {
		this.departureTime = depatureTime;
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
	public String getArrivedate() {
		return arrivedate;
	}
	public void setArrivedate(String arrivedate) {
		this.arrivedate = arrivedate;
	}
	public String getArriveTime() {
		return arriveTime;
	}
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public int getDistance1() {
		return distance1;
	}
	public void setDistance1(int distance1) {
		this.distance1 = distance1;
	}
	public int getDistance2() {
		return distance2;
	}
	public void setDistance2(int distance2) {
		this.distance2 = distance2;
	}
	public String getReggender() {
		if(reggender != null) {
			reggender = reggender.replaceAll(",", "%");
		}
		return reggender;
	}
	public void setReggender(String regender) {
		this.reggender = regender;
	}
	public String getRegage() {
		if(regage != null) {
			regage = regage.replaceAll(",", "%");
		}
		return regage;
	}
	public void setRegage(String regage) {
		this.regage = regage;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public int getNoboard() {
		return noboard;
	}
	public void setNoboard(int noboard) {
		this.noboard = noboard;
	}
}