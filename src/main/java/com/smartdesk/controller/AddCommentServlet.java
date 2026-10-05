package com.smartdesk.controller;
import java.io.IOException;import com.smartdesk.model.*;import com.smartdesk.service.CommentService;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/AddCommentServlet") public class AddCommentServlet extends HttpServlet{
 protected void doPost(HttpServletRequest q,HttpServletResponse p)throws IOException{
  User u=(User)q.getSession().getAttribute("user");if(u==null){p.sendRedirect(q.getContextPath()+"/login.jsp");return;}
  Comment c=new Comment();c.setTicketId(Integer.parseInt(q.getParameter("ticketId")));c.setUserId(u.getUserId());c.setComment(q.getParameter("comment"));new CommentService().add(c);
  p.sendRedirect(q.getContextPath()+"/TicketDetailsServlet?id="+c.getTicketId());
 }
}
