package com.bikemap.home.admin;

import java.util.List;
import com.bikemap.home.regist.RegistVO;

public interface AdminDaoImp {
	
		//관리자 항목 - =1124
		// 전체 리스트가져오기
		public List<AdminRegistVO> registAllRecord();
		
		//회원 정지하기
		public int suspendInsert(AdminSuspendVO vo);
		//회원 정지수정하기
		public int suspendUpdate(AdminSuspendVO vo);
		
		
}
