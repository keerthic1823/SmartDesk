<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.service.TicketService" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
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

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>SmartDesk Dashboard</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <style>

        body {
            background-color: #f4f7fb;
            font-family: Arial, sans-serif;
        }

        .sidebar {
            min-height: 100vh;
            background: #0f172a;
            color: white;
            padding: 25px 15px;
        }

        .brand {
            font-size: 25px;
            font-weight: bold;
            margin-bottom: 40px;
            text-align: center;
        }

        .sidebar a {
            color: #cbd5e1;
            text-decoration: none;
            display: block;
            padding: 12px 15px;
            margin-bottom: 8px;
            border-radius: 8px;
        }

        .sidebar a:hover {
            background: #1e293b;
            color: white;
        }

        .sidebar a.active {
            background: #2563eb;
            color: white;
        }

        .topbar {
            background: white;
            padding: 18px 25px;
            border-bottom: 1px solid #e5e7eb;
        }

        .stat-card {
            border: none;
            border-radius: 15px;
            padding: 20px;
            background: white;
            box-shadow: 0 3px 15px rgba(0,0,0,0.06);
        }

        .stat-icon {
            font-size: 30px;
        }

        .welcome-card {
            background: #2563eb;
            color: white;
            border-radius: 15px;
            padding: 25px;
        }

        .content {
            padding: 25px;
        }

        .profile-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.06);
        }

    </style>

</head>

<body>

<div class="container-fluid">

    <div class="row">

        <!-- ================= SIDEBAR ================= -->

        <div class="col-md-2 sidebar">

            <div class="brand">

                <i class="bi bi-headset"></i>

                SmartDesk

            </div>


            <a href="#" class="active">

                <i class="bi bi-speedometer2 me-2"></i>

                Dashboard

            </a>


            <a href="${pageContext.request.contextPath}/MyTicketServlet">

    <i class="bi bi-ticket-detailed me-2"></i>

    Tickets

</a>


            <a href="create-ticket.jsp" class="btn btn-primary">
    <i class="bi bi-plus-circle"></i>
    Create Ticket
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


            <hr>


            <a href="LogoutServlet">

                <i class="bi bi-box-arrow-right me-2"></i>

                Logout

            </a>

        </div>


        <!-- ================= MAIN CONTENT ================= -->

        <div class="col-md-10 p-0">


            <!-- TOP BAR -->

            <div class="topbar d-flex justify-content-between align-items-center">

                <div>

                    <h5 class="mb-0">
                        Dashboard
                    </h5>

                    <small class="text-muted">
                        IT Service Desk & Incident Management
                    </small>

                </div>


                <div>

                    <span class="me-3">

                        <i class="bi bi-bell"></i>

                    </span>


                    <strong>
                        <%= user.getName() %>
                    </strong>

                </div>

            </div>


            <!-- CONTENT -->

            <div class="content">


                <!-- WELCOME -->

                <div class="welcome-card mb-4">

                    <h3>
                        Welcome, <%= user.getName() %>
                    </h3>

                    <p class="mb-0">

                        Here's what's happening with your SmartDesk
                        today.

                    </p>

                </div>


                <!-- STATISTICS -->

                <div class="row g-4 mb-4">


                    <div class="col-md-3">

                        <div class="stat-card">

                            <div class="d-flex justify-content-between">

                                <div>

                                    <p class="text-muted mb-1">
                                        Total Tickets
                                    </p>

                                    <h2><%= totalTickets %></h2>

                                </div>

                                <div class="stat-icon text-primary">

                                    <i class="bi bi-ticket"></i>

                                </div>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-3">

                        <div class="stat-card">

                            <div class="d-flex justify-content-between">

                                <div>

                                    <p class="text-muted mb-1">
                                        Open Tickets
                                    </p>

                                   <h2><%= openTickets %></h2>

                                </div>

                                <div class="stat-icon text-warning">

                                    <i class="bi bi-folder2-open"></i>

                                </div>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-3">

                        <div class="stat-card">

                            <div class="d-flex justify-content-between">

                                <div>

                                    <p class="text-muted mb-1">
                                        In Progress
                                    </p>

                                    <h2><%= inProgressTickets %></h2>

                                </div>

                                <div class="stat-icon text-info">

                                    <i class="bi bi-arrow-repeat"></i>

                                </div>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-3">

                        <div class="stat-card">

                            <div class="d-flex justify-content-between">

                                <div>

                                    <p class="text-muted mb-1">
                                        Resolved
                                    </p>

                                    <h2><%= resolvedTickets %></h2>

                                </div>

                                <div class="stat-icon text-success">

                                    <i class="bi bi-check-circle"></i>

                                </div>

                            </div>

                        </div>

                    </div>


                </div>


                <!-- USER PROFILE -->

                <div class="row">


                    <div class="col-md-8">

                        <div class="profile-card">

                            <h5 class="mb-4">

                                <i class="bi bi-person-circle me-2"></i>

                                My Profile

                            </h5>


                            <div class="row">

                                <div class="col-md-6 mb-3">

                                    <strong>Name</strong>

                                    <p class="text-muted">
                                        <%= user.getName() %>
                                    </p>

                                </div>


                                <div class="col-md-6 mb-3">

                                    <strong>Email</strong>

                                    <p class="text-muted">
                                        <%= user.getEmail() %>
                                    </p>

                                </div>


                                <div class="col-md-6 mb-3">

                                    <strong>Role</strong>

                                    <p class="text-muted">
                                        <%= user.getRole() %>
                                    </p>

                                </div>


                                <div class="col-md-6 mb-3">

                                    <strong>Department</strong>

                                    <p class="text-muted">
                                        <%= user.getDepartment() %>
                                    </p>

                                </div>


                                <div class="col-md-6">

                                    <strong>Status</strong>

                                    <p>

                                        <span class="badge bg-success">

                                            <%= user.getStatus() %>

                                        </span>

                                    </p>

                                </div>

                            </div>

                        </div>

                    </div>


                    <div class="col-md-4">

                        <div class="profile-card">

                            <h5>

                                <i class="bi bi-lightning-charge me-2"></i>

                                Quick Actions

                            </h5>

                            <hr>

                      <a href="${pageContext.request.contextPath}/create-ticket.jsp"
   class="btn btn-primary w-100 mb-2">

    <i class="bi bi-plus-circle me-2"></i>
    Create Ticket

</a>


                            <a href="${pageContext.request.contextPath}/MyTicketServlet">
    <i class="bi bi-ticket-detailed me-2"></i>
    My Tickets
</a>

                        </div>

                    </div>


                </div>


            </div>

        </div>

    </div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>