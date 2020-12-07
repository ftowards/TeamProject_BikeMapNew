package com.bikemap.home.review;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bikemap.home.route.RouteVO;


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
	
	//글쓰기 폼 이동
	@RequestMapping("/reviewWriteForm")
	public String ReviewWriteForm() {
		return "review/reviewWriteForm";
	}
	
	//글쓰기 전체 레코드 선택
	@RequestMapping("/reviewList")
	public ModelAndView reviewAllRecord() {
			ModelAndView mav = new ModelAndView();
			ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
			List<ReviewVO> list;
			ReviewPagingVO pagingVO = new ReviewPagingVO();
			try {
				
				int totalRecord = dao.searchTotalRecord();
				pagingVO.setTotalRecord(totalRecord);
				
				list = dao.reviewAllRecord(pagingVO);
				mav.addObject("list", list);
				mav.addObject("pagingVO", pagingVO);
				mav.setViewName("review/reviewList");
					
			}catch(Exception e) {
				System.out.println("리뷰 문제있음"+e.getMessage());
			}
			
		return mav;
	}
	//페이징 전체 선택 레코드 가져오기
	@RequestMapping(value="/searchReviewAll", method= {RequestMethod.POST})
	@ResponseBody
	public List<ReviewVO> searchReviewAll(ReviewPagingVO pagingVO) {
			ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
			List<ReviewVO> list = new ArrayList<ReviewVO>();
			
			try {
				int totalRecord = dao.searchTotalRecord();
				pagingVO.setTotalRecord(totalRecord);
				
				list = dao.reviewAllRecord(pagingVO);
				System.out.println(list);
				
			}catch(Exception e) {
				System.out.println("에러 " + e.getMessage());
			}
			return list;
	}
	
//	//페이징 전체 선택 레코드 가져오기
//		@RequestMapping("/searchReviewOk")
//		public ModelAndView reviewAllRecord() {
//				ModelAndView mav = new ModelAndView();
//				ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
//				List<ReviewVO> list;
//				ReviewPagingVO pagingVO = new ReviewPagingVO();
//				try {
//					
//					int totalRecord = dao.searchTotalRecord();
//					pagingVO.setTotalRecord(totalRecord);
//					
//					list = dao.reviewAllRecord(pagingVO);
//					mav.addObject("list", list);
//					mav.addObject("pagingVO", pagingVO);
//					mav.setViewName("review/reviewView");
//		
//				}catch(Exception e) {
//					System.out.println("리뷰 문제있음"+e.getMessage());
//				}
//				
//			return mav;
//		}
	
	
	//레코드 추가 글쓰기
	@RequestMapping(value="/reviewWriteFormOk", method=RequestMethod.POST)
	@ResponseBody
	public int reviewWriteFormOk(ReviewVO vo, HttpSession ses, HttpServletRequest req) {
		vo.setIp(req.getRemoteAddr());
		vo.setUserid((String)ses.getAttribute("logId"));
		
		System.out.println(111);
		System.out.println(vo.getUserid());
		System.out.println(vo.getSubject());
		System.out.println(vo.getContent());
		System.out.println(vo.getIp());
		
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		int result = 0;
		
		System.out.println(result);
		
		try {
			result = dao.reviewInsert(vo);
			System.out.println(result);
		}catch(Exception e) {
			System.out.println("후기 글쓰기 에러 " + e.getMessage());
		}
		return result;
	}

	
	
	//레코드 한개 선택 - 글 보기
	@RequestMapping("/reviewView")
	public ModelAndView reviewSelect(int noboard) {
		ReviewDaoImp dao =  sqlSession.getMapper(ReviewDaoImp.class);
		
//		dao.hitCount(no);
		ReviewVO vo = dao.reviewSelect(noboard);
		
			
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo",vo);
		mav.setViewName("review/reviewView");
		
		return mav;
	}

	//글쓰기 수정
	@RequestMapping("/reviewEdit")
	public ModelAndView reviewEdit(int noboard) {
			System.out.println("noboardTest...."+noboard);
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		ReviewVO vo = dao.reviewSelect(noboard);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("review/reviewEdit");
		
		return mav;
	}
	
	

	//글 수정 확인
	@RequestMapping(value="/reviewEditOk", method=RequestMethod.POST)
	public ModelAndView reviewEditOk(ReviewVO vo, HttpSession ses) {
		vo.setUserid((String)ses.getAttribute("logId"));
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);

		int result = dao.reviewUpdate(vo);
		ModelAndView mav = new ModelAndView();
		if(result>0) {
			mav.addObject("noboard", vo.getNoboard());
			mav.setViewName("redirect:reviewList");
		
		}else {
			mav.setViewName("review/reviewResult");
				
		}
			return mav;
	}
	
	
	
	//글삭제 폼
	@RequestMapping("/reviewDel")
	public ModelAndView reviewDel(int noboard, HttpSession ses) {
	
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		int result = dao.reviewDelete(noboard,(String)ses.getAttribute("logId"));
		
		ModelAndView mav = new ModelAndView();
			if(result>0) {
				mav.setViewName("redirect: reviewList");
				
			}else {
				mav.setViewName("review/reviewResult");
				
			}
			return mav;
		
	}
	
	// 루트 검색 페이지 페이징 처리
		@RequestMapping(value="/searchReviewPaging", method= {RequestMethod.POST})
		@ResponseBody
		public ReviewPagingVO searchReviewPageing(ReviewPagingVO pagingVO) {		
			ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
			try {
				int totalRecord = dao.searchResultRecord(pagingVO);
				pagingVO.setTotalRecord(totalRecord);
				
			}catch(Exception e) {
				System.out.println("에러 " + e.getMessage());
			}
			return pagingVO;
		}
		
//		//코스검색(글보기)
//		@RequestMapping("/ReviewSearchView")
//		public ModelAndView ReviewSearchView(int noboard) {
//			ModelAndView mav = new ModelAndView();
//			
//			ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
//			
//			try {
//				ReviewVO vo = dao.selectReview(noboard);
//				ReviewPlaceVO placeVO = dao.selectReviewPlace(noboard);
//				
//				mav.addObject("ReviewVO", vo);
//				mav.addObject("placeVO", placeVO);
//			}catch(Exception e) {
//				System.out.println(e.getMessage());
//			}
//			mav.setViewName("Review/ReviewSearchView");
//			return mav;
//		}
}
	
	
	
	



	







