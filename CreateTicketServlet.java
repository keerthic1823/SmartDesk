package com.smartdesk.controller;

import java.io.IOException;

import com.smartdesk.model.Ticket;
import com.smartdesk.model.User;
import com.smartdesk.service.TicketService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CreateTicketServlet")
public class CreateTicketServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("===== CREATE TICKET SERVLET STARTED =====");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priority = request.getParameter("priority");

        System.out.println("Title       : " + title);
        System.out.println("Description : " + description);
        System.out.println("Category    : " + category);
        System.out.println("Priority    : " + priority);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {

            System.out.println("USER SESSION NOT FOUND");

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );

            return;
        }

        System.out.println("Logged User ID : " + user.getUserId());

        Ticket ticket = new Ticket();

        ticket.setTitle(title);
        ticket.setDescription(description);
        ticket.setCategory(category);
        ticket.setPriority(priority);
        ticket.setCreatedBy(user.getUserId());

        TicketService ticketService = new TicketService();

        boolean status = ticketService.createTicket(ticket);

        System.out.println("Ticket Insert Status : " + status);

        if (status) {

            System.out.println("===== TICKET CREATED SUCCESSFULLY =====");

            response.sendRedirect(
                request.getContextPath()
                + "/create-ticket.jsp?success=true"
            );

        } else {

            System.out.println("===== TICKET CREATION FAILED =====");

            response.sendRedirect(
                request.getContextPath()
                + "/create-ticket.jsp?error=true"
            );
        }
    }
}