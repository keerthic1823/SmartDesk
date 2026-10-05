<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.model.Ticket" %>
<%@ page import="com.smartdesk.service.UserService" %>
<%@ page import="com.smartdesk.service.TicketService" %>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    /* =====================================================
       SESSION / ADMIN SECURITY
    ====================================================== */

    User currentUser =
            (User) session.getAttribute("user");

    if (currentUser == null) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }


    if (!"ADMIN".equalsIgnoreCase(currentUser.getRole())) {

        response.sendRedirect(
                request.getContextPath() + "/dashboard.jsp"
        );

        return;
    }


    /* =====================================================
       LOAD DATA
    ====================================================== */

    TicketService ticketService =
            new TicketService();

    UserService userService =
            new UserService();


    List<Ticket> tickets =
            ticketService.getAllTickets();


    List<User> allUsers =
            userService.getAllUsers();


    if (tickets == null) {

        tickets =
                new ArrayList<Ticket>();

    }


    if (allUsers == null) {

        allUsers =
                new ArrayList<User>();

    }


    /* =====================================================
       EMPLOYEES
    ====================================================== */

    List<User> employees =
            new ArrayList<User>();


    for (User u : allUsers) {

        if ("EMPLOYEE".equalsIgnoreCase(u.getRole())) {

            employees.add(u);

        }

    }


    /* =====================================================
       COUNTERS
    ====================================================== */

    int totalTickets =
            tickets.size();

    int openTickets = 0;

    int assignedTickets = 0;

    int progressTickets = 0;

    int resolvedTickets = 0;

    int closedTickets = 0;


    for (Ticket t : tickets) {

        String status =
                t.getStatus();


        if ("OPEN".equalsIgnoreCase(status)) {

            openTickets++;

        }

        else if ("ASSIGNED".equalsIgnoreCase(status)) {

            assignedTickets++;

        }

        else if ("IN_PROGRESS".equalsIgnoreCase(status)) {

            progressTickets++;

        }

        else if ("RESOLVED".equalsIgnoreCase(status)) {

            resolvedTickets++;

        }

        else if ("CLOSED".equalsIgnoreCase(status)) {

            closedTickets++;

        }

    }


    String firstLetter = "A";


    if (currentUser.getName() != null &&
        !currentUser.getName().trim().isEmpty()) {

        firstLetter =
                currentUser.getName()
                        .substring(0, 1)
                        .toUpperCase();

    }

%>


<!DOCTYPE html>

<html lang="en">


<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Manage Tickets</title>


    <!-- =================================================
         BOOTSTRAP
    ================================================== -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- =================================================
         BOOTSTRAP ICONS
    ================================================== -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <!-- =================================================
         GOOGLE FONT
    ================================================== -->

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <!-- =================================================
         GLOBAL CSS
    ================================================== -->

    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/css/style.css">


    <style>

        /* =================================================
           PAGE
        ================================================== */

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            font-family: 'Inter', sans-serif;

            min-height: 100vh;

            color: #111827;

            background:

                radial-gradient(
                    circle at 5% 5%,
                    rgba(99,102,241,.12),
                    transparent 25%
                ),

                radial-gradient(
                    circle at 95% 15%,
                    rgba(124,58,237,.10),
                    transparent 28%
                ),

                linear-gradient(
                    135deg,
                    #f8fafc 0%,
                    #eef2ff 50%,
                    #f8fafc 100%
                );

        }


        /* =================================================
           STICKY ADMIN NAVBAR
        ================================================== */

        .admin-navbar {

            position: sticky !important;

            top: 0;

            z-index: 2000;

            min-height: 72px;

            background:
                rgba(15,23,42,.97) !important;

            backdrop-filter:
                blur(18px);

            -webkit-backdrop-filter:
                blur(18px);

            border-bottom:
                1px solid
                rgba(255,255,255,.08);

            box-shadow:
                0 8px 30px
                rgba(15,23,42,.20);

        }


        /* =================================================
           BRAND
        ================================================== */

        .admin-brand-logo {

            width: 43px;

            height: 43px;

            border-radius: 13px;

            display: flex;

            align-items: center;

            justify-content: center;

            color: white;

            font-size: 21px;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #7c3aed
                );

            box-shadow:
                0 8px 25px
                rgba(99,102,241,.35);

        }


        .admin-brand {

            color: white;

            font-size: 21px;

            font-weight: 800;

            letter-spacing: -.5px;

        }


        /* =================================================
           NAV LINKS
        ================================================== */

        .admin-nav-link {

            color: #cbd5e1 !important;

            font-size: 14px;

            font-weight: 500;

            padding:
                10px 15px !important;

            border-radius: 11px;

            transition: .25s ease;

        }


        .admin-nav-link:hover {

            color: white !important;

            background:
                rgba(255,255,255,.08);

        }


        .admin-nav-link.active {

            color: white !important;

            background:
                rgba(99,102,241,.23);

        }


        /* =================================================
           ADMIN AVATAR
        ================================================== */

        .admin-avatar {

            width: 39px;

            height: 39px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            color: white;

            font-weight: 800;

            background:
                linear-gradient(
                    135deg,
                    #8b5cf6,
                    #4f46e5
                );

        }


        .admin-profile {

            border: none;

            background: transparent;

            color: white;

            display: flex;

            align-items: center;

            gap: 9px;

            padding: 5px 8px;

            border-radius: 12px;

        }


        .admin-profile:hover {

            background:
                rgba(255,255,255,.08);

        }


        /* =================================================
           MAIN
        ================================================== */

        .admin-container {

            max-width: 1500px;

            margin: auto;

            padding:
                35px 28px 60px;

        }


        /* =================================================
           PAGE HERO
        ================================================== */

        .admin-hero {

            position: relative;

            overflow: hidden;

            padding: 35px 38px;

            border-radius: 24px;

            color: white;

            background:

                radial-gradient(
                    circle at 90% 15%,
                    rgba(139,92,246,.35),
                    transparent 25%
                ),

                linear-gradient(
                    135deg,
                    #111827,
                    #312e81 55%,
                    #4c1d95
                );

            box-shadow:
                0 20px 50px
                rgba(49,46,129,.18);

        }


        .admin-hero::after {

            content: "";

            position: absolute;

            width: 250px;

            height: 250px;

            border-radius: 50%;

            border:
                1px solid
                rgba(255,255,255,.10);

            right: -80px;

            top: -130px;

        }


        .hero-content {

            position: relative;

            z-index: 2;

        }


        .hero-label {

            color: #a5b4fc;

            font-size: 12px;

            font-weight: 800;

            letter-spacing: 1px;

            text-transform: uppercase;

        }


        .hero-title {

            font-size: 34px;

            font-weight: 800;

            margin:
                6px 0 5px;

        }


        .hero-description {

            color: #cbd5e1;

            font-size: 13px;

            margin: 0;

        }


        /* =================================================
           STAT CARDS
        ================================================== */

        .stat-card {

            background:
                rgba(255,255,255,.95);

            border:
                1px solid
                #e2e8f0;

            border-radius: 18px;

            padding: 20px;

            box-shadow:
                0 8px 25px
                rgba(15,23,42,.05);

            transition: .25s ease;

        }


        .stat-card:hover {

            transform:
                translateY(-4px);

            box-shadow:
                0 15px 35px
                rgba(15,23,42,.09);

        }


        .stat-icon {

            width: 43px;

            height: 43px;

            border-radius: 12px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                #eef2ff;

            color:
                #4f46e5;

        }


        .stat-number {

            font-size: 27px;

            font-weight: 800;

            margin-top: 12px;

        }


        .stat-label {

            color: #64748b;

            font-size: 12px;

            font-weight: 600;

        }


        /* =================================================
           FILTER CARD
        ================================================== */

        .filter-card {

            margin-top: 25px;

            padding: 20px;

            border-radius: 18px;

            background:
                rgba(255,255,255,.94);

            border:
                1px solid
                #e2e8f0;

            box-shadow:
                0 8px 25px
                rgba(15,23,42,.04);

        }


        .filter-input,
        .filter-select {

            height: 45px;

            border:
                1px solid
                #dbe3ef;

            border-radius: 11px;

            background: #f8fafc;

            padding:
                0 13px;

            color: #334155;

            outline: none;

            width: 100%;

        }


        .filter-input:focus,
        .filter-select:focus {

            background: white;

            border-color:
                #6366f1;

            box-shadow:
                0 0 0 3px
                rgba(99,102,241,.10);

        }


        .filter-button {

            height: 45px;

            width: 100%;

            border: none;

            border-radius: 11px;

            color: white;

            font-weight: 700;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

        }


        /* =================================================
           TICKET CARD
        ================================================== */

        .tickets-card {

            margin-top: 25px;

            background:
                rgba(255,255,255,.97);

            border:
                1px solid
                #e2e8f0;

            border-radius: 22px;

            overflow: hidden;

            box-shadow:
                0 12px 35px
                rgba(15,23,42,.06);

        }


        .tickets-header {

            padding:
                22px 24px;

            border-bottom:
                1px solid
                #e2e8f0;

            display: flex;

            justify-content: space-between;

            align-items: center;

        }


        .tickets-title {

            font-size: 17px;

            font-weight: 800;

        }


        .tickets-subtitle {

            color: #94a3b8;

            font-size: 11px;

            margin-top: 3px;

        }


        /* =================================================
           TABLE
        ================================================== */

        .admin-table {

            width: 100%;

            margin: 0;

        }


        .admin-table thead th {

            background:
                #f8fafc;

            color:
                #64748b;

            text-transform:
                uppercase;

            letter-spacing:
                .5px;

            font-size:
                10px;

            font-weight:
                800;

            padding:
                15px 14px;

            border-bottom:
                1px solid
                #e2e8f0;

            white-space:
                nowrap;

        }


        .admin-table tbody td {

            padding:
                14px;

            vertical-align:
                middle;

            border-bottom:
                1px solid
                #f1f5f9;

            font-size:
                12px;

        }


        .admin-table tbody tr {

            transition:
                .2s ease;

        }


        .admin-table tbody tr:hover {

            background:
                #f8faff;

        }


        /* =================================================
           INCIDENT
        ================================================== */

        .incident-id {

            color:
                #4f46e5;

            font-weight:
                800;

        }


        .incident-title {

            font-weight:
                700;

            color:
                #111827;

            font-size:
                13px;

        }


        .incident-meta {

            color:
                #94a3b8;

            margin-top:
                4px;

            font-size:
                10px;

        }


        /* =================================================
           BADGES
        ================================================== */

        .badge-custom {

            display:
                inline-flex;

            align-items:
                center;

            border-radius:
                20px;

            padding:
                6px 9px;

            font-size:
                9px;

            font-weight:
                800;

        }


        .priority-high {

            background:
                #fee2e2;

            color:
                #b91c1c;

        }


        .priority-medium {

            background:
                #fef3c7;

            color:
                #92400e;

        }


        .priority-low {

            background:
                #dcfce7;

            color:
                #166534;

        }


        .priority-critical {

            background:
                #ede9fe;

            color:
                #6d28d9;

        }


        .status-open {

            background:
                #dbeafe;

            color:
                #1d4ed8;

        }


        .status-assigned {

            background:
                #e0e7ff;

            color:
                #4338ca;

        }


        .status-progress {

            background:
                #fef3c7;

            color:
                #92400e;

        }


        .status-resolved {

            background:
                #dcfce7;

            color:
                #166534;

        }


        .status-closed {

            background:
                #e2e8f0;

            color:
                #334155;

        }


        /* =================================================
           SELECTS IN TABLE
        ================================================== */

        .table-select {

            min-width:
                150px;

            height:
                38px;

            border:
                1px solid
                #dbe3ef;

            border-radius:
                9px;

            background:
                white;

            padding:
                0 10px;

            font-size:
                12px;

            color:
                #334155;

        }


        .table-select:focus {

            outline:
                none;

            border-color:
                #6366f1;

            box-shadow:
                0 0 0 3px
                rgba(99,102,241,.10);

        }


        /* =================================================
           ACTION BUTTON
        ================================================== */

        .assign-button {

            width:
                38px;

            height:
                38px;

            border-radius:
                9px;

            border:
                1px solid
                #86efac;

            color:
                #15803d;

            background:
                #f0fdf4;

        }


        .assign-button:hover {

            color:
                white;

            background:
                #16a34a;

        }


        .update-button {

            width:
                38px;

            height:
                38px;

            border-radius:
                9px;

            border:
                1px solid
                #a5b4fc;

            color:
                #4f46e5;

            background:
                #eef2ff;

        }


        .update-button:hover {

            color:
                white;

            background:
                #4f46e5;

        }


        /* =================================================
           FOOTER
        ================================================== */

        .admin-footer {

            text-align:
                center;

            color:
                #94a3b8;

            font-size:
                11px;

            padding-top:
                40px;

        }


        /* =================================================
           MOBILE
        ================================================== */

        @media (max-width: 991px) {

            .admin-container {

                padding:
                    25px 15px 45px;

            }

            .admin-hero {

                padding:
                    30px 25px;

            }

        }


        @media (max-width: 767px) {

            .hero-title {

                font-size:
                    28px;

            }

            .tickets-header {

                flex-direction:
                    column;

                align-items:
                    flex-start;

                gap:
                    8px;

            }

        }

    </style>

</head>


<body>


<!-- =========================================================
     STICKY ADMIN NAVBAR
========================================================== -->

<nav class="navbar navbar-expand-lg admin-navbar">

    <div class="container-fluid px-4">


        <!-- BRAND -->

        <a
            class="navbar-brand d-flex align-items-center gap-2"
            href="<%= request.getContextPath() %>/admin-dashboard.jsp">

            <div class="admin-brand-logo">

                <i class="bi bi-shield-check"></i>

            </div>

            <span class="admin-brand">

                SmartDesk Admin

            </span>

        </a>


        <!-- MOBILE BUTTON -->

        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#adminNavbar">

            <span class="navbar-toggler-icon"></span>

        </button>


        <!-- NAVIGATION -->

        <div
            class="collapse navbar-collapse"
            id="adminNavbar">


            <ul class="navbar-nav ms-4 me-auto">


                <li class="nav-item">

                    <a
                        class="nav-link admin-nav-link"
                        href="<%= request.getContextPath() %>/admin-dashboard.jsp">

                        <i class="bi bi-grid me-1"></i>

                        Dashboard

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link admin-nav-link active"
                        href="<%= request.getContextPath() %>/AdminTicketsServlet">

                        <i class="bi bi-kanban me-1"></i>

                        Manage Tickets

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link admin-nav-link"
                        href="<%= request.getContextPath() %>/reports.jsp">

                        <i class="bi bi-bar-chart me-1"></i>

                        Reports

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link admin-nav-link"
                        href="<%= request.getContextPath() %>/users.jsp">

                        <i class="bi bi-people me-1"></i>

                        Users

                    </a>

                </li>

            </ul>


            <!-- PROFILE -->

            <div class="dropdown">

                <button
                    class="admin-profile dropdown-toggle"
                    type="button"
                    data-bs-toggle="dropdown">

                    <div class="admin-avatar">

                        <%= firstLetter %>

                    </div>


                    <span class="d-none d-md-inline">

                        <%= currentUser.getName() %>

                    </span>

                </button>


                <ul
                    class="dropdown-menu dropdown-menu-end shadow border-0">


                    <li>

                        <h6 class="dropdown-header">

                            Administrator

                        </h6>

                    </li>


                    <li>

                        <span class="dropdown-item-text small text-muted">

                            <%= currentUser.getEmail() %>

                        </span>

                    </li>


                    <li>

                        <hr class="dropdown-divider">

                    </li>


                    <li>

                        <a
                            class="dropdown-item"
                            href="<%= request.getContextPath() %>/admin-dashboard.jsp">

                            <i class="bi bi-grid me-2"></i>

                            Admin Dashboard

                        </a>

                    </li>


                    <li>

                        <a
                            class="dropdown-item text-danger"
                            href="<%= request.getContextPath() %>/LogoutServlet">

                            <i class="bi bi-box-arrow-right me-2"></i>

                            Logout

                        </a>

                    </li>

                </ul>

            </div>

        </div>

    </div>

</nav>


<!-- =========================================================
     MAIN
========================================================== -->

<main class="admin-container">


    <!-- =====================================================
         HERO
    ====================================================== -->

    <section class="admin-hero">


        <div class="hero-content">


            <div class="hero-label">

                Administrator Operations

            </div>


            <h1 class="hero-title">

                Ticket Management

            </h1>


            <p class="hero-description">

                Assign incidents, update ticket status and
                manage the complete SmartDesk support workflow.

            </p>

        </div>

    </section>


    <!-- =====================================================
         STATISTICS
    ====================================================== -->

    <div class="row g-3 mt-1">


        <!-- TOTAL -->

        <div class="col-6 col-md-4 col-xl">

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-ticket-detailed"></i>

                </div>


                <div class="stat-number">

                    <%= totalTickets %>

                </div>


                <div class="stat-label">

                    Total Tickets

                </div>

            </div>

        </div>


        <!-- OPEN -->

        <div class="col-6 col-md-4 col-xl">

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-inbox"></i>

                </div>


                <div class="stat-number">

                    <%= openTickets %>

                </div>


                <div class="stat-label">

                    Open

                </div>

            </div>

        </div>


        <!-- ASSIGNED -->

        <div class="col-6 col-md-4 col-xl">

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-person-check"></i>

                </div>


                <div class="stat-number">

                    <%= assignedTickets %>

                </div>


                <div class="stat-label">

                    Assigned

                </div>

            </div>

        </div>


        <!-- PROGRESS -->

        <div class="col-6 col-md-4 col-xl">

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-arrow-repeat"></i>

                </div>


                <div class="stat-number">

                    <%= progressTickets %>

                </div>


                <div class="stat-label">

                    In Progress

                </div>

            </div>

        </div>


        <!-- RESOLVED -->

        <div class="col-6 col-md-4 col-xl">

            <div class="stat-card">

                <div class="stat-icon">

                    <i class="bi bi-check2-circle"></i>

                </div>


                <div class="stat-number">

                    <%= resolvedTickets %>

                </div>


                <div class="stat-label">

                    Resolved

                </div>

            </div>

        </div>


    </div>


    <!-- =====================================================
         FILTERS
    ====================================================== -->

    <div class="filter-card">


        <div class="row g-3">


            <div class="col-lg-5">

                <input
                    type="text"
                    id="ticketSearch"
                    class="filter-input"
                    placeholder="Search tickets, categories or IDs...">

            </div>


            <div class="col-lg-2">

                <select
                    id="statusFilter"
                    class="filter-select">

                    <option value="ALL">
                        All Status
                    </option>

                    <option value="OPEN">
                        Open
                    </option>

                    <option value="ASSIGNED">
                        Assigned
                    </option>

                    <option value="IN_PROGRESS">
                        In Progress
                    </option>

                    <option value="RESOLVED">
                        Resolved
                    </option>

                    <option value="CLOSED">
                        Closed
                    </option>

                </select>

            </div>


            <div class="col-lg-2">

                <select
                    id="priorityFilter"
                    class="filter-select">

                    <option value="ALL">
                        All Priority
                    </option>

                    <option value="CRITICAL">
                        Critical
                    </option>

                    <option value="HIGH">
                        High
                    </option>

                    <option value="MEDIUM">
                        Medium
                    </option>

                    <option value="LOW">
                        Low
                    </option>

                </select>

            </div>


            <div class="col-lg-3">

                <button
                    type="button"
                    class="filter-button"
                    onclick="filterTickets()">

                    <i class="bi bi-search me-2"></i>

                    Filter Tickets

                </button>

            </div>

        </div>

    </div>


    <!-- =====================================================
         TICKET TABLE
    ====================================================== -->

    <div class="tickets-card">


        <div class="tickets-header">


            <div>

                <div class="tickets-title">

                    All Support Incidents

                </div>


                <div class="tickets-subtitle">

                    <%= totalTickets %>
                    ticket(s) currently registered

                </div>

            </div>


            <span class="badge bg-dark rounded-pill px-3 py-2">

                ADMIN VIEW

            </span>

        </div>


        <div class="table-responsive">


            <table
                class="table admin-table"
                id="adminTicketsTable">


                <thead>

                    <tr>

                        <th>
                            ID
                        </th>

                        <th>
                            Incident
                        </th>

                        <th>
                            Priority
                        </th>

                        <th>
                            Status
                        </th>

                        <th>
                            Assign Employee
                        </th>

                        <th>
                            Update Status
                        </th>

                    </tr>

                </thead>


                <tbody>


                <% for (Ticket ticket : tickets) { %>


                    <tr
                        data-search="
                            <%= ticket.getTicketId() %>
                            <%= ticket.getTitle() %>
                            <%= ticket.getCategory() %>
                            <%= ticket.getDescription() %>
                        "
                        data-status="<%= ticket.getStatus() %>"
                        data-priority="<%= ticket.getPriority() %>">


                        <!-- ID -->

                        <td>

                            <span class="incident-id">

                                #<%= ticket.getTicketId() %>

                            </span>

                        </td>


                        <!-- INCIDENT -->

                        <td>

                            <div class="incident-title">

                                <%= ticket.getTitle() %>

                            </div>


                            <div class="incident-meta">

                                <%= ticket.getCategory() %>

                                &nbsp; • &nbsp;

                                <%= ticket.getCreatedAt() %>

                            </div>

                        </td>


                        <!-- PRIORITY -->

                        <td>

                            <%

                                String priority =
                                        ticket.getPriority();

                                String priorityClass =
                                        "priority-low";


                                if ("HIGH".equalsIgnoreCase(priority)) {

                                    priorityClass =
                                            "priority-high";

                                }

                                else if ("MEDIUM".equalsIgnoreCase(priority)) {

                                    priorityClass =
                                            "priority-medium";

                                }

                                else if ("CRITICAL".equalsIgnoreCase(priority)) {

                                    priorityClass =
                                            "priority-critical";

                                }

                            %>


                            <span
                                class="badge-custom <%= priorityClass %>">

                                <i class="bi bi-flag-fill me-1"></i>

                                <%= priority %>

                            </span>

                        </td>


                        <!-- STATUS -->

                        <td>

                            <%

                                String status =
                                        ticket.getStatus();

                                String statusClass =
                                        "status-open";


                                if ("ASSIGNED".equalsIgnoreCase(status)) {

                                    statusClass =
                                            "status-assigned";

                                }

                                else if ("IN_PROGRESS".equalsIgnoreCase(status)) {

                                    statusClass =
                                            "status-progress";

                                }

                                else if ("RESOLVED".equalsIgnoreCase(status)) {

                                    statusClass =
                                            "status-resolved";

                                }

                                else if ("CLOSED".equalsIgnoreCase(status)) {

                                    statusClass =
                                            "status-closed";

                                }

                            %>


                            <span
                                class="badge-custom <%= statusClass %>">

                                <i
                                    class="bi bi-circle-fill"
                                    style="font-size:6px;">
                                </i>

                                <%= status %>

                            </span>

                        </td>


                        <!-- ASSIGN -->

                        <td>


                            <form
                                action="<%= request.getContextPath() %>/AssignTicketServlet"
                                method="post"
                                class="d-flex gap-2">


                                <input
                                    type="hidden"
                                    name="ticketId"
                                    value="<%= ticket.getTicketId() %>">


                                <select
                                    name="employeeId"
                                    class="table-select"
                                    required>


                                    <option value="">

                                        Select employee

                                    </option>


                                    <% for (User employee : employees) { %>


                                        <option
                                            value="<%= employee.getUserId() %>"
                                            <%= ticket.getAssignedTo() == employee.getUserId()
                                                ? "selected"
                                                : "" %>>


                                            <%= employee.getName() %>


                                        </option>


                                    <% } %>


                                </select>


                                <button
                                    type="submit"
                                    class="assign-button"
                                    title="Assign Ticket">

                                    <i class="bi bi-person-check"></i>

                                </button>


                            </form>


                        </td>


                        <!-- UPDATE STATUS -->

                        <td>


                            <form
                                action="<%= request.getContextPath() %>/UpdateTicketServlet"
                                method="post"
                                class="d-flex gap-2">


                                <input
                                    type="hidden"
                                    name="ticketId"
                                    value="<%= ticket.getTicketId() %>">


                                <select
                                    name="status"
                                    class="table-select">


                                    <option
                                        value="OPEN"
                                        <%= "OPEN".equalsIgnoreCase(status)
                                            ? "selected"
                                            : "" %>>

                                        OPEN

                                    </option>


                                    <option
                                        value="ASSIGNED"
                                        <%= "ASSIGNED".equalsIgnoreCase(status)
                                            ? "selected"
                                            : "" %>>

                                        ASSIGNED

                                    </option>


                                    <option
                                        value="IN_PROGRESS"
                                        <%= "IN_PROGRESS".equalsIgnoreCase(status)
                                            ? "selected"
                                            : "" %>>

                                        IN PROGRESS

                                    </option>


                                    <option
                                        value="RESOLVED"
                                        <%= "RESOLVED".equalsIgnoreCase(status)
                                            ? "selected"
                                            : "" %>>

                                        RESOLVED

                                    </option>


                                    <option
                                        value="CLOSED"
                                        <%= "CLOSED".equalsIgnoreCase(status)
                                            ? "selected"
                                            : "" %>>

                                        CLOSED

                                    </option>


                                </select>


                                <button
                                    type="submit"
                                    class="update-button"
                                    title="Update Status">

                                    <i class="bi bi-check-lg"></i>

                                </button>


                            </form>

                        </td>


                    </tr>


                <% } %>


                </tbody>

            </table>


            <% if (tickets.isEmpty()) { %>


                <div class="text-center py-5">


                    <div class="text-muted">

                        <i
                            class="bi bi-ticket-perforated"
                            style="font-size:40px;">
                        </i>

                    </div>


                    <h5 class="fw-bold mt-3">

                        No Tickets Found

                    </h5>


                    <p class="text-muted small">

                        There are currently no support incidents.

                    </p>

                </div>


            <% } %>


        </div>

    </div>


    <!-- FOOTER -->

    <div class="admin-footer">

        SmartDesk IT Service Desk & Incident Management

        <br>

        Secure administrator workspace • 2026

    </div>


</main>


<!-- =========================================================
     BOOTSTRAP JS
========================================================== -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<!-- =========================================================
     FILTER SCRIPT
========================================================== -->

<script>

    function filterTickets() {

        const search =
            document
                .getElementById("ticketSearch")
                .value
                .toLowerCase()
                .trim();


        const status =
            document
                .getElementById("statusFilter")
                .value;


        const priority =
            document
                .getElementById("priorityFilter")
                .value;


        const rows =
            document.querySelectorAll(
                "#adminTicketsTable tbody tr"
            );


        rows.forEach(function(row) {


            const rowSearch =
                row
                    .getAttribute("data-search")
                    .toLowerCase();


            const rowStatus =
                row.getAttribute("data-status");


            const rowPriority =
                row.getAttribute("data-priority");


            const matchesSearch =
                search === "" ||
                rowSearch.includes(search);


            const matchesStatus =
                status === "ALL" ||
                rowStatus === status;


            const matchesPriority =
                priority === "ALL" ||
                rowPriority === priority;


            if (
                matchesSearch &&
                matchesStatus &&
                matchesPriority
            ) {

                row.style.display = "";

            }

            else {

                row.style.display = "none";

            }

        });

    }


    document
        .getElementById("ticketSearch")
        .addEventListener(
            "keyup",
            filterTickets
        );


    document
        .getElementById("statusFilter")
        .addEventListener(
            "change",
            filterTickets
        );


    document
        .getElementById("priorityFilter")
        .addEventListener(
            "change",
            filterTickets
        );

</script>


</body>

</html>