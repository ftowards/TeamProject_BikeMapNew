package com.bikemap.home.regist;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bikemap.home.mailng.MailHandler;
import com.bikemap.home.route.RouteDaoImp;

@Controller
public class RegistController {
	
	public SqlSession sqlSession ;
	
	@Autowired
	private JavaMailSender mailSender;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Autowired
	DataSourceTransactionManager transactionManager;
	
	// 회원 가입 폼으로 이동
	@RequestMapping("/registerForm")
	public String registerForm() {
		return "/regist/registerForm";
	}
	
	// 아이디 중복 체크
	@RequestMapping("/idDoubleChk")
	@ResponseBody
	public int idDoubleChk(@RequestParam("userid") String userid) {
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		int result = 0;
		try {
			result = dao.idDoubleChk(userid);
		}catch(Exception e) {
			System.out.println("아이디 중복 확인 에러" + e.getMessage());
		}
		
		return result;
	}
	
	// 이메일 중복 체크
	@RequestMapping("/emailDoubleChk")
	@ResponseBody
	public int emailDoubleChk(@RequestParam("email") String email) {
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		int result = 0;
		try {
			result = dao.emailDoubleChk(email);
		}catch(Exception e) {
			System.out.println("이메일 중복 확인 에러" + e.getMessage());
		}
		
		return result;
	}
		
	// 회원가입 확인
	// 회원 정보 DB 입력 후 결과값을 폼 페이지로 반환
	@RequestMapping(value="/registerFormOk", method=RequestMethod.POST)
	@ResponseBody
	public int registerFormOk(RegistVO vo) {
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		RouteDaoImp routeDao = sqlSession.getMapper(RouteDaoImp.class);
		int result = 0;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		// vo에 인증 코드 세팅
		vo.setCode(new TempKey().getKey(48));
		
		try {
			// 회원 가입
			result =dao.insertUser(vo);
			
			// 회원 가입 오류 없을 시 기본 카테고리 생성
			routeDao.insertBasicCategory(vo.getUserid());
		
			// 회원 가입에 오류가 없을 시 인증 메일 발송
			if(result == 1) {
				MailHandler sendMail = new MailHandler(mailSender);
			        sendMail.setSubject("[바이크맵] 회원 인증 메일입니다.");
			        
			        sendMail.setText(
			        		new StringBuffer().append("<div class='container'>").
			        		append("<img src='cid:bikemapLogo' style='width:400px; margin-top:-60px'>").
			        		append("<h1 style='margin:-100px 0 0 40px; z-index:9; color:rgb(0,176,176)'>").
			        		append("<b>이메일 주소 인증</b></h1>").
			        		append("<div style='margin:20px 0 0 40px'>").
			        		append("<p>안녕하세요. bikemap입니다.</p>").
			        		append("<p style='margin-top:20px'>회원가입을 위한 본인인증절차를 완료하기 위해<br/>").
			        		append("아래 링크를 클릭하여 주세요.</p></div>").
			        		append("<div style='margin:20px 0 0 40px;'>").
			        		append("<a href='http://192.168.0.216:9090/home/registAuthorize?email=").
			        		append(vo.getEmail()).append("&code=").append(vo.getCode()).
			        		append("' target='_blank'><button style='border:none; width:150px; height:30px; border-radius:10px; background-color:rgb(0,176,176); color:#fff;'><b>이메일 인증하기</b></button></a>").
			        		append("</div>").
			        		append("<div style='margin:20px 0 0 40px; height:30px; width:60%; background-color:#eee;'>").
			        		append("<p style='padding-top:5px;'>본 메일은 발신전용입니다. 궁금하신 점이나 불편하신 사항은 고객센터를 이용해 주시기 바랍니다.</p>").
			        		append("</div></div>").toString());
			        
			        sendMail.setInline("bikemapLogo", "D:\\workspaceSpring\\TeamProject_BikeMap\\src\\main\\webapp\\img\\img_logo\\bikemap.png");
			        sendMail.setFrom("project.bikemap@gmail.com", "바이크맵");
			        
			        sendMail.setTo(vo.getEmail());
		        sendMail.send();
			}
			
			transactionManager.commit(status);
		}catch(Exception e) {
			System.out.println("회원 가입 오류 " + e.getStackTrace());
			transactionManager.rollback(status);
		}
		return result;
	}

	
	// 인증 절차
	@RequestMapping("/registAuthorize")
	public ModelAndView registAuthorize(RegistVO vo) {
		ModelAndView mav = new ModelAndView();		
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		
		try {
			vo = dao.checkAuth(vo);
	
			if(vo.getActive().equals("Y")) {
				mav.addObject("msg", "이미 인증이 완료된 아이디입니다.");
			}else {
				if(dao.authorizeUser(vo)==1) {
					mav.addObject("msg", vo.getUsername()+"님 인증이 완료되었습니다. 로그인 후 이용해주십시오.");
				}else {
					mav.addObject("msg", "인증에 실패했습니다. 다시 시도해주십시오.");
				}
			}
		}catch(Exception e) {
			System.out.println("이메일 인증 에러 " + e.getMessage());
		}
		
		mav.setViewName("regist/authorResult");	
		return mav;
	}
	
	
	// 회원 가입 완료 시 이동하는 주소
	@RequestMapping("/registWelcome")
	public String registWelcome() {
		return "/regist/registWelcome";
	}
	
	// 로그인 페이지로 이동하는 주소
	@RequestMapping("/login")
	public String login() {
		return "/regist/login";
	}
	
	// 로그인 체크
	@RequestMapping("/loginOk")
	@ResponseBody
	public RegistVO loginOk(RegistVO vo, HttpSession session) {
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		RegistVO result = new RegistVO();
		
		try {
			RegistVO chk = dao.login(vo);
			if(chk != null) {
				if(chk.getActive().equals("Y")) {
					RegistVO chk2 = dao.selectCause(chk);
					if(chk2 == null) {
						session.setAttribute("logStatus", "Y");
						session.setAttribute("logId", chk.getUserid());
						session.setAttribute("logName", chk.getUsername());				
						result.setLoginResult(1);
					}else {
						result.setLoginResult(3); // 정지
						result.setEndday(chk2.getEndday());
						result.setCause(chk2.getCause());
					}		
				}else {
					result.setLoginResult(2); // 미인증
				}
			}else {
				result.setLoginResult(0);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "/home";
	}
	
	// 회원 정보 수정
	@RequestMapping("/registEdit")
	public String registEdit() {
		return "/regist/registEdit";
	}
	
	// 회원 정보 수정을 위한 비밀번호 확인
	@RequestMapping("/registPwdChk")
	@ResponseBody
	public int registEditPwdChk(RegistVO vo, HttpSession session) {
		int result = 0;
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		RegistVO resultVO = dao.login(vo);
		
		try {
			if(resultVO.getUsername() != null) {
				session.setAttribute("pwdChk", "Y");
				result = 1;
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	// 회원 정보 수정 폼으로 이동
	@RequestMapping("/registEditForm")
	public ModelAndView registEditForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		try {
			if( session.getAttribute("pwdChk") == null) {
				mav.setViewName("redirect:/registEdit");
				return mav;
			}
			
			RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
			RegistVO vo = dao.selectUser((String)session.getAttribute("logId"));
			
			mav.addObject("user", vo);
		}catch(Exception e) {
			System.out.println("회원 정보 읽기 에러" + e.getMessage());
		}

		mav.setViewName("/regist/registEditForm");
		
		return mav;
	}
	
	// 회원 정보 수정 처리
	@RequestMapping("/registerEditFormOk")
	@ResponseBody
	public int registEditFormOk(RegistVO vo, HttpSession ses) {		
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		int result = 0;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		vo.setUserid((String)ses.getAttribute("logId"));
		try {
			String emailBefore = dao.selectUserEmail(vo);
			if(emailBefore.equals(vo.getEmail())) {
				result = dao.updateUser(vo);
			}else {
				// vo에 인증 코드 세팅
				vo.setCode(new TempKey().getKey(48));

				// 인증 여부 취소
				result = dao.updateUser2(vo);
				
				// 이메일 발송
				if(result == 1) {
					MailHandler sendMail = new MailHandler(mailSender);
			        sendMail.setSubject("[바이크맵] 회원 인증 메일입니다.");
			        
			        sendMail.setText(
			        		new StringBuffer().append("<div class='container'>").
			        		append("<img src='cid:bikemapLogo' style='width:400px; margin-top:-60px'>").
			        		append("<h1 style='margin:-100px 0 0 40px; z-index:9; color:rgb(0,176,176)'>").
			        		append("<b>이메일 주소 인증</b></h1>").
			        		append("<div style='margin:20px 0 0 40px'>").
			        		append("<p>안녕하세요. bikemap입니다.</p>").
			        		append("<p style='margin-top:20px'>회원가입을 위한 본인인증절차를 완료하기 위해<br/>").
			        		append("아래 링크를 클릭하여 주세요.</p></div>").
			        		append("<div style='margin:20px 0 0 40px;'>").
			        		append("<a href='http://192.168.0.216:9090/home/registAuthorize?email=").
			        		append(vo.getEmail()).append("&code=").append(vo.getCode()).
			        		append("' target='_blank'><button style='border:none; width:150px; height:30px; border-radius:10px; background-color:rgb(0,176,176); color:#fff;'><b>이메일 인증하기</b></button></a>").
			        		append("</div>").
			        		append("<div style='margin:20px 0 0 40px; height:30px; width:60%; background-color:#eee;'>").
			        		append("<p style='padding-top:5px;'>본 메일은 발신전용입니다. 궁금하신 점이나 불편하신 사항은 고객센터를 이용해 주시기 바랍니다.</p>").
			        		append("</div></div>").toString());
			        		
			        sendMail.setInline("bikemapLogo", "D:\\workspaceSpring\\TeamProject_BikeMap\\src\\main\\webapp\\img\\img_logo\\bikemap.png");
			        sendMail.setFrom("project.bikemap@gmail.com", "바이크맵");
			        
			        sendMail.setTo(vo.getEmail());
			        sendMail.send();
				}
				result = 2;
			}
			transactionManager.commit(status);
		}catch(Exception e) {
			System.out.println("회원 정보 수정 에러 "+ e.getMessage());
			transactionManager.rollback(status);
			result = 0;
		}
		return result;
	}
	
	// 회원 탈퇴 신청 페이지 이동
	@RequestMapping("/registDel")
	public String registDelUser() {
		return "regist/registDel";
	}
	
	// 회원 탈퇴 비밀번호 확인
	@RequestMapping("/registDelChk")
	public String registDelChk() {
		return "regist/registDelChk";
	}
	
	// 회원 탈퇴 시 비밀번호 확인 및 아이디 삭제
	@RequestMapping("/registDelPwdChk")
	@ResponseBody
	public int registDelPwdChk(RegistVO vo, HttpSession session) {
		int result = 0;
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		
		try {
			RegistVO resultVO = dao.login(vo);
			if(resultVO.getUsername() != null) {
				result = dao.delUser(vo);
			}
		}catch(Exception e) {
			System.out.println("회원 탈퇴 오류 " + e.getMessage());
		}
		return result;
	}
	
	// 회원 탈퇴 성공 메세지
	@RequestMapping("/registDelMessage")
	public String registDelMessage() {
		return "regist/registDelMessage";
	}
	
	// 회원정보 찾기
	@RequestMapping("/registFindInfo")
	public String registFirdInfo() {
		return "regist/registFindInfo";
	}
	
	// 회원 아이디 찾기
	@RequestMapping(value = "/registFindId", method=RequestMethod.POST, produces="application/text;charset=UTF-8")
	@ResponseBody
	public String registFindId(RegistVO vo) {
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		String result = "입력한 정보와 일치하는 회원 정보가 없습니다." ;
		
		try {
			RegistVO resultVO = dao.registFindId(vo);

			if(resultVO.getUserid() != null) { 
				String userid = resultVO.getUserid();
				result = userid.substring(0,3);
				for (int i = 0 ; i < userid.length()-3 ; i++) {
					result = result +"*";
				}
			}
		}catch(Exception e) {
			System.out.println("회원 아이디 찾기 에러" + e.getMessage());
		}
		return result;
	}
	
	// 회원 비밀번호 찾기
	@RequestMapping(value="/registFindPwd", method=RequestMethod.POST)
	@ResponseBody
	public int registFindPwd(RegistVO vo) {
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		int result = 0;
	
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		// 입력한 회원정보로 일치하는 회원 내역이 있는 지 확인
		try {
			RegistVO resultVO = dao.registFindPwd(vo);			
			if(resultVO.getEmail() != null) {
				result = 1;
				
				// 임시 비밀번호 발송하는 메서드 필요
				// 임시 비밀번호로 db 업데이트
				
				String tempPwd = new TempKey().getKey(16);
				
				MailHandler sendMail = new MailHandler(mailSender);
		        sendMail.setSubject("[바이크맵] 임시 비밀번호입니다.");
		        
		        sendMail.setText(
		        		new StringBuffer().append("<div class='container'>").
		        		append("<img src='cid:bikemapLogo' style='width:400px; margin-top:-60px'>").
		        		append("<h1 style='margin:-100px 0 0 40px; z-index:9; color:rgb(0,176,176)'>").
		        		append("<b>임시 비밀번호</b></h1>").
		        		append("<div style='margin:20px 0 0 40px'>").
		        		append("<p>"+resultVO.getUserid()+" 회원님의 임시 비밀번호가 설정되었습니다.<br/>임시 비밀번호로 접속하신 후 비밀번호 변경하시기 바랍니다.<br/></div>").
		        		append("<div style='margin:20px 0 0 40px'>").
		        		append("임시 비밀번호 : " +tempPwd +"</div><br/>").
		        		append("<div style='margin:20px 0 0 40px'>").
		        		append("<a href='http://192.168.0.216:9090/home/login'target='_blank'><button style='border:none; width:150px; height:30px; border-radius:10px; background-color:rgb(0,176,176); color:#fff;'><b>로그인 하러 가기</b></button></a></div></div>").toString());
		        
		        sendMail.setInline("bikemapLogo", "D:\\workspaceSpring\\TeamProject_BikeMap\\src\\main\\webapp\\img\\img_logo\\bikemap.png");
		        sendMail.setFrom("project.bikemap@gmail.com", "바이크맵");
		        sendMail.setTo(resultVO.getEmail());
		        
		        sendMail.send();
		        
		        resultVO.setUserpwd(tempPwd);
		        result = dao.updateUser(resultVO);
			}
			
			transactionManager.commit(status);
		}catch(Exception e) {
			System.out.println("비밀번호 찾기 에러 " + e.getMessage());
			transactionManager.rollback(status);
			result = 0;
		}
		
		return result;
	}
	
	// 로그인 팝업 띄우기
	@RequestMapping("/loginPopup")
	public String loginPopup() {
		return "popup/login";
			
	}
	
	// 쪽지 보내기 아이디 검색
	@RequestMapping("/searchId")
	@ResponseBody
	public List<String> searchId(@RequestParam("keyword")String keyword){
		List<String> list = new ArrayList<String>();
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);

		try {
			list = dao.searchId(keyword);
		}catch(Exception e) {
			System.out.println("아이디 검색 에러" + e.getMessage());
		}
		return list;
	}
	
	// 투어 카운트 체크
	@RequestMapping("/checkTourcnt")
	@ResponseBody
	public int checkTourcnt(HttpSession ses) {
		int result = 0;
		RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
		try {
			result = dao.selectTourcnt((String)ses.getAttribute("logId"));
		}catch(Exception e) {
			System.out.println("투어 참가 횟수 확인 에러 " + e.getMessage());
		}
		return result;
	}
}