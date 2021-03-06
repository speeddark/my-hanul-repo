package com.board.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.commons.action.Action;
import com.commons.action.ActionForward;

@WebServlet("/BoardFrontController.bo")
public class BoardFrontController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		//1. 클라이언트가 어떤 요청을 하였는지를 파악
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();			//uri-pattern 값 : /10.Member_Board/xxx.bo
		String ctx = request.getContextPath();			//context root 값 : /10.Member_Board
		String command = uri.substring(ctx.length());	//실제 요청한 페이지 : /xxx.bo
		
		//System.out.println("uri : " + uri);				
		//System.out.println("ctx : " + ctx);				
		//System.out.println("command : " + command);
		
		//2. 클라이언트의 요청(*.bo : command)과 실제 처리할 Action Class(비지니스 로직) 연결 ▶ BoardxxxAction.java
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/boardList.bo")) {
			action = new BoardListAction();
			forward = action.execute(request, response);
		}else if(command.equals("/boardWriteForm.bo")) {
			//글쓰기 화면으로만 이동 : DB 연동X
			forward = new ActionForward();
			forward.setPath("board/boardWriteForm.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/boardAddAction.bo")) {
			action = new BoardAddAction();
			forward = action.execute(request, response);
		}else if(command.equals("/boardDetailAction.bo")) {
			action = new BoardDetailAction();
			forward = action.execute(request, response);
		}else if(command.equals("/boardDeleteAction.bo")) {
			action = new BoardDeleteAction();
			forward = action.execute(request, response);
		}else if(command.equals("/boardModifyView.bo")) {
			action = new BoardModifyView();
			forward = action.execute(request, response);
		}else if(command.equals("/boardModifyAction.bo")) {
			action = new BoardModifyAction();
			forward = action.execute(request, response);
		}else if(command.equals("/boardReplyView.bo")) {
			action = new BoardReplyView();
			forward = action.execute(request, response);
		}else if(command.equals("/boardReplyAction.bo")) {
			action = new BoardReplyAction();
			forward = action.execute(request, response);
		}else if(command.equals("/boardSearch.bo")) {
			action = new BoardSearchAction();
			forward = action.execute(request, response);
		}
		
		//3. 프리젠테이션 로직(결과출력) : 페이지 전환 → forward(), sendRedirect() ▶ ActionFoward.java
		if(forward != null) {
			if(forward.isRedirect()) {	//true : sendRedirect()
				response.sendRedirect(forward.getPath());
			}else {						//false : forward()
				RequestDispatcher rd = request.getRequestDispatcher(forward.getPath());
				rd.forward(request, response);
			}
		}//if
	}
}//class
