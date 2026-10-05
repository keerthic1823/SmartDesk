<%@ page import="java.util.List" %>
<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.model.Ticket" %>
<%@ page import="com.smartdesk.service.TicketService" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    boolean admin = "ADMIN".equalsIgnoreCase(user.getRole());

    TicketService ticketService = new TicketService();

    int total = 0;
    int open = 0;
    int assigned = 0;
    int progress = 0;
    int resolved = 0;
    int closed = 0;

    if (admin) {

        List<Ticket> tickets = ticketService.getAllTickets();

        total = tickets.size();

        for (Ticket ticket : tickets) {

            String status = ticket.getStatus();

            if ("OPEN".equalsIgnoreCase(status)) {
                open++;
            }
            else if ("ASSIGNED".equalsIgnoreCase(status)) {
                assigned++;
            }
            else if ("IN_PROGRESS".equalsIgnoreCase(status)) {
                progress++;
            }
            else if ("RESOLVED".equalsIgnoreCase(status)) {
                resolved++;
            }
            else if ("CLOSED".equalsIgnoreCase(status)) {
                closed++;
            }
        }

    } else {

        total = ticketService.getTotalTickets(user.getUserId());

        open = ticketService.getOpenTickets(user.getUserId());

        progress = ticketService.getInProgressTickets(user.getUserId());

        resolved = ticketService.getResolvedTickets(user.getUserId());
    }

    int activeTickets = open + assigned + progress;

    int resolutionRate = 0;

    if (total > 0) {
        resolutionRate = (resolved * 100) / total;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Reports</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <!-- SmartDesk CSS -->
    <link
        href="<%= request.getContextPath() %>/css/style.css"
        rel="stylesheet">

    <style>

        body {
            background: #f8fafc;
        }

        .report-navbar {
            background: #111827;
            min-height: 70px;
        }

        .report-hero {
            background:
                linear-gradient(
                    135deg,
                    #111827,
                    #312e81,
                    #4f46e5
                );

            border-radius: 24px;
            color: white;
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .report-hero::after {
            content: "";
            position: absolute;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: rgba(255,255,255,.08);
            right: -70px;
            top: -80px;
        }

        .report-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 24px;
            height: 100%;
            box-shadow: 0 8px 25px rgba(15,23,42,.05);
            transition: .25s ease;
        }

        .report-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 35px rgba(15,23,42,.10);
        }

        .report-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #eef2ff;
            color: #4f46e5;
            font-size: 21px;
        }

        .report-number {
            font-size: 30px;
            font-weight: 800;
            color: #111827;
        }

        .report-label {
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
        }

        .section-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 28px;
            box-shadow: 0 8px 25px rgba(15,23,42,.04);
        }

        .progress {
            height: 14px;
            border-radius: 20px;
            background: #e5e7eb;
        }

        .progress-bar {
            border-radius: 20px;
        }

        .metric-row {
            margin-bottom: 22px;
        }

        .metric-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 600;
        }

        .back-btn {
            border-radius: 12px;
            padding: 10px 20px;
        }

        .report-footer {
            text-align: center;
            color: #94a3b8;
            font-size: 12px;
            padding: 35px 0 15px;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark report-navbar">

    <div class="container-fluid px-4">

        <a
            class="navbar-brand fw-bold"
            href="<%= request.getContextPath() %>/<%= admin ? "admin-dashboard.jsp" : "dashboard.jsp" %>">

            <i class="bi bi-bar-chart-fill me-2"></i>

            SmartDesk Reports

        </a>

        <div class="d-flex align-items-center gap-3">

            <span class="text-white-50 d-none d-md-inline">
                <%= user.getName() %>
            </span>

            <a
                href="<%= request.getContextPath() %>/LogoutServlet"
                class="btn btn-sm btn-outline-light">

                Logout

            </a>

        </div>

    </div>

</nav>


<!-- MAIN -->

<div class="container py-5">

    <!-- HERO -->

    <div class="report-hero mb-4">

        <span class="badge bg-light text-dark px-3 py-2">
            <%= admin ? "ADMIN ANALYTICS" : "MY ANALYTICS" %>
        </span>

        <h1 class="fw-bold mt-3 mb-2">

            <%= admin
                ? "Service Operations Report"
                : "My Ticket Report" %>

        </h1>

        <p class="mb-0 text-white-50">

            <%= admin
                ? "Monitor the overall support workload and ticket resolution progress."
                : "Track your support requests and resolution progress." %>

        </p>

    </div>


    <!-- STAT CARDS -->

    <div class="row g-3 mb-4">

        <!-- TOTAL -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-ticket-detailed"></i>
                </div>

                <div class="report-number mt-3">
                    <%= total %>
                </div>

                <div class="report-label">
                    Total Tickets
                </div>

            </div>

        </div>


        <!-- OPEN -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-inbox"></i>
                </div>

                <div class="report-number mt-3">
                    <%= open %>
                </div>

                <div class="report-label">
                    Open Tickets
                </div>

            </div>

        </div>


        <!-- ASSIGNED -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-person-check"></i>
                </div>

                <div class="report-number mt-3">
                    <%= assigned %>
                </div>

                <div class="report-label">
                    Assigned
                </div>

            </div>

        </div>


        <!-- IN PROGRESS -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-arrow-repeat"></i>
                </div>

                <div class="report-number mt-3">
                    <%= progress %>
                </div>

                <div class="report-label">
                    In Progress
                </div>

            </div>

        </div>


        <!-- RESOLVED -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-check2-circle"></i>
                </div>

                <div class="report-number mt-3">
                    <%= resolved %>
                </div>

                <div class="report-label">
                    Resolved
                </div>

            </div>

        </div>


        <!-- CLOSED -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-lock"></i>
                </div>

                <div class="report-number mt-3">
                    <%= closed %>
                </div>

                <div class="report-label">
                    Closed
                </div>

            </div>

        </div>


        <!-- ACTIVE -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-activity"></i>
                </div>

                <div class="report-number mt-3">
                    <%= activeTickets %>
                </div>

                <div class="report-label">
                    Active Tickets
                </div>

            </div>

        </div>


        <!-- RESOLUTION -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="report-card">

                <div class="report-icon">
                    <i class="bi bi-graph-up-arrow"></i>
                </div>

                <div class="report-number mt-3">
                    <%= resolutionRate %>%
                </div>

                <div class="report-label">
                    Resolution Rate
                </div>

            </div>

        </div>

    </div>


    <!-- ANALYTICS -->

    <div class="row g-4">

        <!-- LIFECYCLE -->

        <div class="col-lg-7">

            <div class="section-card">

                <h5 class="fw-bold mb-1">
                    Ticket Lifecycle
                </h5>

                <p class="text-muted small mb-4">
                    Current distribution of ticket statuses.
                </p>


                <!-- OPEN -->

                <div class="metric-row">

                    <div class="metric-header">

                        <span>
                            Open
                        </span>

                        <span>
                            <%= open %>
                        </span>

                    </div>

                    <div class="progress">

                        <div
                            class="progress-bar bg-danger"
                            style="width:<%= total == 0 ? 0 : (open * 100 / total) %>%">
                        </div>

                    </div>

                </div>


                <!-- ASSIGNED -->

                <div class="metric-row">

                    <div class="metric-header">

                        <span>
                            Assigned
                        </span>

                        <span>
                            <%= assigned %>
                        </span>

                    </div>

                    <div class="progress">

                        <div
                            class="progress-bar bg-primary"
                            style="width:<%= total == 0 ? 0 : (assigned * 100 / total) %>%">
                        </div>

                    </div>

                </div>


                <!-- IN PROGRESS -->

                <div class="metric-row">

                    <div class="metric-header">

                        <span>
                            In Progress
                        </span>

                        <span>
                            <%= progress %>
                        </span>

                    </div>

                    <div class="progress">

                        <div
                            class="progress-bar bg-warning"
                            style="width:<%= total == 0 ? 0 : (progress * 100 / total) %>%">
                        </div>

                    </div>

                </div>


                <!-- RESOLVED -->

                <div class="metric-row">

                    <div class="metric-header">

                        <span>
                            Resolved
                        </span>

                        <span>
                            <%= resolved %>
                        </span>

                    </div>

                    <div class="progress">

                        <div
                            class="progress-bar bg-success"
                            style="width:<%= total == 0 ? 0 : (resolved * 100 / total) %>%">
                        </div>

                    </div>

                </div>


                <!-- CLOSED -->

                <div class="metric-row mb-0">

                    <div class="metric-header">

                        <span>
                            Closed
                        </span>

                        <span>
                            <%= closed %>
                        </span>

                    </div>

                    <div class="progress">

                        <div
                            class="progress-bar bg-dark"
                            style="width:<%= total == 0 ? 0 : (closed * 100 / total) %>%">
                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- SUMMARY -->

        <div class="col-lg-5">

            <div class="section-card h-100">

                <h5 class="fw-bold mb-1">
                    Performance Summary
                </h5>

                <p class="text-muted small mb-4">
                    Quick overview of current service performance.
                </p>


                <div class="d-flex justify-content-between mb-3">

                    <span class="text-muted">
                        Total workload
                    </span>

                    <strong>
                        <%= total %>
                    </strong>

                </div>


                <div class="d-flex justify-content-between mb-3">

                    <span class="text-muted">
                        Active workload
                    </span>

                    <strong>
                        <%= activeTickets %>
                    </strong>

                </div>


                <div class="d-flex justify-content-between mb-3">

                    <span class="text-muted">
                        Resolved
                    </span>

                    <strong class="text-success">
                        <%= resolved %>
                    </strong>

                </div>


                <div class="d-flex justify-content-between mb-4">

                    <span class="text-muted">
                        Resolution rate
                    </span>

                    <strong>
                        <%= resolutionRate %>%
                    </strong>

                </div>


                <div class="alert alert-light border">

                    <i class="bi bi-info-circle me-2"></i>

                    <span class="small">

                        <%= admin
                            ? "This report summarizes all tickets in SmartDesk."
                            : "This report summarizes tickets created by you." %>

                    </span>

                </div>


                <a
                    class="btn btn-dark back-btn w-100"
                    href="<%= request.getContextPath() %>/<%= admin ? "admin-dashboard.jsp" : "dashboard.jsp" %>">

                    <i class="bi bi-arrow-left me-2"></i>

                    Back to Dashboard

                </a>

            </div>

        </div>

    </div>


    <div class="report-footer">

        SmartDesk IT Service Desk &copy; 2026

    </div>

</div>

</body>

</html>