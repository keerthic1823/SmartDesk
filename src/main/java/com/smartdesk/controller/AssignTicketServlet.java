package com.smartdesk.controller;

import java.io.IOException;

import com.smartdesk.model.User;
import com.smartdesk.service.TicketService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AssignTicketServlet")
public class AssignTicketServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // Admin check
        if (user == null ||
            !"ADMIN".equalsIgnoreCase(user.getRole())) {

            response.sendRedirect(
                request.getContextPath() + "/dashboard.jsp"
            );

            return;
        }

        int ticketId =
                Integer.parseInt(request.getParameter("ticketId"));

        int employeeId =
                Integer.parseInt(request.getParameter("employeeId"));

        TicketService ticketService = new TicketService();

        boolean success =
                ticketService.assignTicket(ticketId, employeeId);

        if (success) {

            response.sendRedirect(
                request.getContextPath()
                + "/AdminTicketsServlet?success=assigned"
            );

        } else {

            response.sendRedirect(
                request.getContextPath()
                + "/AdminTicketsServlet?error=assign"
            );
        }
    }
}