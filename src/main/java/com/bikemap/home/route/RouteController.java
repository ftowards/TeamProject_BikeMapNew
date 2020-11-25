package com.bikemap.home.route;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


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
	public String routeSearch() {
		return "route/routeSearch";
	}

	//코스검색(글보기)
	@RequestMapping("/routeSearchView")
	public ModelAndView routeSearchView(int noroute) {
		ModelAndView mav = new ModelAndView();
		
		RouteDaoImp dao = sqlSession.getMapper(RouteDaoImp.class);
		
		RouteVO vo = dao.selectRoute(noroute);
		RoutePlaceVO placeVO = dao.selectRoutePlace(noroute);
		
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
				int noRoute = dao.lastRouteNo(userid);
				
				// 1. 루트 리스트 저장
				routeListVO.setNoroute(noRoute);
				dao.insertRouteList(routeListVO);
				
				// 2. 장소 리스트 저장
				routePlaceVO.setNoroute(noRoute);
				dao.insertRoutePlaceList(routePlaceVO);
			}
		}catch(Exception e) {
			e.getStackTrace();
			result = 0;
		}
		return result;
	}
}