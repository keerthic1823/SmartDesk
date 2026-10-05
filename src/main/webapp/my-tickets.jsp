<%@ page import="java.util.List" %>
<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.model.Ticket" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Ticket> tickets =
            (List<Ticket>) request.getAttribute("tickets");

    if (tickets == null) {
        tickets = new java.util.ArrayList<Ticket>();
    }

    String userName = user.getName();

    String firstLetter = "U";

    if (userName != null && !userName.trim().isEmpty()) {
        firstLetter =
                userName.substring(0, 1).toUpperCase();
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | My Tickets</title>


    <!-- Bootstrap -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- Bootstrap Icons -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <!-- Font -->

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <!-- SmartDesk Global CSS -->

    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/css/style.css">


    <style>

        /* =====================================================
           PAGE
        ====================================================== */

        body {

            font-family: 'Inter', sans-serif;

            min-height: 100vh;

            background:

                radial-gradient(
                    circle at 5% 5%,
                    rgba(99,102,241,.10),
                    transparent 25%
                ),

                radial-gradient(
                    circle at 95% 20%,
                    rgba(124,58,237,.08),
                    transparent 30%
                ),

                linear-gradient(
                    135deg,
                    #f8fafc,
                    #eef2ff,
                    #f8fafc
                );

        }


        /* =====================================================
           STICKY NAVBAR
        ====================================================== */

        .ticket-navbar {

            position: sticky;

            top: 0;

            z-index: 2000;

            min-height: 72px;

            background:
                rgba(15,23,42,.97);

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


        /* =====================================================
           BRAND
        ====================================================== */

        .brand-logo {

            width: 43px;

            height: 43px;

            border-radius: 13px;

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

            font-size: 21px;

            box-shadow:
                0 8px 25px
                rgba(99,102,241,.35);

        }


        .brand-name {

            color: white;

            font-size: 21px;

            font-weight: 800;

            letter-spacing: -.5px;

        }


        /* =====================================================
           NAV LINKS
        ====================================================== */

        .nav-link-custom {

            color: #cbd5e1 !important;

            font-size: 14px;

            font-weight: 500;

            padding:
                10px 15px !important;

            border-radius: 11px;

            transition: .25s ease;

        }


        .nav-link-custom:hover {

            color: white !important;

            background:
                rgba(255,255,255,.09);

        }


        .nav-link-custom.active {

            color: white !important;

            background:
                rgba(99,102,241,.22);

            box-shadow:
                inset 0 0 0 1px
                rgba(255,255,255,.05);

        }


        /* =====================================================
           PROFILE
        ====================================================== */

        .profile-avatar {

            width: 39px;

            height: 39px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #8b5cf6,
                    #4f46e5
                );

            color: white;

            font-weight: 700;

        }


        .profile-button {

            border: none;

            background: transparent;

            color: white;

            display: flex;

            align-items: center;

            gap: 9px;

            padding: 5px 8px;

            border-radius: 12px;

        }


        .profile-button:hover {

            background:
                rgba(255,255,255,.08);

        }


        /* =====================================================
           MAIN CONTAINER
        ====================================================== */

        .tickets-container {

            max-width: 1450px;

            margin: auto;

            padding:
                35px 28px 60px;

        }


        /* =====================================================
           PAGE HEADER
        ====================================================== */

        .page-header {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;

            margin-bottom: 28px;

        }


        .page-label {

            color: #4f46e5;

            font-size: 13px;

            font-weight: 800;

            letter-spacing: .5px;

            text-transform: uppercase;

        }


        .page-title {

            font-size: 36px;

            font-weight: 800;

            color: #0f172a;

            margin:
                5px 0 6px;

            letter-spacing: -1px;

        }


        .page-description {

            color: #64748b;

            font-size: 14px;

            margin: 0;

        }


        /* =====================================================
           NEW TICKET BUTTON
        ====================================================== */

        .new-ticket-btn {

            border: none;

            border-radius: 12px;

            padding:
                12px 19px;

            color: white;

            font-weight: 700;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            box-shadow:
                0 10px 25px
                rgba(79,70,229,.25);

            transition: .25s ease;

            text-decoration: none;

            white-space: nowrap;

        }


        .new-ticket-btn:hover {

            color: white;

            transform:
                translateY(-2px);

            box-shadow:
                0 15px 30px
                rgba(79,70,229,.35);

        }


        /* =====================================================
           SUMMARY CARDS
        ====================================================== */

        .summary-card {

            background:
                rgba(255,255,255,.92);

            border:
                1px solid
                #e2e8f0;

            border-radius: 17px;

            padding: 18px;

            height: 100%;

            box-shadow:
                0 8px 25px
                rgba(15,23,42,.04);

        }


        .summary-icon {

            width: 40px;

            height: 40px;

            border-radius: 11px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eef2ff;

            color: #4f46e5;

        }


        .summary-number {

            font-size: 25px;

            font-weight: 800;

            margin-top: 10px;

        }


        .summary-label {

            color: #64748b;

            font-size: 12px;

            font-weight: 600;

        }


        /* =====================================================
           TABLE CARD
        ====================================================== */

        .tickets-card {

            background:
                rgba(255,255,255,.96);

            border:
                1px solid
                #e2e8f0;

            border-radius: 22px;

            box-shadow:
                0 12px 35px
                rgba(15,23,42,.06);

            overflow: hidden;

        }


        .tickets-card-header {

            padding:
                22px 24px;

            border-bottom:
                1px solid
                #e2e8f0;

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 15px;

        }


        .tickets-card-title {

            font-size: 17px;

            font-weight: 800;

            color: #111827;

        }


        .ticket-search {

            width: 240px;

            height: 40px;

            border:
                1px solid
                #dbe3ef;

            border-radius: 10px;

            padding:
                0 13px;

            outline: none;

            background: #f8fafc;

            font-size: 13px;

        }


        .ticket-search:focus {

            background: white;

            border-color: #6366f1;

            box-shadow:
                0 0 0 3px
                rgba(99,102,241,.10);

        }


        /* =====================================================
           TABLE
        ====================================================== */

        .ticket-table {

            margin: 0;

            width: 100%;

        }


        .ticket-table thead th {

            background: #f8fafc;

            color: #64748b;

            font-size: 11px;

            text-transform: uppercase;

            letter-spacing: .5px;

            font-weight: 700;

            padding:
                15px 18px;

            border-bottom:
                1px solid
                #e2e8f0;

            white-space: nowrap;

        }


        .ticket-table tbody td {

            padding:
                17px 18px;

            vertical-align: middle;

            border-bottom:
                1px solid
                #f1f5f9;

            color: #334155;

            font-size: 13px;

        }


        .ticket-table tbody tr {

            transition: .2s ease;

        }


        .ticket-table tbody tr:hover {

            background:
                #f8faff;

        }


        .ticket-id {

            font-weight: 800;

            color: #4f46e5;

        }


        .ticket-title {

            font-weight: 700;

            color: #111827;

        }


        .ticket-date {

            color: #94a3b8;

            font-size: 11px;

            margin-top: 4px;

        }


        /* =====================================================
           BADGES
        ====================================================== */

        .ticket-badge {

            display: inline-flex;

            align-items: center;

            gap: 5px;

            border-radius: 20px;

            padding:
                6px 10px;

            font-size: 10px;

            font-weight: 800;

        }


        .priority-high {

            background: #fee2e2;

            color: #b91c1c;

        }


        .priority-medium {

            background: #fef3c7;

            color: #92400e;

        }


        .priority-low {

            background: #dcfce7;

            color: #166534;

        }


        .priority-critical {

            background: #ede9fe;

            color: #6d28d9;

        }


        .status-open {

            background: #dbeafe;

            color: #1d4ed8;

        }


        .status-assigned {

            background: #e0e7ff;

            color: #4338ca;

        }


        .status-progress {

            background: #fef3c7;

            color: #92400e;

        }


        .status-resolved {

            background: #dcfce7;

            color: #166534;

        }


        .status-closed {

            background: #e2e8f0;

            color: #334155;

        }


        /* =====================================================
           VIEW BUTTON
        ====================================================== */

        .view-btn {

            border:
                1px solid
                #c7d2fe;

            color:
                #4f46e5;

            background:
                #eef2ff;

            border-radius: 9px;

            padding:
                7px 12px;

            font-size: 12px;

            font-weight: 700;

            text-decoration: none;

            transition: .2s ease;

        }


        .view-btn:hover {

            color: white;

            background:
                #4f46e5;

            border-color:
                #4f46e5;

        }


        /* =====================================================
           EMPTY STATE
        ====================================================== */

        .empty-state {

            padding:
                75px 20px;

            text-align: center;

        }


        .empty-icon {

            width: 70px;

            height: 70px;

            margin:
                0 auto 18px;

            border-radius: 20px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                #eef2ff;

            color:
                #4f46e5;

            font-size: 28px;

        }


        .empty-title {

            font-size: 18px;

            font-weight: 800;

        }


        .empty-text {

            color: #64748b;

            font-size: 13px;

            max-width: 450px;

            margin:
                7px auto 20px;

        }


        /* =====================================================
           FOOTER
        ====================================================== */

        .page-footer {

            text-align: center;

            color: #94a3b8;

            font-size: 11px;

            padding-top: 40px;

        }


        /* =====================================================
           RESPONSIVE
        ====================================================== */

        @media (max-width: 991px) {

            .page-header {

                align-items: flex-start;

            }

            .ticket-search {

                width: 200px;

            }

        }


        @media (max-width: 767px) {

            .tickets-container {

                padding:
                    25px 14px 45px;

            }

            .page-header {

                flex-direction: column;

            }

            .page-title {

                font-size: 30px;

            }

            .new-ticket-btn {

                width: 100%;

                text-align: center;

            }

            .tickets-card-header {

                flex-direction: column;

                align-items: stretch;

            }

            .ticket-search {

                width: 100%;

            }

            .table-responsive {

                border-radius: 0;

            }

        }

    </style>

</head>


<body>


<!-- =========================================================
     STICKY NAVBAR
========================================================== -->

<nav class="navbar navbar-expand-lg ticket-navbar">

    <div class="container-fluid px-4">


        <!-- BRAND -->

        <a
            class="navbar-brand d-flex align-items-center gap-2"
            href="<%= request.getContextPath() %>/dashboard.jsp">

            <div class="brand-logo">

                <i class="bi bi-headset"></i>

            </div>

            <span class="brand-name">

                SmartDesk

            </span>

        </a>


        <!-- MOBILE -->

        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#ticketNavbar">

            <span class="navbar-toggler-icon"></span>

        </button>


        <!-- NAVIGATION -->

        <div
            class="collapse navbar-collapse"
            id="ticketNavbar">


            <ul class="navbar-nav ms-4 me-auto">


                <li class="nav-item">

                    <a
                        class="nav-link nav-link-custom"
                        href="<%= request.getContextPath() %>/dashboard.jsp">

                        <i class="bi bi-grid me-1"></i>

                        Dashboard

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link nav-link-custom active"
                        href="<%= request.getContextPath() %>/MyTicketServlet">

                        <i class="bi bi-ticket-perforated me-1"></i>

                        My Tickets

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link nav-link-custom"
                        href="<%= request.getContextPath() %>/reports.jsp">

                        <i class="bi bi-bar-chart me-1"></i>

                        Reports

                    </a>

                </li>

            </ul>


            <!-- PROFILE -->

            <div class="dropdown">

                <button
                    class="profile-button dropdown-toggle"
                    type="button"
                    data-bs-toggle="dropdown">

                    <div class="profile-avatar">

                        <%= firstLetter %>

                    </div>

                    <span class="d-none d-md-inline">

                        <%= userName %>

                    </span>

                </button>


                <ul class="dropdown-menu dropdown-menu-end shadow border-0">


                    <li>

                        <h6 class="dropdown-header">

                            <%= userName %>

                        </h6>

                    </li>


                    <li>

                        <span
                            class="dropdown-item-text small text-muted">

                            <%= user.getEmail() %>

                        </span>

                    </li>


                    <li>
                        <hr class="dropdown-divider">
                    </li>


                    <li>

                        <a
                            class="dropdown-item"
                            href="<%= request.getContextPath() %>/users.jsp">

                            <i class="bi bi-person me-2"></i>

                            My Profile

                        </a>

                    </li>


                    <li>

                        <a
                            class="dropdown-item"
                            href="<%= request.getContextPath() %>/settings.jsp">

                            <i class="bi bi-gear me-2"></i>

                            Settings

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

<main class="tickets-container">


    <!-- =====================================================
         HEADER
    ====================================================== -->

    <div class="page-header">


        <div>

            <div class="page-label">

                My Workspace

            </div>


            <h1 class="page-title">

                My Tickets

            </h1>


            <p class="page-description">

                View, track and manage all support requests
                created by you.

            </p>

        </div>


        <a
            href="<%= request.getContextPath() %>/create-ticket.jsp"
            class="new-ticket-btn">

            <i class="bi bi-plus-lg me-2"></i>

            New Ticket

        </a>

    </div>


    <!-- =====================================================
         SUMMARY
    ====================================================== -->

    <div class="row g-3 mb-4">


        <div class="col-6 col-md-3">

            <div class="summary-card">

                <div class="summary-icon">

                    <i class="bi bi-ticket-detailed"></i>

                </div>

                <div class="summary-number">

                    <%= tickets.size() %>

                </div>

                <div class="summary-label">

                    Total Tickets

                </div>

            </div>

        </div>


        <%

            int openCount = 0;

            int progressCount = 0;

            int resolvedCount = 0;

            int closedCount = 0;


            for (Ticket t : tickets) {

                String s = t.getStatus();

                if ("OPEN".equalsIgnoreCase(s)) {
                    openCount++;
                }

                else if ("IN_PROGRESS".equalsIgnoreCase(s)) {
                    progressCount++;
                }

                else if ("RESOLVED".equalsIgnoreCase(s)) {
                    resolvedCount++;
                }

                else if ("CLOSED".equalsIgnoreCase(s)) {
                    closedCount++;
                }

            }

        %>


        <div class="col-6 col-md-3">

            <div class="summary-card">

                <div class="summary-icon">

                    <i class="bi bi-envelope-open"></i>

                </div>

                <div class="summary-number">

                    <%= openCount %>

                </div>

                <div class="summary-label">

                    Open

                </div>

            </div>

        </div>


        <div class="col-6 col-md-3">

            <div class="summary-card">

                <div class="summary-icon">

                    <i class="bi bi-arrow-repeat"></i>

                </div>

                <div class="summary-number">

                    <%= progressCount %>

                </div>

                <div class="summary-label">

                    In Progress

                </div>

            </div>

        </div>


        <div class="col-6 col-md-3">

            <div class="summary-card">

                <div class="summary-icon">

                    <i class="bi bi-check2-circle"></i>

                </div>

                <div class="summary-number">

                    <%= resolvedCount %>

                </div>

                <div class="summary-label">

                    Resolved

                </div>

            </div>

        </div>

    </div>


    <!-- =====================================================
         TICKETS
    ====================================================== -->

    <div class="tickets-card">


        <div class="tickets-card-header">


            <div>

                <div class="tickets-card-title">

                    Your Support Requests

                </div>

                <small class="text-muted">

                    <%= tickets.size() %>
                    ticket(s) found

                </small>

            </div>


            <input
                type="text"
                id="ticketSearch"
                class="ticket-search"
                placeholder="Search tickets...">

        </div>


        <% if (tickets.isEmpty()) { %>


            <!-- EMPTY -->

            <div class="empty-state">


                <div class="empty-icon">

                    <i class="bi bi-ticket-perforated"></i>

                </div>


                <div class="empty-title">

                    No tickets yet

                </div>


                <p class="empty-text">

                    You haven't created any support tickets.
                    Create your first ticket to get help
                    from the IT support team.

                </p>


                <a
                    href="<%= request.getContextPath() %>/create-ticket.jsp"
                    class="new-ticket-btn">

                    <i class="bi bi-plus-lg me-2"></i>

                    Create Your First Ticket

                </a>

            </div>


        <% } else { %>


            <!-- TABLE -->

            <div class="table-responsive">


                <table
                    class="table ticket-table"
                    id="ticketsTable">


                    <thead>

                        <tr>

                            <th>
                                ID
                            </th>

                            <th>
                                Ticket
                            </th>

                            <th>
                                Category
                            </th>

                            <th>
                                Priority
                            </th>

                            <th>
                                Status
                            </th>

                            <th>
                                Assigned
                            </th>

                            <th>
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (Ticket ticket : tickets) { %>


                        <tr>


                            <!-- ID -->

                            <td>

                                <span class="ticket-id">

                                    #<%= ticket.getTicketId() %>

                                </span>

                            </td>


                            <!-- TITLE -->

                            <td>

                                <div class="ticket-title">

                                    <%= ticket.getTitle() %>

                                </div>


                                <div class="ticket-date">

                                    <%= ticket.getCreatedAt() %>

                                </div>

                            </td>


                            <!-- CATEGORY -->

                            <td>

                                <%= ticket.getCategory() %>

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
                                    class="ticket-badge <%= priorityClass %>">

                                    <i class="bi bi-flag-fill"></i>

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
                                    class="ticket-badge <%= statusClass %>">

                                    <i class="bi bi-circle-fill"
                                       style="font-size:6px;"></i>

                                    <%= status %>

                                </span>

                            </td>


                            <!-- ASSIGNED -->

                            <td>

                                <%

                                    if (ticket.getAssignedTo() > 0) {

                                %>

                                    <span class="text-success fw-semibold">

                                        <i class="bi bi-person-check me-1"></i>

                                        Assigned

                                    </span>

                                <%

                                    } else {

                                %>

                                    <span class="text-muted">

                                        Unassigned

                                    </span>

                                <%

                                    }

                                %>

                            </td>


                            <!-- VIEW -->

                            <td>

                                <a
                                    href="<%= request.getContextPath() %>/TicketDetailsServlet?ticketId=<%= ticket.getTicketId() %>"
                                    class="view-btn">

                                    <i class="bi bi-eye me-1"></i>

                                    View

                                </a>

                            </td>


                        </tr>


                    <% } %>


                    </tbody>

                </table>

            </div>


        <% } %>


    </div>


    <!-- FOOTER -->

    <div class="page-footer">

        SmartDesk IT Service Desk & Incident Management

        <br>

        <span>
            Secure workspace • 2026
        </span>

    </div>


</main>


<!-- =========================================================
     BOOTSTRAP
========================================================== -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<!-- =========================================================
     SEARCH
========================================================== -->

<script>

    const searchInput =
        document.getElementById("ticketSearch");

    const table =
        document.getElementById("ticketsTable");


    if (searchInput && table) {

        searchInput.addEventListener(
            "keyup",
            function () {

                const value =
                    this.value.toLowerCase();

                const rows =
                    table.querySelectorAll("tbody tr");


                rows.forEach(
                    function (row) {

                        row.style.display =
                            row.innerText
                                .toLowerCase()
                                .includes(value)
                                ? ""
                                : "none";

                    }
                );

            }
        );

    }

</script>


</body>

</html>