package com.bikemap.home.review;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class ReivewController {

	public SqlSession sqlSession;
	
	public SqlSession getSqlSessin() {
		return sqlSession;
		
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		
	}
	
	@Autowired
	DataSourceTransactionManager transactionManager;
	

	//글쓰기 폼 이동
	@RequestMapping("/reviewWriteForm")
	public String ReviewWriteForm() {
		return "review/reviewWriteForm";
	}
	
	// 후기 검색 페이지 이동
	@RequestMapping(value="/reviewList", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView reviewAllRecord(ReviewPagingVO pagingVO) {
		ModelAndView mav = new ModelAndView();
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		
		try {
			pagingVO.setTotalRecord(dao.searchTotalRecord(pagingVO));
			
			mav.addObject("pagingVO", pagingVO);
			mav.setViewName("review/reviewList");
		}catch(Exception e) {
			System.out.println("리뷰 문제있음"+e.getMessage());
		}	
		return mav;
	}
	
	//페이징 전체 선택 레코드 가져오기
	@RequestMapping(value="/searchReview")
	@ResponseBody
	public List<ReviewVO> searchReview(ReviewPagingVO pagingVO) {
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		List<ReviewVO> list = new ArrayList<ReviewVO>();
		
		try {
			pagingVO.setTotalRecord(dao.searchTotalRecord(pagingVO));
			
			list = dao.reviewAllRecord(pagingVO);
		}catch(Exception e) {
			System.out.println("리뷰 리스트 호출 에러 " + e.getMessage());
		}
		return list;
	}
	
	
	//레코드 추가 글쓰기
	@RequestMapping(value="/reviewWriteFormOk", method=RequestMethod.POST)
	@ResponseBody
	public int reviewWriteFormOk(ReviewVO vo, HttpSession ses, HttpServletRequest req) {
		vo.setIp(req.getRemoteAddr());
		vo.setUserid((String)ses.getAttribute("logId"));
		
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		int result = 0;
		
		try {
			result = dao.reviewInsert(vo);
		}catch(Exception e) {
			System.out.println("후기 글쓰기 에러 " + e.getMessage());
		}
		return result;
	}

	
	
	//레코드 한개 선택 - 글 보기
	@RequestMapping(value="/reviewView", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView reviewSelect(ReviewPagingVO pagingVO) {
				
		ReviewDaoImp dao =  sqlSession.getMapper(ReviewDaoImp.class);		
		ModelAndView mav = new ModelAndView();

		try {
			//조회수를 먼저 증가하기
			dao.hitCount(pagingVO.getNoboard());
			
			ReviewVO vo = dao.reviewSelect(pagingVO.getNoboard());
			pagingVO.setTotalRecord(dao.searchTotalRecord(pagingVO));
			// 이전 글 다음 글 검색하기
			
			int idx = dao.getPrevNext(pagingVO);
			
			if(idx < pagingVO.getTotalRecord()) {
				pagingVO.setIdx(idx+1);
				ReviewVO prev = dao.selectPrevNext(pagingVO);
				mav.addObject("prev", prev);
			}
			
			if(idx > 1 ) {
				pagingVO.setIdx(idx-1);
				ReviewVO next = dao.selectPrevNext(pagingVO);
				mav.addObject("next", next);
			}
					
			mav.addObject("vo",vo);
			mav.addObject("pagingVO", pagingVO);
			mav.setViewName("review/reviewView");
			
		}catch(Exception e) {
			System.out.println("글 보기 에러" + e.getMessage());
		}
		return mav;
	}

	
	//글쓰기 수정
	@RequestMapping("/reviewEdit")
	public ModelAndView reviewEdit(int noboard) {
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		ModelAndView mav = new ModelAndView();

		try {
			ReviewVO vo = dao.reviewSelect(noboard);

			mav.addObject("vo", vo);
			mav.setViewName("review/reviewEdit");
		}catch(Exception e) {
			System.out.println("글쓰기 에러" + e.getMessage());
		}
			return mav;
	}
	
	

	//리뷰 수정 확인
	@RequestMapping(value="/reviewEditOk", method=RequestMethod.POST)
	@ResponseBody
	public int reviewEditOk(ReviewVO vo, HttpSession ses) {
		vo.setUserid((String)ses.getAttribute("logId"));
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);

		int result = 0;

		try {	
			result = dao.reviewUpdate(vo);
		}catch(Exception e){
			System.out.println("리뷰 수정 오류" + e.getMessage());
		}
			return result;
	}

	
	//리뷰 삭제
	@RequestMapping("/reviewDel")
	@ResponseBody
	public int reviewDel(int noboard, HttpSession ses) {
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		int result = 0;

		try {
			result = dao.reviewDelete(noboard,(String)ses.getAttribute("logId"));
		}catch(Exception e) {
			System.out.println("리뷰 삭제 에러" + e.getMessage());
		}	
		return result;
	}
	
	// 리뷰 페이징 처리
	@RequestMapping(value="/searchReviewPaging", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ReviewPagingVO searchReviewPageing(ReviewPagingVO pagingVO) {		
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);

		try {
			pagingVO.setTotalRecord(dao.searchTotalRecord(pagingVO));
		}catch(Exception e) {
			System.out.println("리뷰 페이징 에러 " + e.getMessage());
		}
		return pagingVO;
	}
		
	// 추천 리뷰 가져오기
	@RequestMapping("/reivew/getRecReview")
	@ResponseBody
	public List<ReviewVO> getRecReview(){
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		List<ReviewVO> list = new ArrayList<ReviewVO>();
		
		try {
			list = dao.selectRecommendReview();
		}catch(Exception e) {
			System.out.println("추천 리뷰 호출 에러" + e.getMessage());
		}
		return list;
	}
	
	//추천 기능
	// 추천 한 적이 있는 지 확인
	@RequestMapping("/chkAlreadyReviewRate")
	@ResponseBody
	public int chkAlreadyReviewRate(ReviewVO vo, HttpSession ses) {
		int result = 0;
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		vo.setUserid((String)ses.getAttribute("logId"));
		
		try {
			result = dao.chkAlreadyReviewRate(vo);
		}catch(Exception e) {
			System.out.println("기존 추천 비추천 확인 오류 " + e.getMessage());
		}
		return result;
	}
	
	@RequestMapping("/setThumb")
	@ResponseBody
	public int setThumb(ReviewVO vo, HttpSession ses) {
		int result = 0;
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		String logId = (String)ses.getAttribute("logId");
		vo.setUserid(logId);
		try {
			// 리뷰 평가 작업
			if(dao.setThumb(vo) > 0 ) {
				// 성공 시 reviewrate 에 기록 남기기
				result = dao.insertReviewrate(vo);
			}
			transactionManager.commit(status);
		}catch(Exception e) {
			System.out.println("리뷰 평가 오류 " + e.getMessage());
			transactionManager.rollback(status);
		}
		return result;
	}
	
	// 리뷰 스크랩
	@RequestMapping("/scrapReview")
	@ResponseBody
	public int scrapReview(int noboard) {
		int result = 0;
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		
		try {
			result = dao.scrapReview(noboard);
		}catch(Exception e) {
			System.out.println("리뷰 스크랩 에러 " + e.getMessage());
		}
		return result;
	}
	// 루트 스크랩 전체
	@RequestMapping("/scrapReviewAll")
	@ResponseBody
	public int scrapRoute(int noboard) {
		int result = 0;
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		try {			
			result = dao.scrapReview(noboard);
		}catch(Exception e) {
			System.out.println("루트 전체 스크랩 에러 " + e.getMessage());
		}
		return result;
	}
	// 리뷰 스크랩 해제
	@RequestMapping("/releaseReview")
	@ResponseBody
	public int releaseReview(int noboard) {
		int result = 0;
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		
		try {
			result = dao.releaseReview(noboard);
		}catch(Exception e) {
			System.out.println("리뷰 스크랩 해제 에러 " + e.getMessage());
		}
		return result;
	}
	
	// 리뷰 추천 비추천 불러오기
	@RequestMapping("/selectReviewThumb")
	@ResponseBody
	public ReviewVO selectReviewThumb(int noboard) {
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		ReviewVO vo = new ReviewVO();
		
		try {
			vo = dao.selectReviewThumb(noboard);
			
		}catch(Exception e) {
			System.out.println("리뷰 추천 비추천 호출 에러 " + e.getMessage());
		}
		return vo;
	}
}