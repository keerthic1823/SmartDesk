package com.smartdesk.controller;
import java.io.IOException;import com.smartdesk.model.User;import com.smartdesk.service.UserService;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/RegisterServlet") public class RegisterServlet extends HttpServlet{
 protected void doPost(HttpServletRequest q,HttpServletResponse p)throws IOException{
  User u=new User();u.setName(q.getParameter("name"));u.setEmail(q.getParameter("email"));u.setPassword(q.getParameter("password"));u.setDepartment(q.getParameter("department"));
  p.sendRedirect(q.getContextPath()+(new UserService().registerUser(u)?"/login.jsp?registered=true":"/register.jsp?error=exists"));
 }
}
