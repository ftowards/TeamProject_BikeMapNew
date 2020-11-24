package com.bikemap.home.route;

import java.util.List;

public interface RouteDaoImp {
	
	/// 루트 카테고리 ///// 
	// 코스 카테고리 읽어오기
	public List<RouteCateVO> selectCategory(String userid);

	// 회원 가입 시 기본 카테고리 추가
	public int insertBasicCategory(String userid);
	
	// 코스 카테고리 추가
	public int insertCategory(RouteCateVO vo);
	
	// 코스 카테고리 삭제
	public int delCategory(int nocoursecate);
	
	/// 루트 /////////////
	// 루트 추가
	public int insertRoute(RouteVO vo);

	// 루트 마지막 번호 얻어오기
	public int lastRouteNo(String userid);
	
	// 루트 한개 읽기
	public RouteVO selectRoute(int noroute);
	
	/// 루트 리스트 ////////
	// 루트 저장 후 리스트에 추가하기
	public int insertRouteList(RouteListVO vo);
	
	/// 루트 플레이스 ///////
	// 루트 저장 후 장소 리스트 저장하기
	public int insertRoutePlaceList(RoutePlaceVO vo);
	
	// 루트 한 개의 장소 리스트 읽기
	public RoutePlaceVO selectRoutePlace(int noroute);
}
