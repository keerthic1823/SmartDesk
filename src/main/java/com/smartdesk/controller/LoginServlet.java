package com.smartdesk.controller;
import java.io.IOException;import com.smartdesk.model.User;import com.smartdesk.service.UserService;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/LoginServlet") public class LoginServlet extends HttpServlet{
 protected void doPost(HttpServletRequest q,HttpServletResponse p)throws IOException{
  User u=new UserService().loginUser(q.getParameter("email"),q.getParameter("password"));
  if(u==null){p.sendRedirect(q.getContextPath()+"/login.jsp?error=invalid");return;}
  q.getSession().setAttribute("user",u);
  p.sendRedirect(q.getContextPath()+("/ADMIN".equalsIgnoreCase(u.getRole())?"/admin-dashboard.jsp":"/dashboard.jsp"));
 }
}
