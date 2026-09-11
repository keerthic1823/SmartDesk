package com.smartdesk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.smartdesk.model.Ticket;
import com.smartdesk.util.DBConnection;

public class TicketDAO {

    public boolean createTicket(Ticket ticket) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {
            String sql = "INSERT INTO tickets "
                       + "(title, description, category, priority, created_by) "
                       + "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, ticket.getTitle());
            ps.setString(2, ticket.getDescription());
            ps.setString(3, ticket.getCategory());
            ps.setString(4, ticket.getPriority());
            ps.setInt(5, ticket.getCreatedBy());

            int n = ps.executeUpdate();

            return n > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    public List<Ticket> getTicketsByUser(int userId) {

        List<Ticket> tickets = new ArrayList<>();

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {

            String sql = "SELECT ticket_id, title, description, category, "
                       + "priority, status, created_by, assigned_to, "
                       + "created_at, updated_at "
                       + "FROM tickets "
                       + "WHERE created_by = ? "
                       + "ORDER BY ticket_id ASC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            var rs = ps.executeQuery();

            while (rs.next()) {

                Ticket ticket = new Ticket();

                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setTitle(rs.getString("title"));
                ticket.setDescription(rs.getString("description"));
                ticket.setCategory(rs.getString("category"));
                ticket.setPriority(rs.getString("priority"));
                ticket.setStatus(rs.getString("status"));
                ticket.setCreatedBy(rs.getInt("created_by"));
                ticket.setAssignedTo(rs.getInt("assigned_to"));
                ticket.setCreatedAt(rs.getString("created_at"));
                ticket.setUpdatedAt(rs.getString("updated_at"));

                tickets.add(ticket);
            }

            System.out.println("User ID: " + userId);
            System.out.println("Tickets Found: " + tickets.size());

        } catch (Exception e) {

            e.printStackTrace();

        }

        return tickets;
    }
  public int getTotalTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {
            String sql = "SELECT COUNT(*) FROM tickets WHERE created_by = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            var rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    public int getOpenTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {
            String sql = "SELECT COUNT(*) FROM tickets "
                       + "WHERE created_by = ? AND status = 'OPEN'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            var rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    public int getInProgressTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {
            String sql = "SELECT COUNT(*) FROM tickets "
                       + "WHERE created_by = ? AND status = 'IN_PROGRESS'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            var rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    public int getResolvedTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {
            String sql = "SELECT COUNT(*) FROM tickets "
                       + "WHERE created_by = ? AND status = 'RESOLVED'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            var rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
    public List<Ticket> getAllTickets() {

        DBConnection dc = new DBConnection();

        Connection con = dc.getConnection();

        List<Ticket> tickets = new ArrayList<>();

        try {

            String sql =
                "SELECT * FROM tickets ORDER BY created_at DESC";

            PreparedStatement ps =
                con.prepareStatement(sql);

            var rs = ps.executeQuery();

            while (rs.next()) {

                Ticket ticket = new Ticket();

                ticket.setTicketId(
                    rs.getInt("ticket_id")
                );

                ticket.setTitle(
                    rs.getString("title")
                );

                ticket.setDescription(
                    rs.getString("description")
                );

                ticket.setCategory(
                    rs.getString("category")
                );

                ticket.setPriority(
                    rs.getString("priority")
                );

                ticket.setStatus(
                    rs.getString("status")
                );

                ticket.setCreatedBy(
                    rs.getInt("created_by")
                );

                ticket.setAssignedTo(
                    rs.getInt("assigned_to")
                );

                ticket.setCreatedAt(
                    rs.getString("created_at")
                );

                ticket.setUpdatedAt(
                    rs.getString("updated_at")
                );

                tickets.add(ticket);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return tickets;
    }
}