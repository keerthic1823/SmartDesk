package com.smartdesk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.smartdesk.model.Ticket;
import com.smartdesk.util.DBConnection;

public class TicketDAO {

    // =====================================================
    // CREATE TICKET
    // =====================================================

    public boolean createTicket(Ticket ticket) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {

            String sql =
                    "INSERT INTO tickets " +
                    "(title, description, category, priority, status, created_by) " +
                    "VALUES (?, ?, ?, ?, 'OPEN', ?)";

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


    // =====================================================
    // GET TICKETS CREATED BY LOGGED-IN USER
    // =====================================================

    public List<Ticket> getTicketsByUser(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        List<Ticket> tickets = new ArrayList<>();

        try {

            String sql =
                    "SELECT * FROM tickets " +
                    "WHERE created_by = ? " +
                    "ORDER BY created_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Ticket ticket = new Ticket();

                ticket.setTicketId(
                        rs.getInt("ticket_id"));

                ticket.setTitle(
                        rs.getString("title"));

                ticket.setDescription(
                        rs.getString("description"));

                ticket.setCategory(
                        rs.getString("category"));

                ticket.setPriority(
                        rs.getString("priority"));

                ticket.setStatus(
                        rs.getString("status"));

                ticket.setCreatedBy(
                        rs.getInt("created_by"));

                ticket.setAssignedTo(
                        rs.getInt("assigned_to"));

                ticket.setCreatedAt(
                        rs.getString("created_at"));

                ticket.setUpdatedAt(
                        rs.getString("updated_at"));

                tickets.add(ticket);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return tickets;
    }


    // =====================================================
    // GET ALL TICKETS
    // =====================================================

    public List<Ticket> getAllTickets() {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        List<Ticket> tickets = new ArrayList<>();

        try {

            String sql =
                    "SELECT * FROM tickets " +
                    "ORDER BY created_at DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Ticket ticket = new Ticket();

                ticket.setTicketId(
                        rs.getInt("ticket_id"));

                ticket.setTitle(
                        rs.getString("title"));

                ticket.setDescription(
                        rs.getString("description"));

                ticket.setCategory(
                        rs.getString("category"));

                ticket.setPriority(
                        rs.getString("priority"));

                ticket.setStatus(
                        rs.getString("status"));

                ticket.setCreatedBy(
                        rs.getInt("created_by"));

                ticket.setAssignedTo(
                        rs.getInt("assigned_to"));

                ticket.setCreatedAt(
                        rs.getString("created_at"));

                ticket.setUpdatedAt(
                        rs.getString("updated_at"));

                tickets.add(ticket);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return tickets;
    }


    // =====================================================
    // GET TOTAL TICKETS
    // =====================================================

    public int getTotalTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        int count = 0;

        try {

            String sql =
                    "SELECT COUNT(*) " +
                    "FROM tickets " +
                    "WHERE created_by = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }


    // =====================================================
    // GET OPEN TICKETS
    // =====================================================

    public int getOpenTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        int count = 0;

        try {

            String sql =
                    "SELECT COUNT(*) " +
                    "FROM tickets " +
                    "WHERE created_by = ? " +
                    "AND status = 'OPEN'";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }


    // =====================================================
    // GET IN-PROGRESS TICKETS
    // =====================================================

    public int getInProgressTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        int count = 0;

        try {

            String sql =
                    "SELECT COUNT(*) " +
                    "FROM tickets " +
                    "WHERE created_by = ? " +
                    "AND status = 'IN_PROGRESS'";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }


    // =====================================================
    // GET RESOLVED TICKETS
    // =====================================================

    public int getResolvedTickets(int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        int count = 0;

        try {

            String sql =
                    "SELECT COUNT(*) " +
                    "FROM tickets " +
                    "WHERE created_by = ? " +
                    "AND status = 'RESOLVED'";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }


    // =====================================================
    // GET TICKET BY ID
    // =====================================================

    public Ticket getTicketById(int ticketId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        Ticket ticket = null;

        try {

            String sql =
                    "SELECT t.*, " +
                    "u1.name AS creator_name, " +
                    "u2.name AS assignee_name " +
                    "FROM tickets t " +
                    "LEFT JOIN users u1 " +
                    "ON t.created_by = u1.user_id " +
                    "LEFT JOIN users u2 " +
                    "ON t.assigned_to = u2.user_id " +
                    "WHERE t.ticket_id = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, ticketId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                ticket = new Ticket();

                ticket.setTicketId(
                        rs.getInt("ticket_id"));

                ticket.setTitle(
                        rs.getString("title"));

                ticket.setDescription(
                        rs.getString("description"));

                ticket.setCategory(
                        rs.getString("category"));

                ticket.setPriority(
                        rs.getString("priority"));

                ticket.setStatus(
                        rs.getString("status"));

                ticket.setCreatedBy(
                        rs.getInt("created_by"));

                ticket.setAssignedTo(
                        rs.getInt("assigned_to"));

                ticket.setCreatedAt(
                        rs.getString("created_at"));

                ticket.setUpdatedAt(
                        rs.getString("updated_at"));
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return ticket;
    }


    // =====================================================
    // UPDATE TICKET STATUS
    // =====================================================

    public boolean updateStatus(int ticketId, String status) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {

            String sql =
                    "UPDATE tickets " +
                    "SET status = ? " +
                    "WHERE ticket_id = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, ticketId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }


    // =====================================================
    // ASSIGN TICKET
    // =====================================================

    public boolean assignTicket(int ticketId, int userId) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        try {

            String sql =
                    "UPDATE tickets " +
                    "SET assigned_to = ?, " +
                    "status = 'ASSIGNED' " +
                    "WHERE ticket_id = ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, ticketId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }


    // =====================================================
    // SEARCH TICKETS
    // =====================================================

    public List<Ticket> searchTickets(
            int userId,
            String search,
            String status,
            String priority,
            String category) {

        DBConnection dc = new DBConnection();
        Connection con = dc.getConnection();

        List<Ticket> tickets = new ArrayList<>();

        try {

            StringBuilder sql =
                    new StringBuilder(
                        "SELECT * FROM tickets " +
                        "WHERE created_by = ? "
                    );

            List<Object> params =
                    new ArrayList<>();

            params.add(userId);


            if (search != null &&
                !search.trim().isEmpty()) {

                sql.append(
                    "AND (title LIKE ? " +
                    "OR description LIKE ?) "
                );

                String value =
                        "%" + search.trim() + "%";

                params.add(value);
                params.add(value);
            }


            if (status != null &&
                !status.trim().isEmpty()) {

                sql.append("AND status = ? ");

                params.add(status);
            }


            if (priority != null &&
                !priority.trim().isEmpty()) {

                sql.append("AND priority = ? ");

                params.add(priority);
            }


            if (category != null &&
                !category.trim().isEmpty()) {

                sql.append("AND category = ? ");

                params.add(category);
            }


            sql.append(
                "ORDER BY created_at DESC"
            );


            PreparedStatement ps =
                    con.prepareStatement(sql.toString());


            for (int i = 0;
                 i < params.size();
                 i++) {

                ps.setObject(
                    i + 1,
                    params.get(i)
                );
            }


            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {

                Ticket ticket = new Ticket();

                ticket.setTicketId(
                    rs.getInt("ticket_id"));

                ticket.setTitle(
                    rs.getString("title"));

                ticket.setDescription(
                    rs.getString("description"));

                ticket.setCategory(
                    rs.getString("category"));

                ticket.setPriority(
                    rs.getString("priority"));

                ticket.setStatus(
                    rs.getString("status"));

                ticket.setCreatedBy(
                    rs.getInt("created_by"));

                ticket.setAssignedTo(
                    rs.getInt("assigned_to"));

                ticket.setCreatedAt(
                    rs.getString("created_at"));

                ticket.setUpdatedAt(
                    rs.getString("updated_at"));

                tickets.add(ticket);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return tickets;
    }

}