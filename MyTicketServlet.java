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

@WebServlet("/MyTicketServlet")
public class MyTicketServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("===== MyTicketServlet STARTED =====");

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {

            System.out.println("USER IS NULL");

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );

            return;
        }

        System.out.println("User ID: " + user.getUserId());

        TicketService ticketService = new TicketService();

        List<Ticket> tickets =
                ticketService.getTicketsByUser(user.getUserId());

        System.out.println("Tickets Found: " + tickets.size());

        request.setAttribute("tickets", tickets);

        request.getRequestDispatcher("/my-tickets.jsp")
               .forward(request, response);
    }
}