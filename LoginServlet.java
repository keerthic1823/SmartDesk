package com.smartdesk.controller;

import java.io.IOException;

import com.smartdesk.model.User;
import com.smartdesk.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserService us = new UserService();

        User user = us.loginUser(email, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);

            // ADMIN
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                    request.getContextPath() + "/admin-dashboard.jsp"
                );

            }

            // EMPLOYEE
            else {

                response.sendRedirect(
                    request.getContextPath() + "/dashboard.jsp"
                );

            }

        } else {

            response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?error=invalid"
            );
        }
    }
}