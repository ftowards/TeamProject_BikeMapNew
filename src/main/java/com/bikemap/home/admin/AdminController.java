package com.bikemap.home.admin;


import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class AdminController {
	@Autowired
	SqlSession sqlSession;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	//회원관리전체리스트
	@RequestMapping("/adminUser")
	public ModelAndView adminUser(AdminSearchVO vo) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		AdminPagingVO pagingVO = new AdminPagingVO();
		try {	
			int totalRecord = 0;
			List<AdminRegistVO>list;
			if(vo.getSearchType()!=null||vo.getSearchType()!="") {
				totalRecord = dao.searchRegistRecord(vo);
				list = dao.selectRegistAll(vo);
			}
			else{
				totalRecord = dao.registTotalRecord();
				list = dao.selectRegistAll(null);//처음에는 검색어 없으므로 그냥 널값넣어준다.
			}
			pagingVO.setTotalRecord(totalRecord);
			mav.addObject("list", list);
			mav.addObject("pagingVO", pagingVO);	
		}catch(Exception e) {
			System.out.println("회원 검색 화면 호출 에러111"+e.getMessage());
		}	
		mav.setViewName("admin/adminUserTable");
		return mav;
	}
	//회원관리 선택화면 출력
//	@RequestMapping("/adminSearchUser")
//	public ModelAndView adminUser(AdminSearchVO vo) {//검색할 항목, 검색어 가져옴
//		ModelAndView mav = new ModelAndView();
//		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
//		//검색한 항목의 페이징처리
//		AdminPagingVO pagingVO = new AdminPagingVO();
//		try {	
//			int selectRecord = dao.searchRecord(vo); //검색할 항목으로 검색된 페이지 수 구함
//			pagingVO.setTotalRecord(selectRecord);
//			List<AdminRegistVO>list = dao.selectRegistAll(vo);
//			mav.addObject("list", list);				
//			mav.addObject("pagingVO", pagingVO);	
//		}catch(Exception e) {
//			System.out.println("회원 검색 화면 호출 에러"+e.getMessage());
//		}	
//		mav.setViewName("admin/adminUserTable");
//			return mav;
//		}
	
	//정지추가
	@RequestMapping(value="/userSuspendOk", method=RequestMethod.POST)
	@ResponseBody
	public AdminSuspendVO userSuspendOk(AdminSuspendVO vo) {
		AdminSuspendVO Avo = null;
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		int result = dao.suspendInsert(vo);
		if(result>0) {
			Avo = dao.getEndday(vo);
		}
		//System.out.println(Avo.getEnddayStr()+"    log");
		return Avo;
	}
	
	@RequestMapping(value="/userSuspendUpdateOk", method=RequestMethod.POST)
	@ResponseBody
	public AdminSuspendVO userSuspendUpdateOk(AdminSuspendVO vo) {
		AdminSuspendVO Avo = null;
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		int result = dao.suspendUpdate(vo);
		if(result>0) {
			Avo = dao.getEndday(vo);
		}
		return Avo;
	}
	
	//동행찾기패널
	@RequestMapping("/adminPartner")
	public String adminPartner() {
		return "admin/adminPartnerTable";
	}
	
	//리뷰패널
	@RequestMapping("/adminReview")
	public ModelAndView adminReview(AdminSearchVO vo) {
			ModelAndView mav = new ModelAndView();
			AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
			AdminPagingVO pagingVO = new AdminPagingVO();
			try {	
				int totalRecord = 0;
				List<AdminReviewVO>list;
				if(vo.getSearchType()!=null||vo.getSearchType()!="") {
					totalRecord = dao.searchReviewRecord(vo);
					list = dao.reviewAllRecord(vo);
				}
				else{
					totalRecord = dao.reviewTotalRecord();
					list = dao.reviewAllRecord(null);//처음에는 검색어 없으므로 그냥 널값넣어준다.
				}
				pagingVO.setTotalRecord(totalRecord);
				mav.addObject("list", list);
				mav.addObject("pagingVO", pagingVO);	
			}catch(Exception e) {
				System.out.println("회원 검색 화면 호출 에러111"+e.getMessage());
			}	
			mav.setViewName("admin/adminReviewTable");
			return mav;
		}
	//1대1문의패널
	@RequestMapping("/adminQna")
	public ModelAndView adminQna() {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		AdminPagingVO pagingVO = new AdminPagingVO();
		try {	
			//전체 답변테이블 구하기
			int totalRecord = dao.qnaTotalRecord();
			pagingVO.setTotalRecord(totalRecord);
			//
			List<AdminQnaVO>list = dao.selectQnaAll(null);//처음에는 검색어 없으므로 그냥 널값넣어준다.
			mav.addObject("list", list);
			mav.addObject("pagingVO", pagingVO);	
		}catch(Exception e) {
			System.out.println("회원 답변테이블 호출 에러111"+e.getMessage());
		}	
		mav.setViewName("admin/adminQnaTable");
		return mav;
	}
	
	//1대1 문의 답변 패널
	@RequestMapping("/adminQnaWrite")
	public ModelAndView adminQnaWrite(int noqna) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		try {
			AdminQnaVO vo = dao.selectQna(noqna);
			vo.setNoqna(noqna);
			mav.addObject("vo", vo);
		}catch(Exception e) {
			System.out.println("1대1문의 답변 패널 로딩오류 "+e.getMessage());
		}
		
		mav.setViewName("admin/adminQnaWrite");
		return mav;
	}
	@RequestMapping(value="/adminQnaWriteOk", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView adminQnaWriteOk(AdminQnaVO vo) {
		
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		
		try {
			System.out.println(vo.getNoqna()+"dddddd");
			dao.qnaUpdate(vo);
			mav.setViewName("redirect:adminQna");
//				mav.addObject("msg", "1대1문의 답변 제출 오류");
//				mav.setViewName("admin/result");	
		}catch(Exception e) {
			System.out.println("1대1문의 답변 제출 오류"+e.getMessage());
		}
		return mav;
	}
	
}
