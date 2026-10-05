package com.smartdesk.controller;
import java.io.IOException;import com.smartdesk.model.User;import com.smartdesk.service.TicketService;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/MyTicketServlet") public class MyTicketServlet extends HttpServlet{
 protected void doGet(HttpServletRequest q,HttpServletResponse p)throws IOException,jakarta.servlet.ServletException{
  User u=(User)q.getSession().getAttribute("user");if(u==null){p.sendRedirect(q.getContextPath()+"/login.jsp");return;}
  q.setAttribute("tickets",new TicketService().getTicketsByUser(u.getUserId()));q.getRequestDispatcher("/my-tickets.jsp").forward(q,p);
 }
}
