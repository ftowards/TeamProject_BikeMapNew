package com.bikemap.home.regist;

import java.util.List;

public interface RegistDaoImp {

	// 회원 가입
	public int insertUser(RegistVO vo);

	// 로그인
	public RegistVO login(RegistVO vo);
	
	// 정지 사유 확인하기
	public RegistVO selectCause(RegistVO vo);

	// 회원 정보 선택
	public RegistVO selectUser(String userid);
	
	// 회원 정보 수정
	public int updateUser(RegistVO vo);
	
	// 회원 정보 삭제
	public int delUser(RegistVO vo);
	
	// 회원 아이디 찾기
	public RegistVO registFindId(RegistVO vo);
	
	// 회원 비밀번호 찾기 - 일치하는 정보가 있는 지 확인
	public RegistVO registFindPwd(RegistVO vo);
	
	// 인증되어 있는지 확인
	public RegistVO checkAuth(RegistVO vo);
	
	// 아이디 활성화
	public int authorizeUser(RegistVO vo);
	
	// 아이디 중복 확인
	public int idDoubleChk(String userid);
	
	// 이메일 중복 확인
	public int emailDoubleChk(String email);
	
	// 아이디 찾기
	public List<String> searchId(String word);
	
	// 투어 카운트 확인하기
	public int selectTourcnt(String userid);
	
	// 이메일 확인
	public String selectUserEmail(RegistVO vo);
	
	// 회원 정보 수정 2
	public int updateUser2(RegistVO vo);

}