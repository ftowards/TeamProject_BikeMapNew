package com.bikemap.home.review;

public class ReviewPagingVO {

	private int nowPage = 1;
	private int totalRecord ;
	private int totalPage ;
	private int onePageRecord = 5; // 한 페이지에 표시할 레코드 숫자
	private int onePageNumCount = 5; // 한 번에 표시할 페이지 숫자
	private int startPageNum = 1;
	private int lastPageRecordCount = 8; // 마지막 페이지 레코드 숫자
	
	private String searchType;
	private String searchWord;
	private String Type ; 


	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getType() {
		return Type;
	}

	public void setType(String type) {
		Type = type;
	}
	
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
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

}