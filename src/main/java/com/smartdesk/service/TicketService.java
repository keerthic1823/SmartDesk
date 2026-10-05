package com.smartdesk.service;

import java.util.List;

import com.smartdesk.dao.TicketDAO;
import com.smartdesk.model.Ticket;

public class TicketService {

    private TicketDAO ticketDAO = new TicketDAO();


    // ==========================================
    // CREATE TICKET
    // ==========================================

    public boolean createTicket(Ticket ticket) {

        return ticketDAO.createTicket(ticket);

    }


    // ==========================================
    // GET USER TICKETS
    // ==========================================

    public List<Ticket> getTicketsByUser(int userId) {

        return ticketDAO.getTicketsByUser(userId);

    }


    // ==========================================
    // GET ALL TICKETS
    // ==========================================

    public List<Ticket> getAllTickets() {

        return ticketDAO.getAllTickets();

    }


    // ==========================================
    // GET TICKET BY ID
    // ==========================================

    public Ticket getTicketById(int ticketId) {

        return ticketDAO.getTicketById(ticketId);

    }


    // ==========================================
    // DASHBOARD - TOTAL
    // ==========================================

    public int getTotalTickets(int userId) {

        return ticketDAO.getTotalTickets(userId);

    }


    // ==========================================
    // DASHBOARD - OPEN
    // ==========================================

    public int getOpenTickets(int userId) {

        return ticketDAO.getOpenTickets(userId);

    }


    // ==========================================
    // DASHBOARD - IN PROGRESS
    // ==========================================

    public int getInProgressTickets(int userId) {

        return ticketDAO.getInProgressTickets(userId);

    }


    // ==========================================
    // DASHBOARD - RESOLVED
    // ==========================================

    public int getResolvedTickets(int userId) {

        return ticketDAO.getResolvedTickets(userId);

    }


    // ==========================================
    // UPDATE STATUS
    // ==========================================

    public boolean updateStatus(
            int ticketId,
            String status) {

        return ticketDAO.updateStatus(ticketId, status);

    }


    // ==========================================
    // ASSIGN TICKET
    // ==========================================

    public boolean assignTicket(
            int ticketId,
            int userId) {

        return ticketDAO.assignTicket(
                ticketId,
                userId
        );

    }


    // ==========================================
    // SEARCH USER TICKETS
    // ==========================================

    public List<Ticket> searchTickets(
            int userId,
            String search,
            String status,
            String priority,
            String category) {

        return ticketDAO.searchTickets(
                userId,
                search,
                status,
                priority,
                category
        );

    }

}