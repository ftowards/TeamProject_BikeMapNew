package com.bikemap.home.admin;

public class AdminSearchVO extends AdminPagingVO {
	private String searchType;
	private String searchWord;
	
	
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
	
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType +", searchWord="+ searchWord + "]";
	}
}
