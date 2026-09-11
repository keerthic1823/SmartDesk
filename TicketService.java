package com.smartdesk.service;

import java.util.List;

import com.smartdesk.dao.TicketDAO;
import com.smartdesk.model.Ticket;

public class TicketService {

    TicketDAO ticketDAO = new TicketDAO();


    public boolean createTicket(Ticket ticket) {

        return ticketDAO.createTicket(ticket);

    }


    public List<Ticket> getTicketsByUser(int userId) {

        return ticketDAO.getTicketsByUser(userId);

    }




    public int getTotalTickets(int userId) {

        return ticketDAO.getTotalTickets(userId);

    }


    public int getOpenTickets(int userId) {

        return ticketDAO.getOpenTickets(userId);

    }


    public int getInProgressTickets(int userId) {

        return ticketDAO.getInProgressTickets(userId);

    }


    public int getResolvedTickets(int userId) {

        return ticketDAO.getResolvedTickets(userId);

    }
    public List<Ticket> getAllTickets() {

        return ticketDAO.getAllTickets();

    }
}