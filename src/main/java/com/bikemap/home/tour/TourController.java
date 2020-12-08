package com.bikemap.home.tour;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TourController {
	
	public SqlSession sqlSession ;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Autowired
	DataSourceTransactionManager transactionManager;

	// 게시판 목록
	@RequestMapping("/tourList")
	public ModelAndView TourList(PagingVO vo) {
		ModelAndView mav = new ModelAndView();
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		PagingVO pagingVO = new PagingVO();
		List<TourVO> list = dao.selectAllTour(pagingVO);
	
		try {
			pagingVO.setTotalRecord(dao.getTotalTourRecord(vo));
			
		}catch(Exception e) {
			System.out.println("동행찾기게시판 페이징 에러"+ e.getMessage());
		}
	
		mav.addObject("paging", pagingVO);
		mav.addObject("viewAll",list);
		
		mav.setViewName("tour/tourList");
		return mav;
	}

	@RequestMapping("/tourPagingListAll")
	@ResponseBody
	public List<TourVO> tourAllSelectAll(PagingVO vo) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		List<TourVO> list = new ArrayList<TourVO>();
		try {
			vo.setTotalRecord(dao.getTotalTourRecord(vo));			
			list = dao.selectAllTour(vo);
		}catch(Exception e) {
			System.out.println("페이징 에러 " + e.getMessage());
		}
		
		return list;
	}
	
	@RequestMapping("/tourPagingList")
	@ResponseBody
	public List<TourVO> tourAllSelect(PagingVO vo) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		List<TourVO> list = new ArrayList<TourVO>();
		try {
			vo.setTotalRecord(dao.getTourRecord(vo));
			System.out.println(vo.getOnePageRecord());
			list = dao.selectAllTour(vo);
		}catch(Exception e) {
			System.out.println("페이징 에러 " + e.getMessage());
		}
		
		return list;
	}
																							
	//글보기
	@RequestMapping("/tourView")
	public ModelAndView TourView(int noboard) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		ModelAndView mav = new ModelAndView();
		TourVO vo = new TourVO();
		try {
			vo = dao.tourSelect(noboard);
		}catch(Exception e) {
			System.out.println("투어 보기 에러" + e.getMessage());
		}
		
		mav.addObject("vo", vo);
		mav.setViewName("tour/tourView");
		
		return mav;
	}
	
	
	// 글쓰기 폼 이동
	@RequestMapping("/tourWriteForm")
	public String tourBoardWrite() {
		return "/tour/tourWriteForm";
	}
	
	// 글쓰기 등록 , produces="application/text;charset=UTF-8"
	@RequestMapping(value="/tourWriteFormOk", method= {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public int tourWriteFormOk(TourVO vo ,HttpServletRequest req, HttpSession ses) {

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);

		vo.setIp(req.getRemoteAddr());
		vo.setUserid((String)ses.getAttribute("logId"));
		
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		int result=0;
		try {
			result = dao.tourInsert(vo);
			if(result == 1) {
				ComplistVO complist = new ComplistVO();
				complist.setNoboard(dao.lastTourNo(vo.getUserid()));
				complist.setUserid(vo.getUserid());
				complist.setState("2");
				
				result = dao.insertTourComplist(complist);
			}
			transactionManager.commit(status);
		}catch(Exception e) {
			System.out.println("동행 모집 등록 에러" + e.getMessage());
			transactionManager.rollback(status);
			result = 0;
		}	

		return result;
	}
	//페이징 전체
	@RequestMapping(value="/searchTourPagingAll", method=RequestMethod.POST)
	@ResponseBody
	public PagingVO searchTourPagingAll(PagingVO vo) {	
		try {
			TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
			vo.setTotalRecord(dao.getTotalTourRecord(vo));
		}catch(Exception e) {
			System.out.println("페이징에러"+e.getMessage());
			e.printStackTrace();
		}
		return vo;
	}
	
	//페이징
	@RequestMapping(value="/searchTourPaging", method=RequestMethod.POST)
	@ResponseBody
	public PagingVO searchTourPaging(PagingVO vo) {	
		try {
			TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
			
//			String sql = sqlSession.getConfiguration().getMappedStatement("getTotalTourRecord").getBoundSql(vo).getSql();
//			System.out.println("sql->"+sql);
			vo.setTotalRecord(dao.getTourRecord(vo));
		}catch(Exception e) {
			System.out.println("페이징에러"+e.getMessage());
			e.printStackTrace();
		}
		return vo;
	}
	
	///////////////////////
	// 투어 참가 신청
	@RequestMapping(value="/applyTour")
	@ResponseBody
	public int applyTour(ComplistVO vo, HttpSession session) {
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);

		try {
			if(checkDeadline(vo.getNoboard())){
				vo.setUserid((String)session.getAttribute("logId"));
				String state = dao.checkTourComplist(vo) == null ? "3" : dao.checkTourComplist(vo); 
				if(state.equals("1") || state.equals("2")) {
					result = Integer.parseInt(state)+1;
				}else if(dao.checkTourRoom(vo.getNoboard()) <= 0) {
					return 4;
				}else {
					vo.setState("1");
					result = dao.insertTourComplist(vo);
				}
				transactionManager.commit(status);
			}else {
				return 5;
			}
		}catch(Exception e) {
			System.out.println("투어 참가 신청 오류 " + e.getMessage());
			transactionManager.rollback(status);
		}
		return result; 
	}
	
	// 투어 참가 여부 확인
	@RequestMapping("/checkCompllistIn")
	@ResponseBody
	public String checkCompllistIn(ComplistVO vo, HttpSession session) {
		String result = "";
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);

		try {			
			vo.setUserid((String)session.getAttribute("logId"));
			result = dao.checkTourComplist(vo);
			
		}catch(Exception e) {
			System.out.println("투어 참가 확인 오류 " + e.getMessage());
		}
		return result; 
		
	}
	
	// 투어 참가 취소
	@RequestMapping("/cancelTour")
	@ResponseBody
	public int cancelTour(ComplistVO vo, HttpSession session) {
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		try {
			vo.setUserid((String)session.getAttribute("logId"));
			if(checkDeadline(vo.getNoboard())){
				String state = dao.checkTourComplist(vo) == null ? "3" : dao.checkTourComplist(vo); 
				if(state.equals("1") || state.equals("2")) {
					result = dao.cancelTour(vo);
				}
			}else {
				return 5;
			}
		}catch(Exception e) {
			System.out.println("투어 취소 처리 오류 " + e.getMessage());
		}
		return result; 
	}
	
	// 투어 참가자 리스트 불러오기
	@RequestMapping("/selectComplist")
	@ResponseBody
	public List<ComplistVO> selectComplist(int noboard){
		List<ComplistVO> list = new ArrayList<ComplistVO>();
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		try {
			list = dao.selectTourComplist(noboard);			
		}catch(Exception e) {
			System.out.println("투어 참가자 리스트 호출 에러" + e.getMessage());
		}
		
		return list;
	}
	
	// 마감 시간 확인 펑션
	public boolean checkDeadline(int noboard) {
		boolean chk = true;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		String deadline = dao.getDeadline(noboard);
		String[] deadArray = deadline.split("/");
		
		Calendar now = Calendar.getInstance();
		Calendar dead = Calendar.getInstance();
		
		dead.set(Integer.parseInt(deadArray[0]), Integer.parseInt(deadArray[1])-1, Integer.parseInt(deadArray[2]), Integer.parseInt(deadArray[3]), 0,0);
		
		if(now.compareTo(dead) > 0) {
			System.out.println("마감 시간 후");
			chk = false;
		}
		
//		System.out.println(now.getTime());
//		System.out.println(dead.getTime());
		
		return chk;
	}
	
	// 투어 참가 승인
	@RequestMapping("/mytour/confirmComplist")
	@ResponseBody
	public int confirmComplist(ComplistVO vo) {
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		try {
			result = dao.confirmComplist(vo);
		}catch(Exception e) {
			System.out.println("투어 참가 승인 에러" + e.getMessage());
		}		
		return result;
	}
	
	// 투어 참가자 강퇴
	@RequestMapping("/mytour/revertComplist")
	@ResponseBody
	public int revertComplist(ComplistVO vo) {
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		try {
			if(checkDeadline(vo.getNoboard())){
				String state = dao.checkTourComplist(vo) == null ? "3" : dao.checkTourComplist(vo); 
				if(state.equals("1") || state.equals("2")) {
					result = dao.cancelTour(vo);
				}
			}else {
				return 5;
			}
		}catch(Exception e) {
			System.out.println("투어 강퇴 처리 오류 " + e.getMessage());
		}
		return result; 
	}
	
	// 투어 불참 처리 하기
	@RequestMapping("/mytour/absentComplist")
	@ResponseBody
	public int absentComplist(ComplistVO vo) {
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		try {
			result = dao.absentTour(vo);
		}catch(Exception e) {
			System.out.println("투어 결석 처리 오류 " + e.getMessage());
		}
		return result;
	}
	
	// 투어 완료 처리하기
	@RequestMapping("/mytour/completeTour")
	@ResponseBody
	public int completeTour(int noboard) {
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status =  transactionManager.getTransaction(def);
		
		try {
			if(dao.completeTour(noboard) == 1) {
				List<String> list = dao.selectCompleteList(noboard);
				if(list.size() >0) {
					for(int i = 0 ; i <list.size(); i++) {
						for(int j = 0 ; j < list.size(); j++) {
							if(i != j) {
								dao.insertEvalList(noboard, list.get(i), list.get(j));
							}
						}
						/// 투어 완료 카운트 가산하기
						dao.addTourcnt(list.get(i));
					}
				}
			}
			result = 1;
			transactionManager.commit(status);
		}catch(Exception e) {
			System.out.println("투어 완료 처리 오류" + e.getMessage());
			transactionManager.rollback(status);
		}
		return result;
	}
	
	// 좋아요 평가 리스트 불러오기
	@RequestMapping("/tour/selectEvallist")
	@ResponseBody
	public List<ComplistVO> selectEvallist(ComplistVO vo, HttpSession session){
		List<ComplistVO> list = new ArrayList<ComplistVO>();
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		try {
			vo.setUserid((String)session.getAttribute("logId"));
			list = dao.selectEvallist(vo);
		}catch(Exception e) {
			System.out.println("좋아요 평가 리스트 불러오기 에러 " + e.getMessage());
		}
		return list;
	}
	
	// 좋아요 처리
	@RequestMapping("/mytour/addHeart")
	@ResponseBody
	public int addHeart(ComplistVO vo, HttpSession session) {
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		try {
			vo.setUserid((String)session.getAttribute("logId"));
			// 라이크 리스트 갱신
			if(dao.updateEvallist(vo) == 1) {
				// 라이크 가산
				result = dao.addHeart(vo.getObjid());
			}
			transactionManager.commit(status);
		}catch(Exception e) {
			System.out.println("좋아요 에러 " + e.getMessage());
			transactionManager.rollback(status);
		}
		return result;
	}
	
	
	////////////// 내가 만든 투어 관리 ///////////////////
	// 내가 주최하는 모임 페이지
	@RequestMapping("/mytour")
	public String mytourOn() {
		return "/tour/mytour";
	}
	
	// 내 투어 페이징
	@RequestMapping("/mytour/paging")
	@ResponseBody
	public TourListPagingVO mytourPaging(TourListPagingVO vo, HttpSession session) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		String userid = (String)session.getAttribute("logId");
		vo.setUserid(userid);
		
		try {
			if(vo.getTourState() != null && vo.getApplyState() == null) {
				vo.setTotalRecord(dao.getMytourRecordCount(vo));	
//				System.out.println("총 레코드 수 " +dao.getMytourRecordCount(vo));
			}else if(vo.getTourState() == null && vo.getApplyState() != null) {
				vo.setTotalRecord(dao.getApplytourRecordCount(vo));
				System.out.println("참가 신청한 투어 총 레코드 수 " +dao.getApplytourRecordCount(vo));
			}
		}catch(Exception e) {
			System.out.println("투어 페이징 에러 " + e.getMessage());
		}
		return vo;
	}
	
	// 내 투어 리스트 가져오기
	@RequestMapping("/mytour/selectTourlist")
	@ResponseBody
	public List<TourlistVO> selectTourlist(TourListPagingVO vo, HttpSession session) {
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		String userid = (String)session.getAttribute("logId");
		vo.setUserid(userid);
		
		List<TourlistVO> list = new ArrayList<TourlistVO>();
		
		try {
			if(vo.getTourState() != null && vo.getApplyState() == null) {
				vo.setTotalRecord(dao.getMytourRecordCount(vo));
				list = dao.selectMytourList(vo);
			}else if(vo.getTourState() == null && vo.getApplyState() != null) {
				vo.setTotalRecord(dao.getApplytourRecordCount(vo));
				list = dao.selectApplytourList(vo);
			}
		}catch(Exception e) {
			System.out.println("투어 리스트 호출 에러 " + e.getMessage());
		}
		return list;
	}
	
	//마감된 여행
	@RequestMapping("/mytourClose")
	public String mytourClose() {
		return "/tour/mytourClose";
	}
	
	// 완료한 여행
	@RequestMapping("/mytourComplete")
	public String mytourComplete() {
		return "/tour/mytourComplete";
	
	}

	
	
	//////////// 참여한 투어 ////////////////
	// 승인 대기 중
	@RequestMapping("/tourApply")
	public String applyTour() {
		return "/tour/tourApply";
	}
	
	// 참가 중
	@RequestMapping("/tourIn")
	public String tourIn() {
		return "/tour/tourIn";
		
	}
	
	// 완료
	@RequestMapping("/tourComplete")
	public String tourComplete() {
		return "/tour/tourComplete";
	}
	
	//글삭제 조건
	@RequestMapping("/tourViewDeleteChk")
	@ResponseBody
	public int tourViewDeleteChk(int noboard,HttpSession ses) {
		
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
			
		try {
				if(1 <= dao.selectTourCompState(noboard)) {
					result = 1;
				
				}else if(2 <= dao.selectComplistChk(noboard)){
					result = 2;
				
				}else{
					result = 3;
				}
		}catch(Exception e) {
			System.out.println("투어 게시글 확인 실패"+e.getMessage());
		}
		return result;
		
	}
	//글 삭제완료
	@RequestMapping("/deleteTourView")
	@ResponseBody
	public int tourViewDelete(int noboard,HttpSession ses) {
		
		int result = 0;
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		try {
			result = dao.deleteTourView(noboard,(String)ses.getAttribute("logId"));
			
		}catch(Exception e) {
			System.out.println("투어 게시글 삭제 실패"+e.getMessage());
		}
		return result;
	}
	
}



















