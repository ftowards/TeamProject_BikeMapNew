package com.bikemap.home.admin;

import java.util.List;
import com.bikemap.home.review.ReviewVO;
import com.bikemap.home.tour.TourVO;

public interface AdminDaoImp {
	
		//관리자 항목 -  회원관리
		// 전체 리스트가져오기
		public List<AdminRegistVO> selectRegistAll(AdminPagingVO vo);
		// 회원 전체 수 가져오기.
		//public int registTotalRecord();
		// 검색한 회원 수 가져오기
		public int searchRegistRecord(AdminPagingVO vo);
		//회원 정지하기
		public int suspendInsert(AdminSuspendVO vo);
		
		//회원 정지수정하기
		public int suspendUpdate(AdminSuspendVO vo);
		
		//회원 정지상태 파악하기
		public int getStopState(String userid);
		
		public AdminSuspendVO getEndday(AdminSuspendVO vo);
		
		//항목 - QNA
		public int qnaTotalRecord();
		
		public List<AdminQnaVO>selectQnaAll(AdminQnaVO vo);
		
		public AdminQnaVO selectQna(int qnano);
		
		public int qnaUpdate(AdminQnaVO vo);
		
		//항목 - review
		public List<ReviewVO>reviewAllRecord(AdminPagingVO vo);
		
		public int searchReviewRecord(AdminPagingVO vo);
		
		public int reviewTotalRecord();
		
		
		public List<TourVO>tourAllRecord(AdminPagingVO vo);
				
		public int searchTourRecord(AdminPagingVO vo);
				
		public int tourTotalRecord();
		
		
		
		
}
