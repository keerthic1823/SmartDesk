<%@ page import="java.util.List" %>
<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.model.Ticket" %>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(
        request.getContextPath() + "/login.jsp"
    );
    return;
}

List<Ticket> tickets =
        (List<Ticket>) request.getAttribute("tickets");

if (tickets == null) {
    tickets = new java.util.ArrayList<>();
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Tickets - SmartDesk</title>

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

.table {
    vertical-align: middle;
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


    <a href="${pageContext.request.contextPath}/MyTicketServlet"
       class="active">

        <i class="bi bi-ticket-detailed me-2"></i>

        Tickets

    </a>


    <a href="users.jsp">

        <i class="bi bi-people me-2"></i>

        Users

    </a>


    <a href="reports.jsp">

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


<!-- MAIN CONTENT -->

<div class="col-md-10 p-4">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h2>My Tickets</h2>

            <p class="text-muted mb-0">

                View tickets created by you

            </p>

        </div>


        <a
            href="${pageContext.request.contextPath}/create-ticket.jsp"
            class="btn btn-primary">

            <i class="bi bi-plus-circle me-2"></i>

            Create Ticket

        </a>

    </div>


    <!-- TICKET TABLE -->

    <div class="card shadow-sm">

        <div class="card-body">

            <div class="d-flex justify-content-between align-items-center mb-3">

                <h5 class="mb-0">

                    <i class="bi bi-ticket-detailed me-2"></i>

                    Ticket List

                </h5>

                <span class="badge bg-primary">

                    <%= tickets.size() %> Tickets

                </span>

            </div>


            <%
            if (tickets.isEmpty()) {
            %>

                <div class="text-center py-5">

                    <i class="bi bi-inbox fs-1 text-muted"></i>

                    <h5 class="mt-3">
                        No tickets found
                    </h5>

                    <p class="text-muted">
                        You have not created any tickets yet.
                    </p>

                    <a
                        href="${pageContext.request.contextPath}/create-ticket.jsp"
                        class="btn btn-primary">

                        <i class="bi bi-plus-circle me-2"></i>

                        Create Your First Ticket

                    </a>

                </div>

            <%
            } else {
            %>

                <div class="table-responsive">

                    <table class="table table-hover">

                        <thead class="table-light">

                            <tr>

                                <th>ID</th>

                                <th>Title</th>

                                <th>Category</th>

                                <th>Priority</th>

                                <th>Status</th>

                                <th>Created</th>

                            </tr>

                        </thead>


                        <tbody>

                        <%
                        for (Ticket ticket : tickets) {
                        %>

                            <tr>

                                <td>

                                    <strong>
                                        #<%= ticket.getTicketId() %>
                                    </strong>

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
                                    String priorityClass = "bg-secondary";

                                    if ("HIGH".equals(ticket.getPriority())) {
                                        priorityClass = "bg-danger";
                                    } else if ("MEDIUM".equals(ticket.getPriority())) {
                                        priorityClass = "bg-warning text-dark";
                                    } else if ("LOW".equals(ticket.getPriority())) {
                                        priorityClass = "bg-success";
                                    } else if ("CRITICAL".equals(ticket.getPriority())) {
                                        priorityClass = "bg-dark";
                                    }
                                    %>

                                    <span class="badge <%= priorityClass %>">

                                        <%= ticket.getPriority() %>

                                    </span>

                                </td>


                                <td>

                                    <%
                                    String statusClass = "bg-secondary";

                                    if ("OPEN".equals(ticket.getStatus())) {
                                        statusClass = "bg-primary";
                                    } else if ("IN_PROGRESS".equals(ticket.getStatus())) {
                                        statusClass = "bg-warning text-dark";
                                    } else if ("RESOLVED".equals(ticket.getStatus())) {
                                        statusClass = "bg-success";
                                    } else if ("CLOSED".equals(ticket.getStatus())) {
                                        statusClass = "bg-dark";
                                    }
                                    %>

                                    <span class="badge <%= statusClass %>">

                                        <%= ticket.getStatus() %>

                                    </span>

                                </td>


                                <td>

                                    <%= ticket.getCreatedAt() %>

                                </td>

                            </tr>

                        <%
                        }
                        %>

                        </tbody>

                    </table>

                </div>

            <%
            }
            %>

        </div>

    </div>


    <!-- BACK BUTTON -->

    <div class="mt-4">

        <a href="dashboard.jsp"
           class="btn btn-outline-secondary">

            <i class="bi bi-arrow-left me-2"></i>

            Back to Dashboard

        </a>

    </div>

</div>

</div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>