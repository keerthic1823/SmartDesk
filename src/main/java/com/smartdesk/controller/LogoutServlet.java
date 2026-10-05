package com.smartdesk.controller;
import java.io.IOException;import jakarta.servlet.annotation.WebServlet;import jakarta.servlet.http.*;
@WebServlet("/LogoutServlet") public class LogoutServlet extends HttpServlet{protected void doGet(HttpServletRequest q,HttpServletResponse p)throws IOException{HttpSession s=q.getSession(false);if(s!=null)s.invalidate();p.sendRedirect(q.getContextPath()+"/login.jsp?logout=true");}}
