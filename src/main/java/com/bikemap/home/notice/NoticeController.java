package com.bikemap.home.notice;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeController {
	
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
	
	// 메세지 저장하기
	@RequestMapping("/insertNotice")
	@ResponseBody
	public int insertNotice(NoticeVO vo) {
		int result = 0;
		NoticeDaoImp dao = sqlSession.getMapper(NoticeDaoImp.class);
		try {
			result = dao.insertNotice(vo);
		}catch(Exception e) {
			System.out.println("메세지 입력 에러 " + e.getMessage());
		}
		return result;
	}
	
	// 쪽지 보내기 창 열기
	@RequestMapping("/sendMsg")
	public ModelAndView sendMsg(HttpSession ses){
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("logId", (String)ses.getAttribute(("logId")));
		mav.setViewName("popup/sendMsg");
		return mav;
	}
	
	// 쪽지함 열기
	@RequestMapping("/messageBox")
	public ModelAndView messageBox(){
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("message/messageBox");
		return mav;
	}
	
	// 쪽지함 페이징
	@RequestMapping("/noticePaging")
	@ResponseBody
	public NoticePagingVO noticePaging(NoticePagingVO vo, HttpSession ses) {
		NoticeDaoImp dao = sqlSession.getMapper(NoticeDaoImp.class);

		// 로그인 아이디를 입력 받아 받은 메세지 페이징 생성 후 리스트 이동
		vo.setId((String)ses.getAttribute("logId"));
		
		try {
			vo.setTotalRecord(dao.selectMessageRecord(vo));
		}catch(Exception e) {
			System.out.println("쪽지함 페이징 에러 " + e.getMessage());
		}
		return vo;
	}
	
	// 쪽지함 페이징
	@RequestMapping("/selectMessage")
	@ResponseBody
	public List<NoticeVO> selectMessage(NoticePagingVO vo, HttpSession ses) {
		NoticeDaoImp dao = sqlSession.getMapper(NoticeDaoImp.class);
		vo.setId((String)ses.getAttribute("logId")); 
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		
		try {
			vo.setTotalRecord(dao.selectMessageRecord(vo));
			list = dao.selectMsgList(vo);
		}catch(Exception e) {
			System.out.println("쪽지함 리스트 호출 에러 " + e.getMessage());
		}
		return list;
	}
	
	// 읽음 처리
	@RequestMapping("/messageRead")
	@ResponseBody
	public int messageRead(int nonotice) {
		int result = 0;
		NoticeDaoImp dao = sqlSession.getMapper(NoticeDaoImp.class);
		
		try {
			result = dao.readMessage(nonotice);
		}catch(Exception e) {
			System.out.println("쪽지 읽음 처리 에러 " + e.getMessage());
		}
		return result;
	}
	
	// 메세지 삭제
	@RequestMapping("/deleteMsg")
	@ResponseBody
	public int deleteMsg(int nonotice) {
		int result = 0;
		NoticeDaoImp dao = sqlSession.getMapper(NoticeDaoImp.class);
		
		try {
			result = dao.deleteMessage(nonotice);
		}catch(Exception e) {
			System.out.println("쪽지 읽음 처리 에러 " + e.getMessage());
		}
		return result;
	}
}
