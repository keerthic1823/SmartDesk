package com.smartdesk.controller;

import java.io.IOException;

import com.smartdesk.model.User;
import com.smartdesk.service.TicketService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateTicketServlet")
public class UpdateTicketServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        User user =
                (User) session.getAttribute("user");

        if (user == null ||
            !"ADMIN".equalsIgnoreCase(user.getRole())) {

            response.sendRedirect(
                    request.getContextPath() + "/dashboard.jsp");

            return;
        }

        String ticketIdParam =
                request.getParameter("ticketId");

        String status =
                request.getParameter("status");

        try {

            int ticketId =
                    Integer.parseInt(ticketIdParam);

            TicketService ticketService =
                    new TicketService();

            boolean success =
                    ticketService.updateStatus(
                            ticketId,
                            status);

            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/AdminTicketsServlet?success=updated");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/AdminTicketsServlet?error=update");

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/AdminTicketsServlet?error=invalid");

        }
    }
}