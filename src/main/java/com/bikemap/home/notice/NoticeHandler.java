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
				TextMessage tmpMsg = new TextMessage("");
				if(msgType.equals("routeReply")) {
					tmpMsg = new TextMessage("<a href='/home/routeSearchView?noboard="+noboard+"' target='_blank'>"+sender + "님이 " + noboard + "번 루트에 댓글을 달았습니다.</a>");					
				}else if(msgType.equals("confirmTour")) {
					tmpMsg = new TextMessage("<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+sender + "님이 " + noboard + "번 투어 참가를 승인하였습니다.</a>");
				}else if(msgType.equals("revertTour")) {
					tmpMsg = new TextMessage("<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소처리 하였습니다.</a>");
				}else if(msgType.equals("applyTour")) {
					tmpMsg = new TextMessage("<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가 신청하였습니다.</a>");
				}else if(msgType.equals("cancelTour")) {
					tmpMsg = new TextMessage("<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소하였습니다.</a>");
				}else if(msgType.equals("absentTour")) {
					tmpMsg = new TextMessage("<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ noboard + "번 투어가 불참 처리되었습니다.</a>");
				}else if(msgType.equals("completeTour")) {
					tmpMsg = new TextMessage("<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ noboard + "번 투어가 완료되었습니다.</a>");
				}else if(msgType.equals("sendMsg")) {
					tmpMsg = new TextMessage(sender + " : " +noboard);
				}else if(msgType.equals("scrapRoute")) {
					tmpMsg = new TextMessage("<a href='/home/routeSearchView?noboard="+noboard+"' target='_blank'>"+ noboard + "번 루트가 추천 루트로 등록되었습니다.</a>");
				}else if(msgType.equals("scrapReview")) {
					tmpMsg = new TextMessage("<a href='/home/routeSearchView?noboard="+noboard+"' target='_blank'>"+ noboard + "번 후기가 추천 후기로 등록되었습니다.</a>");
				}else if(msgType.equals("tourReply")) {
					tmpMsg = new TextMessage("<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+sender + "님이 " + noboard + "번 투어에 댓글을 달았습니다.</a>");					
				}else if(msgType.equals("reviewReply")) {
					tmpMsg = new TextMessage("<a href='/home/reviewView?noboard="+noboard+"' target='_blank'>"+sender + "님이 " + noboard + "번 후기에 댓글을 달았습니다.</a>");					
				}else if(msgType.equals("cancelTourAdmin")) {
					tmpMsg = new TextMessage(sender + "님이 " + noboard + "번 투어를 취소하였습니다.");	
				}
				
				boardWriterSession.sendMessage(tmpMsg);
				System.out.println(tmpMsg);
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		System.out.println(session.getId()+ "연결 종료");
		userSessionsMap.remove(session.getId());
		sessions.remove(session);
	}
}

