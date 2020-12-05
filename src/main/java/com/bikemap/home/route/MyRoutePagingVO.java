package com.bikemap.home.route;

public class MyRoutePagingVO {
	
	private int nowPage = 1;
	private int totalRecord ;
	private int totalPage ;
	private int onePageRecord = 8; // 한 페이지에 표시할 레코드 숫자
	private int onePageNumCount = 5; // 한 번에 표시할 페이지 숫자
	private int startPageNum = 1;
	private int lastPageRecordCount = 8; // 마지막 페이지 레코드 숫자
	
	private int noroutecate =0;
	private String userid;
	private String order = "noboard" ; // 아니면 "rating"
	
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
	public int getNoroutecate() {
		return noroutecate;
	}
	public void setNoroutecate(int noroutecate) {
		this.noroutecate = noroutecate;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
}