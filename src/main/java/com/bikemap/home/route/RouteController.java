package com.bikemap.home.route;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RouteController {

	public SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	//코스검색
	@RequestMapping("/routeSearch")
	public ModelAndView routeSearch() {
		ModelAndView mav = new ModelAndView();
		RouteDaoImp dao = sqlSession.getMapper(RouteDaoImp.class);
		RoutePagingVO pagingVO = new RoutePagingVO();
		
		try {
			int totalRecord = dao.searchTotalRecord();
			pagingVO.setTotalRecord(totalRecord);
			
			List<RouteVO> list ;
		
			list = dao.selectRouteAll(pagingVO);
			mav.addObject("list", list);
			mav.addObject("pagingVO", pagingVO);
			
		}catch(Exception e) {
			System.out.println("루트 검색 화면 호출 에러 " + e.getMessage());
		}
		
		mav.setViewName("route/routeSearch");
		return mav;
	}
	
	@RequestMapping(value="/searchRouteAll", method= {RequestMethod.POST})
	@ResponseBody
	public List<RouteVO> routeSearchAll(RoutePagingVO pagingVO){
		RouteDaoImp dao = sqlSession.getMapper(RouteDaoImp.class);
		List<RouteVO> list = new ArrayList<RouteVO>();
		
		try {
			int totalRecord = dao.searchResultRecord(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			list = dao.selectRouteAll(pagingVO);
		}catch(Exception e) {
			System.out.println("에러 " + e.getMessage());
		}
		return list;
	}
	
	@RequestMapping(value="/searchRouteOk", method= {RequestMethod.POST})
	@ResponseBody
	public List<RouteVO> routeSearchOk(RoutePagingVO pagingVO){
		RouteDaoImp dao = sqlSession.getMapper(RouteDaoImp.class);
		List<RouteVO> list = new ArrayList<RouteVO>();
		
		try {
			int totalRecord = dao.searchResultRecord(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
			list = dao.selectRouteSearch(pagingVO);
		}catch(Exception e) {
			System.out.println("에러 " + e.getMessage());
		}
		return list;
	}
	
	@RequestMapping(value="/searchRoutePaging", method= {RequestMethod.POST})
	@ResponseBody
	public RoutePagingVO searchRoutePageing(RoutePagingVO pagingVO) {
		System.out.println(pagingVO.getNowPage());
		
		RouteDaoImp dao = sqlSession.getMapper(RouteDaoImp.class);
		try {
			int totalRecord = dao.searchResultRecord(pagingVO);
			pagingVO.setTotalRecord(totalRecord);
			
		}catch(Exception e) {
			System.out.println("에러 " + e.getMessage());
		}
		return pagingVO;
	}

	//코스검색(글보기)
	@RequestMapping("/routeSearchView")
	public ModelAndView routeSearchView(int noboard) {
		ModelAndView mav = new ModelAndView();
		
		RouteDaoImp dao = sqlSession.getMapper(RouteDaoImp.class);
		
		RouteVO vo = dao.selectRoute(noboard);
		RoutePlaceVO placeVO = dao.selectRoutePlace(noboard);
		
		mav.addObject("routeVO", vo);
		mav.addObject("placeVO", placeVO);
		
		mav.setViewName("route/routeSearchView");
		return mav;
	}

	// 코스 만들기 이동
	// 코스 만들기 열 때 내 코스 카테고리 목록 가져가기
	@RequestMapping("/courseMap")
	public ModelAndView routeMap(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		RouteDaoImp routeDao = sqlSession.getMapper(RouteDaoImp.class);
		if(session.getAttribute("logId") != null) {
			String userid  = (String)session.getAttribute("logId");
			List<RouteCateVO> categoryList = routeDao.selectCategory(userid);
			mav.addObject("category", categoryList);
		}
		
		mav.setViewName("route/routeMap");
		return mav;
	}
	
	// 코스 만들기에서 코스 카테고리 추가
	@RequestMapping("/insertCategory")
	@ResponseBody
	public int insertCategory(HttpSession session, RouteCateVO vo) {
		RouteDaoImp routeDao = sqlSession.getMapper(RouteDaoImp.class);
		
		vo.setUserid((String)session.getAttribute("logId"));
		return routeDao.insertCategory(vo);
	}
	
	// 카테고리 리스트 새로 불러오기
	@RequestMapping(value= "/selectCategory")
	@ResponseBody
	public List<RouteCateVO> selectCategory(HttpSession session){
		RouteDaoImp routeDao = sqlSession.getMapper(RouteDaoImp.class);
		String userid  = (String)session.getAttribute("logId");
		
		return routeDao.selectCategory(userid);
	}
	
	@RequestMapping(value="/insertRoute", method= {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public int insertRoute(HttpSession session, RouteVO routeVO, RouteListVO routeListVO, RoutePlaceVO routePlaceVO) {
		int result = 0;
		String userid = (String)session.getAttribute("logId");
		routeVO.setUserid(userid);
		routeListVO.setUserid(userid);
		
		RouteDaoImp dao = sqlSession.getMapper(RouteDaoImp.class);
		
		// 루트 저장
		result = dao.insertRoute(routeVO);
		try {
			// 루트 저장 성공 시
			if(result == 1) {
				// 루트 번호를 구하여
				int noBoard = dao.lastRouteNo(userid);
				
				// 1. 루트 리스트 저장
				routeListVO.setNoboard(noBoard);
				dao.insertRouteList(routeListVO);
				
				// 2. 장소 리스트 저장
				routePlaceVO.setNoboard(noBoard);
				dao.insertRoutePlaceList(routePlaceVO);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			result = 0;
		}
		return result;
	}
}