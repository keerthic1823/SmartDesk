package com.smartdesk.controller;
import java.io.IOException;import com.smartdesk.model.*;import com.smartdesk.service.TicketService;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/CreateTicketServlet") public class CreateTicketServlet extends HttpServlet{
 protected void doPost(HttpServletRequest q,HttpServletResponse p)throws IOException{
  User u=(User)q.getSession().getAttribute("user");if(u==null){p.sendRedirect(q.getContextPath()+"/login.jsp");return;}
  Ticket t=new Ticket();t.setTitle(q.getParameter("title"));t.setDescription(q.getParameter("description"));t.setCategory(q.getParameter("category"));t.setPriority(q.getParameter("priority"));t.setCreatedBy(u.getUserId());
  p.sendRedirect(q.getContextPath()+(new TicketService().createTicket(t)?"/create-ticket.jsp?success=true":"/create-ticket.jsp?error=true"));
 }
}
