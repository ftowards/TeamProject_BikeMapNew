package com.bikemap.home.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class NoticeHandler extends TextWebSocketHandler{
	
	//로그인 시
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	// 서버에 접속 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		sessions.add(session);
		
		Map<String, Object> httpSession = session.getAttributes();
		String loginId = (String)httpSession.get("logId");
		System.out.println(loginId);
		
		userSessionsMap.put(loginId, session);
		
		System.out.println(userSessionsMap.size());
	}
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		
		String msg = message.getPayload();
		System.out.println(msg);
		if(!StringUtils.isEmpty(msg)) {
			String[] msgs = msg.split(",");
			
			String msgType = msgs[0];
			String receiver = msgs[1];
			String sender = msgs[2]; 
			String noboard = msgs[3];
			
			WebSocketSession boardWriterSession = userSessionsMap.get(receiver);
			if(boardWriterSession != null) {
				if(msgType.equals("routeReply")) {
					TextMessage tmpMsg = new TextMessage("<a href='/home/routeSearchView?noboard="+noboard+"'>"+sender + "님이 " + noboard + "번 루트에 댓글을 달았습니다.</a>");
					boardWriterSession.sendMessage(tmpMsg);
					System.out.println(tmpMsg);
				}
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		System.out.println(session.getId()+ "연결 종료");
		userSessionsMap.remove(session.getId());
		sessions.remove(session);
	}
	
	//
}


/////////*

//public class EchoHandler extends TextWebSocketHandler {
//	//로그인 한 전체
//	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
//	// 1대1
//	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
//		
//	//서버에 접속이 성공 했을때
//	@Override
//	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//		sessions.add(session);
//		
//		String senderEmail = getEmail(session);
//		userSessionsMap.put(senderEmail , session);
//	}
