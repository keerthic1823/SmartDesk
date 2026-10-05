package com.smartdesk.controller;

import java.io.IOException;
import java.util.List;

import com.smartdesk.model.Ticket;
import com.smartdesk.model.User;
import com.smartdesk.service.TicketService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminTicketsServlet")
public class AdminTicketsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // ADMIN ONLY
        if (!"ADMIN".equalsIgnoreCase(user.getRole())) {

            response.sendRedirect(
                    request.getContextPath() + "/dashboard.jsp");

            return;
        }

        TicketService ticketService =
                new TicketService();

        List<Ticket> tickets =
                ticketService.getAllTickets();

        request.setAttribute("tickets", tickets);

        request.getRequestDispatcher(
                "/admin-tickets.jsp")
                .forward(request, response);
    }
}