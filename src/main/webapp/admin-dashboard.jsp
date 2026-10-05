<%@ page import="java.util.List" %>
<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.model.Ticket" %>
<%@ page import="com.smartdesk.service.UserService" %>
<%@ page import="com.smartdesk.service.TicketService" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    UserService userService = new UserService();

    TicketService ticketService = new TicketService();

    List<User> users = userService.getAllUsers();

    List<Ticket> tickets = ticketService.getAllTickets();


    int total = tickets.size();

    int open = 0;

    int assigned = 0;

    int progress = 0;

    int resolved = 0;

    int closed = 0;


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


    int activeTickets =
            open + assigned + progress;


    int resolutionRate = 0;

    if (total > 0) {
        resolutionRate =
                (resolved * 100) / total;
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Admin Dashboard</title>


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


        .admin-navbar {
            background: #111827;
            min-height: 72px;
            box-shadow:
                0 5px 25px rgba(15,23,42,.12);
        }


        .admin-brand-icon {

            width: 42px;
            height: 42px;

            border-radius: 12px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #7c3aed
                );

            color: white;

            font-size: 20px;
        }


        .admin-hero {

            background:
                linear-gradient(
                    135deg,
                    #111827,
                    #312e81,
                    #4f46e5
                );

            border-radius: 24px;

            color: white;

            padding: 45px;

            position: relative;

            overflow: hidden;
        }


        .admin-hero::before {

            content: "";

            position: absolute;

            width: 280px;
            height: 280px;

            border-radius: 50%;

            background:
                rgba(255,255,255,.06);

            right: -90px;
            top: -110px;
        }


        .admin-hero::after {

            content: "";

            position: absolute;

            width: 150px;
            height: 150px;

            border-radius: 50%;

            background:
                rgba(255,255,255,.04);

            right: 120px;
            bottom: -80px;
        }


        .admin-card {

            background: white;

            border: 1px solid #e5e7eb;

            border-radius: 20px;

            padding: 24px;

            height: 100%;

            box-shadow:
                0 8px 25px rgba(15,23,42,.05);

            transition: .25s ease;
        }


        .admin-card:hover {

            transform:
                translateY(-4px);

            box-shadow:
                0 15px 35px rgba(15,23,42,.10);
        }


        .admin-icon {

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


        .admin-number {

            font-size: 30px;

            font-weight: 800;

            color: #111827;
        }


        .section-card {

            background: white;

            border: 1px solid #e5e7eb;

            border-radius: 20px;

            padding: 28px;

            box-shadow:
                0 8px 25px rgba(15,23,42,.04);
        }


        .progress {

            height: 16px;

            border-radius: 20px;

            background: #e5e7eb;
        }


        .progress-bar {

            border-radius: 20px;
        }


        .action-btn {

            border-radius: 13px;

            padding: 12px 16px;

            font-weight: 600;

            transition: .2s ease;
        }


        .action-btn:hover {

            transform:
                translateY(-2px);
        }


        .admin-footer {

            text-align: center;

            color: #94a3b8;

            font-size: 12px;

            padding: 35px 0 15px;
        }

    </style>

</head>


<body>


<!-- NAVBAR -->

<nav class="navbar navbar-dark admin-navbar">

    <div class="container-fluid px-4">


        <a
            class="navbar-brand d-flex align-items-center gap-2"
            href="<%= request.getContextPath() %>/admin-dashboard.jsp">

            <div class="admin-brand-icon">

                <i class="bi bi-shield-check"></i>

            </div>

            <span class="fw-bold">
                SmartDesk Admin
            </span>

        </a>


        <div class="d-flex align-items-center gap-3">

            <span class="text-white d-none d-md-inline">

                <i class="bi bi-person-circle me-1"></i>

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

<div class="container-fluid px-3 px-md-4 py-4">


    <!-- HERO -->

    <div class="admin-hero mb-4">

        <span class="badge bg-light text-dark px-3 py-2">

            ADMIN CONTROL CENTER

        </span>


        <h1 class="fw-bold mt-3 mb-2">

            Service Operations at a Glance

        </h1>


        <p class="text-white-50 mb-0">

            Monitor incidents, workload,
            users and resolution progress.

        </p>

    </div>


    <!-- STAT CARDS -->

    <div class="row g-3 mb-4">


        <!-- TOTAL -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-ticket-detailed"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= total %>

                </div>


                <div class="text-muted small">

                    Total Tickets

                </div>

            </div>

        </div>


        <!-- OPEN -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-inbox"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= open %>

                </div>


                <div class="text-muted small">

                    Open Tickets

                </div>

            </div>

        </div>


        <!-- ASSIGNED -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-person-check"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= assigned %>

                </div>


                <div class="text-muted small">

                    Assigned

                </div>

            </div>

        </div>


        <!-- PROGRESS -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-arrow-repeat"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= progress %>

                </div>


                <div class="text-muted small">

                    In Progress

                </div>

            </div>

        </div>


        <!-- RESOLVED -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-check2-circle"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= resolved %>

                </div>


                <div class="text-muted small">

                    Resolved

                </div>

            </div>

        </div>


        <!-- CLOSED -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-lock"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= closed %>

                </div>


                <div class="text-muted small">

                    Closed

                </div>

            </div>

        </div>


        <!-- USERS -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-people"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= users.size() %>

                </div>


                <div class="text-muted small">

                    Registered Users

                </div>

            </div>

        </div>


        <!-- RESOLUTION -->

        <div class="col-6 col-md-4 col-xl-3">

            <div class="admin-card">

                <div class="admin-icon">

                    <i class="bi bi-graph-up-arrow"></i>

                </div>


                <div class="admin-number mt-3">

                    <%= resolutionRate %>%

                </div>


                <div class="text-muted small">

                    Resolution Rate

                </div>

            </div>

        </div>

    </div>


    <!-- ANALYTICS + ACTIONS -->

    <div class="row g-4">


        <!-- LIFECYCLE -->

        <div class="col-lg-8">

            <div class="section-card">

                <h5 class="fw-bold mb-1">

                    Incident Lifecycle

                </h5>


                <p class="text-muted small mb-4">

                    Distribution of tickets across
                    the service workflow.

                </p>


                <!-- OPEN -->

                <div class="d-flex justify-content-between mb-2">

                    <small class="fw-semibold">
                        Open
                    </small>

                    <small>
                        <%= open %>
                    </small>

                </div>


                <div class="progress mb-4">

                    <div
                        class="progress-bar bg-danger"
                        style="width:<%= total == 0 ? 0 : (open * 100 / total) %>%">
                    </div>

                </div>


                <!-- ASSIGNED -->

                <div class="d-flex justify-content-between mb-2">

                    <small class="fw-semibold">
                        Assigned
                    </small>

                    <small>
                        <%= assigned %>
                    </small>

                </div>


                <div class="progress mb-4">

                    <div
                        class="progress-bar bg-primary"
                        style="width:<%= total == 0 ? 0 : (assigned * 100 / total) %>%">
                    </div>

                </div>


                <!-- IN PROGRESS -->

                <div class="d-flex justify-content-between mb-2">

                    <small class="fw-semibold">
                        In Progress
                    </small>

                    <small>
                        <%= progress %>
                    </small>

                </div>


                <div class="progress mb-4">

                    <div
                        class="progress-bar bg-warning"
                        style="width:<%= total == 0 ? 0 : (progress * 100 / total) %>%">
                    </div>

                </div>


                <!-- RESOLVED -->

                <div class="d-flex justify-content-between mb-2">

                    <small class="fw-semibold">
                        Resolved
                    </small>

                    <small>
                        <%= resolved %>
                    </small>

                </div>


                <div class="progress mb-4">

                    <div
                        class="progress-bar bg-success"
                        style="width:<%= total == 0 ? 0 : (resolved * 100 / total) %>%">
                    </div>

                </div>


                <!-- CLOSED -->

                <div class="d-flex justify-content-between mb-2">

                    <small class="fw-semibold">
                        Closed
                    </small>

                    <small>
                        <%= closed %>
                    </small>

                </div>


                <div class="progress">

                    <div
                        class="progress-bar bg-dark"
                        style="width:<%= total == 0 ? 0 : (closed * 100 / total) %>%">
                    </div>

                </div>

            </div>

        </div>


        <!-- ADMIN ACTIONS -->

        <div class="col-lg-4">

            <div class="section-card h-100">

                <h5 class="fw-bold mb-1">

                    Admin Actions

                </h5>


                <p class="text-muted small mb-4">

                    Manage the SmartDesk service
                    environment.

                </p>


                <a
                    class="btn btn-dark action-btn w-100 mb-3"
                    href="<%= request.getContextPath() %>/AdminTicketsServlet">

                    <i class="bi bi-kanban me-2"></i>

                    Manage Tickets

                </a>


                <a
                    class="btn btn-outline-dark action-btn w-100 mb-3"
                    href="<%= request.getContextPath() %>/reports.jsp">

                    <i class="bi bi-bar-chart me-2"></i>

                    View Reports

                </a>


                <a
                    class="btn btn-outline-primary action-btn w-100 mb-3"
                    href="<%= request.getContextPath() %>/users.jsp">

                    <i class="bi bi-people me-2"></i>

                    View Users

                </a>


                <div class="alert alert-light border mt-4">

                    <div class="d-flex">

                        <i class="bi bi-shield-check fs-4 me-3"></i>

                        <div>

                            <strong>
                                Administrator Access
                            </strong>

                            <div class="small text-muted mt-1">

                                You have full access to
                                SmartDesk service operations.

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- FOOTER -->

    <div class="admin-footer">

        SmartDesk IT Service Desk &copy; 2026

    </div>

</div>


</body>

</html>