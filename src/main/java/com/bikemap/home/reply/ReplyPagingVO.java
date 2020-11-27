package com.bikemap.home.reply;

public class ReplyPagingVO {
	private int nowPage; // 현재페이지
	private int startPage; //시작페이지
	private int endPage; //끝페이지
	private int totalRecord; //전체 레코드
	private int onePageRecord; //한 페이지에 표시할 레코드 수
	private int lastPage; //마지막 페이지
	
	private int start; //sql에 쓸 start
	private int end; //sql에 쓸 end
	
	private int countPage = 5; //한번에 보여지는 페이지 수

	
	
	public ReplyPagingVO() {
	}
	public ReplyPagingVO(int totalRecord, int nowPage, int onePageRecord) {
		setNowPage(nowPage);
		setonePageRecord(onePageRecord);
		settotalRecord(totalRecord);
		calcLastPage(gettotalRecord(), getonePageRecord());
		calcStartEndPage(getNowPage(), countPage);
		calcStartEnd(getNowPage(), getonePageRecord());
	}
	// 제일 마지막 페이지 계산
	public void calcLastPage(int totalRecord, int onePageRecord) {
		setLastPage((int) Math.ceil((double)totalRecord / (double)onePageRecord));
	}
	// 시작, 끝 페이지 계산
	public void calcStartEndPage(int nowPage, int countPage) {
		setEndPage(((int)Math.ceil((double)nowPage / (double)countPage)) * countPage);
		if (getLastPage() < getEndPage()) {
			setEndPage(getLastPage());
		}
		setStartPage(getEndPage() - countPage + 1);
		if (getStartPage() < 1) {
			setStartPage(1);
		}
	}
	// DB 쿼리에서 사용할 start, end값 계산
	public void calcStartEnd(int nowPage, int onePageRecord) {
		setEnd(nowPage * onePageRecord);
		setStart(getEnd() - onePageRecord + 1);
	}
	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int gettotalRecord() {
		return totalRecord;
	}
	public void settotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getonePageRecord() {
		return onePageRecord;
	}
	public void setonePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}	
	public int setcountPage() {
		return countPage;
	}
	public void getcountPage(int countPage) {
		this.countPage = countPage;
	}
	
	
	@Override
	public String toString() {
		return "PagingVO [nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage + ", totalRecord=" + totalRecord
				+ ", onePageRecord=" + onePageRecord + ", lastPage=" + lastPage + ", start=" + start + ", end=" + end
				+ ", countPage=" + countPage + "]";
	}

}