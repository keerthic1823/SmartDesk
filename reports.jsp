<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.service.TicketService" %>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(
        request.getContextPath() + "/login.jsp"
    );
    return;
}

TicketService ticketService = new TicketService();

int totalTickets =
        ticketService.getTotalTickets(user.getUserId());

int openTickets =
        ticketService.getOpenTickets(user.getUserId());

int inProgressTickets =
        ticketService.getInProgressTickets(user.getUserId());

int resolvedTickets =
        ticketService.getResolvedTickets(user.getUserId());
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Reports - SmartDesk</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>

body {
    background: #f5f7fb;
}

.sidebar {
    min-height: 100vh;
    background: #212529;
}

.sidebar a {
    color: #adb5bd;
    text-decoration: none;
    display: block;
    padding: 12px 20px;
}

.sidebar a:hover {
    background: #343a40;
    color: white;
}

.sidebar .active {
    background: #0d6efd;
    color: white;
}

.card {
    border: none;
    border-radius: 12px;
}

</style>

</head>

<body>

<div class="container-fluid">

<div class="row">

<!-- SIDEBAR -->

<div class="col-md-2 sidebar p-0">

    <div class="p-4 text-white">

        <h4>
            <i class="bi bi-headset"></i>
            SmartDesk
        </h4>

        <small>IT Service Desk</small>

    </div>

    <a href="dashboard.jsp">
        <i class="bi bi-speedometer2 me-2"></i>
        Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/MyTicketServlet">
        <i class="bi bi-ticket-detailed me-2"></i>
        Tickets
    </a>

    <a href="users.jsp">
        <i class="bi bi-people me-2"></i>
        Users
    </a>

    <a href="reports.jsp" class="active">
        <i class="bi bi-bar-chart me-2"></i>
        Reports
    </a>

    <a href="settings.jsp">
        <i class="bi bi-gear me-2"></i>
        Settings
    </a>

    <div class="mt-4">

        <a href="${pageContext.request.contextPath}/LogoutServlet">
            <i class="bi bi-box-arrow-right me-2"></i>
            Logout
        </a>

    </div>

</div>


<!-- MAIN -->

<div class="col-md-10 p-4">

    <h2>Reports</h2>

    <p class="text-muted">
        Ticket summary for <strong><%= user.getName() %></strong>
    </p>


    <!-- STAT CARDS -->

    <div class="row g-4 mt-2">

        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted mb-1">
                        Total Tickets
                    </p>

                    <h2>
                        <%= totalTickets %>
                    </h2>

                    <i class="bi bi-ticket-perforated fs-2"></i>

                </div>

            </div>

        </div>


        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted mb-1">
                        Open Tickets
                    </p>

                    <h2>
                        <%= openTickets %>
                    </h2>

                    <i class="bi bi-folder2-open fs-2"></i>

                </div>

            </div>

        </div>


        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted mb-1">
                        In Progress
                    </p>

                    <h2>
                        <%= inProgressTickets %>
                    </h2>

                    <i class="bi bi-arrow-repeat fs-2"></i>

                </div>

            </div>

        </div>


        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted mb-1">
                        Resolved
                    </p>

                    <h2>
                        <%= resolvedTickets %>
                    </h2>

                    <i class="bi bi-check-circle fs-2"></i>

                </div>

            </div>

        </div>

    </div>


    <!-- REPORT SUMMARY -->

    <div class="card shadow-sm mt-4">

        <div class="card-body">

            <h5>
                <i class="bi bi-file-earmark-bar-graph me-2"></i>
                Ticket Report Summary
            </h5>

            <hr>

            <p>
                Total tickets created:
                <strong><%= totalTickets %></strong>
            </p>

            <p>
                Currently open:
                <strong><%= openTickets %></strong>
            </p>

            <p>
                In progress:
                <strong><%= inProgressTickets %></strong>
            </p>

            <p class="mb-0">
                Resolved:
                <strong><%= resolvedTickets %></strong>
            </p>

        </div>

    </div>

</div>

</div>

</div>

</body>

</html>