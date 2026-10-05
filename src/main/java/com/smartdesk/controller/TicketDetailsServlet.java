package com.smartdesk.controller;
import java.io.IOException;import com.smartdesk.model.User;import com.smartdesk.service.*;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/TicketDetailsServlet") public class TicketDetailsServlet extends HttpServlet{
 protected void doGet(HttpServletRequest q,HttpServletResponse p)throws IOException,jakarta.servlet.ServletException{
  User u=(User)q.getSession().getAttribute("user");if(u==null){p.sendRedirect(q.getContextPath()+"/login.jsp");return;}
  int id=Integer.parseInt(q.getParameter("id"));TicketService ts=new TicketService();var t=ts.getTicketById(id);if(t==null){p.sendRedirect(q.getContextPath()+"/dashboard.jsp");return;}
  q.setAttribute("ticket",t);q.setAttribute("comments",new CommentService().get(id));q.getRequestDispatcher("/ticket-details.jsp").forward(q,p);
 }
}
