<%@ page import="java.util.List" %>
<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.model.Ticket" %>
<%@ page import="com.smartdesk.service.UserService" %>
<%@ page import="com.smartdesk.service.TicketService" %>

<%

User user = (User) session.getAttribute("user");

if (user == null) {

    response.sendRedirect(
        request.getContextPath() + "/login.jsp"
    );

    return;
}


// ADMIN ONLY

if (!"ADMIN".equalsIgnoreCase(user.getRole())) {

    response.sendRedirect(
        request.getContextPath() + "/dashboard.jsp"
    );

    return;
}


// SERVICES

UserService userService = new UserService();

TicketService ticketService = new TicketService();


// GET ALL USERS

List<User> users = userService.getAllUsers();


// GET ALL TICKETS

List<Ticket> tickets = ticketService.getAllTickets();


// TICKET COUNTS

int totalTickets = tickets.size();

int openTickets = 0;

int inProgressTickets = 0;

int resolvedTickets = 0;


for (Ticket ticket : tickets) {

    if ("OPEN".equalsIgnoreCase(ticket.getStatus())) {

        openTickets++;

    }

    else if ("IN_PROGRESS".equalsIgnoreCase(ticket.getStatus())) {

        inProgressTickets++;

    }

    else if ("RESOLVED".equalsIgnoreCase(ticket.getStatus())) {

        resolvedTickets++;

    }

}

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard - SmartDesk</title>


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
    background: #dc3545;
    color: white;
}


.card {
    border: none;
    border-radius: 12px;
}


.admin-banner {
    background: #212529;
    color: white;
    border-radius: 12px;
}


.section-title {
    border-left: 5px solid #dc3545;
    padding-left: 12px;
}


.table {
    vertical-align: middle;
}

</style>

</head>


<body>


<div class="container-fluid">

<div class="row">


<!-- ================= SIDEBAR ================= -->

<div class="col-md-2 sidebar p-0">


    <div class="p-4 text-white">

        <h4>

            <i class="bi bi-shield-lock"></i>

            SmartDesk

        </h4>

        <small>Admin Panel</small>

    </div>


    <a href="#dashboard" class="active">

        <i class="bi bi-speedometer2 me-2"></i>

        Dashboard

    </a>


    <a href="#tickets">

        <i class="bi bi-ticket-detailed me-2"></i>

        All Tickets

    </a>


    <a href="#users">

        <i class="bi bi-people me-2"></i>

        All Users

    </a>


    <a href="reports.jsp">

        <i class="bi bi-bar-chart me-2"></i>

        Reports

    </a>


    <div class="mt-4">

        <a href="${pageContext.request.contextPath}/LogoutServlet">

            <i class="bi bi-box-arrow-right me-2"></i>

            Logout

        </a>

    </div>


</div>


<!-- ================= MAIN CONTENT ================= -->

<div class="col-md-10 p-4">


<!-- ================= DASHBOARD ================= -->

<div id="dashboard">


    <div class="d-flex justify-content-between align-items-center mb-4">


        <div>

            <h2>Admin Dashboard</h2>

            <p class="text-muted">

                IT Service Desk Administration

            </p>

        </div>


        <div>

            <span class="badge bg-danger">

                <i class="bi bi-shield-check me-1"></i>

                ADMIN

            </span>


            <strong class="ms-2">

                <%= user.getName() %>

            </strong>

        </div>


    </div>


    <!-- ADMIN BANNER -->

    <div class="admin-banner p-4 mb-4">


        <h3>

            <i class="bi bi-shield-lock me-2"></i>

            Welcome, <%= user.getName() %>

        </h3>


        <p class="mb-0">

            Manage users, monitor tickets and oversee

            SmartDesk operations.

        </p>


    </div>


    <!-- STATISTICS -->

    <div class="row g-4 mb-5">


        <!-- TOTAL -->

        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted">

                        Total Tickets

                    </p>


                    <h2>

                        <%= totalTickets %>

                    </h2>


                    <i class="bi bi-ticket-detailed fs-2"></i>

                </div>

            </div>

        </div>


        <!-- OPEN -->

        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted">

                        Open Tickets

                    </p>


                    <h2>

                        <%= openTickets %>

                    </h2>


                    <i class="bi bi-folder2-open fs-2"></i>

                </div>

            </div>

        </div>


        <!-- IN PROGRESS -->

        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted">

                        In Progress

                    </p>


                    <h2>

                        <%= inProgressTickets %>

                    </h2>


                    <i class="bi bi-arrow-repeat fs-2"></i>

                </div>

            </div>

        </div>


        <!-- RESOLVED -->

        <div class="col-md-3">

            <div class="card shadow-sm">

                <div class="card-body">

                    <p class="text-muted">

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

</div>


<!-- ================= ALL TICKETS ================= -->

<div id="tickets" class="mb-5">


    <h3 class="section-title mb-4">

        All Tickets

    </h3>


    <div class="card shadow-sm">


        <div class="card-body">


            <div class="d-flex justify-content-between mb-3">

                <h5>

                    <i class="bi bi-ticket-detailed me-2"></i>

                    Ticket Management

                </h5>


                <span class="badge bg-danger">

                    <%= tickets.size() %> Tickets

                </span>

            </div>


            <div class="table-responsive">


                <table class="table table-hover align-middle">


                    <thead class="table-dark">

                        <tr>

                            <th>ID</th>

                            <th>Title</th>

                            <th>Category</th>

                            <th>Priority</th>

                            <th>Status</th>

                            <th>Created By</th>

                            <th>Created</th>

                        </tr>

                    </thead>


                    <tbody>


                    <%

                    if (tickets.isEmpty()) {

                    %>


                        <tr>

                            <td colspan="7"
                                class="text-center py-4">

                                No tickets found.

                            </td>

                        </tr>


                    <%

                    } else {


                        for (Ticket ticket : tickets) {

                    %>


                        <tr>


                            <td>

                                #<%= ticket.getTicketId() %>

                            </td>


                            <td>

                                <strong>

                                    <%= ticket.getTitle() %>

                                </strong>


                                <br>


                                <small class="text-muted">

                                    <%= ticket.getDescription() %>

                                </small>

                            </td>


                            <td>

                                <span class="badge bg-secondary">

                                    <%= ticket.getCategory() %>

                                </span>

                            </td>


                            <td>


                                <%

                                String priorityClass =
                                    "bg-secondary";


                                if ("HIGH".equalsIgnoreCase(
                                    ticket.getPriority())) {

                                    priorityClass =
                                        "bg-danger";

                                }

                                else if ("MEDIUM".equalsIgnoreCase(
                                    ticket.getPriority())) {

                                    priorityClass =
                                        "bg-warning text-dark";

                                }

                                else if ("LOW".equalsIgnoreCase(
                                    ticket.getPriority())) {

                                    priorityClass =
                                        "bg-success";

                                }

                                else if ("CRITICAL".equalsIgnoreCase(
                                    ticket.getPriority())) {

                                    priorityClass =
                                        "bg-dark";

                                }

                                %>


                                <span class="badge <%= priorityClass %>">

                                    <%= ticket.getPriority() %>

                                </span>


                            </td>


                            <td>


                                <%

                                String statusClass =
                                    "bg-secondary";


                                if ("OPEN".equalsIgnoreCase(
                                    ticket.getStatus())) {

                                    statusClass =
                                        "bg-primary";

                                }

                                else if ("IN_PROGRESS".equalsIgnoreCase(
                                    ticket.getStatus())) {

                                    statusClass =
                                        "bg-warning text-dark";

                                }

                                else if ("RESOLVED".equalsIgnoreCase(
                                    ticket.getStatus())) {

                                    statusClass =
                                        "bg-success";

                                }

                                else if ("CLOSED".equalsIgnoreCase(
                                    ticket.getStatus())) {

                                    statusClass =
                                        "bg-dark";

                                }

                                %>


                                <span class="badge <%= statusClass %>">

                                    <%= ticket.getStatus() %>

                                </span>


                            </td>


                            <td>

                                User #<%= ticket.getCreatedBy() %>

                            </td>


                            <td>

                                <small>

                                    <%= ticket.getCreatedAt() %>

                                </small>

                            </td>


                        </tr>


                    <%

                        }

                    }

                    %>


                    </tbody>

                </table>


            </div>


        </div>

    </div>


</div>


<!-- ================= ALL USERS ================= -->

<div id="users" class="mb-5">


    <h3 class="section-title mb-4">

        All Users

    </h3>


    <div class="card shadow-sm">


        <div class="card-body">


            <div class="d-flex justify-content-between mb-3">


                <h5>

                    <i class="bi bi-people me-2"></i>

                    User Management

                </h5>


                <span class="badge bg-danger">

                    <%= users.size() %> Users

                </span>


            </div>


            <div class="table-responsive">


                <table class="table table-hover align-middle">


                    <thead class="table-dark">


                        <tr>

                            <th>ID</th>

                            <th>Name</th>

                            <th>Email</th>

                            <th>Role</th>

                            <th>Department</th>

                            <th>Status</th>

                        </tr>


                    </thead>


                    <tbody>


                    <%

                    for (User currentUser : users) {

                    %>


                        <tr>


                            <td>

                                #<%= currentUser.getUserId() %>

                            </td>


                            <td>

                                <strong>

                                    <%= currentUser.getName() %>

                                </strong>

                            </td>


                            <td>

                                <%= currentUser.getEmail() %>

                            </td>


                            <td>


                                <%

                                String roleClass =
                                    "ADMIN".equalsIgnoreCase(
                                        currentUser.getRole())
                                    ? "bg-danger"
                                    : "bg-primary";

                                %>


                                <span class="badge <%= roleClass %>">

                                    <%= currentUser.getRole() %>

                                </span>


                            </td>


                            <td>

                                <%= currentUser.getDepartment() %>

                            </td>


                            <td>


                                <%

                                String userStatusClass =
                                    "ACTIVE".equalsIgnoreCase(
                                        currentUser.getStatus())
                                    ? "bg-success"
                                    : "bg-secondary";

                                %>


                                <span class="badge <%= userStatusClass %>">

                                    <%= currentUser.getStatus() %>

                                </span>


                            </td>


                        </tr>


                    <%

                    }

                    %>


                    </tbody>


                </table>


            </div>


        </div>

    </div>


</div>


<!-- ================= REPORTS ================= -->

<div class="card shadow-sm mb-5">


    <div class="card-body">


        <h4>

            <i class="bi bi-bar-chart me-2"></i>

            Reports

        </h4>


        <p class="text-muted">

            Quick service desk summary

        </p>


        <div class="row">


            <div class="col-md-3">

                <strong>Total Tickets</strong>

                <h4>

                    <%= totalTickets %>

                </h4>

            </div>


            <div class="col-md-3">

                <strong>Open</strong>

                <h4>

                    <%= openTickets %>

                </h4>

            </div>


            <div class="col-md-3">

                <strong>In Progress</strong>

                <h4>

                    <%= inProgressTickets %>

                </h4>

            </div>


            <div class="col-md-3">

                <strong>Resolved</strong>

                <h4>

                    <%= resolvedTickets %>

                </h4>

            </div>


        </div>


    </div>

</div>


</div>

</div>

</div>


</body>

</html>