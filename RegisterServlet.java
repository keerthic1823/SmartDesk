package com.smartdesk.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.smartdesk.model.User;
import com.smartdesk.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("===== RegisterServlet STARTED =====");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String department = request.getParameter("department");

        System.out.println("Name       : " + name);
        System.out.println("Email      : " + email);
        System.out.println("Password   : " + password);
        System.out.println("Role       : " + role);
        System.out.println("Department : " + department);

        User u = new User();

        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);
        u.setRole(role);
        u.setDepartment(department);

        UserService us = new UserService();

        boolean status = us.registerUser(u);

        System.out.println("Database Insert Status : " + status);

        if (status) {

            System.out.println("Registration Successful");

            response.sendRedirect(
                request.getContextPath() + "/login.jsp?registered=true"
            );

        } else {

            System.out.println("Registration Failed");

            response.sendRedirect(
                request.getContextPath() + "/register.jsp?error=failed"
            );
        }

        System.out.println("===== RegisterServlet FINISHED =====");
    }
}