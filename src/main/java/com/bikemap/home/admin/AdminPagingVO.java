package com.bikemap.home.admin;

public class AdminPagingVO {
	
	private int nowPage = 1;
	private int totalRecord ;
	private int totalPage ;
	private int onePageRecord = 10; // 한 페이지에 표시할 레코드 숫자
	private int onePageNumCount = 5; // 한 번에 표시할 페이지 숫자
	private int startPageNum = 1;
	private int lastPageRecordCount = 6; // 마지막 페이지 레코드 숫자
	
	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
		
		setStartPageNum((nowPage-1)/onePageNumCount*onePageNumCount+1);
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	//전체 레코드 구하기
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		setTotalPage();
		if(nowPage != totalPage) {
			lastPageRecordCount = onePageRecord;
			
		}else if(totalRecord%onePageRecord == 0) {
			lastPageRecordCount = onePageRecord;
		}else {
			lastPageRecordCount = totalRecord%onePageRecord;
		}
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage() {
		this.totalPage = (int)Math.ceil((double)totalRecord / onePageRecord);
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
	
	
	
	
	
}