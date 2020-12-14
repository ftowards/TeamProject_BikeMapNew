package com.bikemap.home.admin;

public class AdminPagingVO {
	
	private int nowPage = 1;
	private int totalRecord ;
	private int totalPage ;
	private int onePageRecord = 10; // 한 페이지에 표시할 레코드 숫자
	private int onePageNumCount = 5; // 한 번에 표시할 페이지 숫자
	private int startPageNum = 1; //시작할 페이지 숫자
	private int lastPageRecordCount; // 마지막 페이지 레코드 숫자
	
	private String searchType;
	private String searchWord;
	private String type;
	
	private String order = "noboard" ; // 아니면 "rating"
	private String answer ;
	private String state;
	
	
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
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
		
		setStartPageNum((nowPage-1)/onePageNumCount*onePageNumCount+1);
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	//전체 레코드 구하기
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		setTotalPage(); //전체 페이지 수를 구해온다.
		if(nowPage != totalPage) {//현재페이지가 마지막페이지가 아니면 
			lastPageRecordCount = onePageRecord; //마지막 페이지의 레코드 수는 동일하다.
		}else if(totalRecord%onePageRecord == 0) {
			lastPageRecordCount = onePageRecord; //마지막 페이지의 레코드 수도 동일하다.
		}else {
			lastPageRecordCount = totalRecord%onePageRecord; //현재페이지가 마지막 페이지면 전체 레코드%한페이지 들어갈 레코드수
		}
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage() {
		this.totalPage = (int)Math.ceil((double)totalRecord / onePageRecord);
		System.out.println(totalPage);
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
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
}
