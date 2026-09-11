<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.smartdesk.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Create Ticket - SmartDesk</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            background-color: #f4f6f9;
        }

        .sidebar {
            min-height: 100vh;
            background-color: #212529;
        }

        .sidebar h3 {
            color: white;
            padding: 20px;
            margin-bottom: 10px;
        }

        .sidebar a {
            color: #ced4da;
            text-decoration: none;
            display: block;
            padding: 12px 20px;
        }

        .sidebar a:hover {
            background-color: #343a40;
            color: white;
        }

        .content {
            padding: 30px;
        }

        .ticket-card {
            max-width: 900px;
            margin: auto;
        }

    </style>

</head>

<body>

<div class="container-fluid">

    <div class="row">

        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 px-0 sidebar">

            <h3>
                <i class="bi bi-headset"></i>
                SmartDesk
            </h3>

            <a href="dashboard.jsp">
                <i class="bi bi-speedometer2"></i>
                Dashboard
            </a>

            <a href="#">
                <i class="bi bi-ticket-perforated"></i>
                My Tickets
            </a>

            <a href="create-ticket.jsp">
                <i class="bi bi-plus-circle"></i>
                Create Ticket
            </a>

            <a href="#">
                <i class="bi bi-people"></i>
                Users
            </a>

            <a href="#">
                <i class="bi bi-bar-chart"></i>
                Reports
            </a>

            <a href="#">
                <i class="bi bi-gear"></i>
                Settings
            </a>

            <a href="LogoutServlet">
                <i class="bi bi-box-arrow-right"></i>
                Logout
            </a>

        </div>


        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 content">

            <div class="ticket-card">

                <div class="mb-4">

                    <h2>
                        <i class="bi bi-plus-circle"></i>
                        Create New Ticket
                    </h2>

                    <p class="text-muted">
                        Submit a new IT support request to the service desk.
                    </p>

                </div>


                <!-- Success Message -->

                <%
                    String success = request.getParameter("success");

                    if ("true".equals(success)) {
                %>

                    <div class="alert alert-success">
                        <i class="bi bi-check-circle"></i>
                        Ticket created successfully!
                    </div>

                <%
                    }
                %>


                <!-- Error Message -->

                <%
                    String error = request.getParameter("error");

                    if ("true".equals(error)) {
                %>

                    <div class="alert alert-danger">
                        <i class="bi bi-exclamation-triangle"></i>
                        Failed to create ticket. Please try again.
                    </div>

                <%
                    }
                %>


                <!-- Ticket Form -->

                <div class="card shadow-sm">

                    <div class="card-body p-4">

                        <form action="${pageContext.request.contextPath}/CreateTicketServlet"
                              method="post">


                            <!-- Title -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Ticket Title
                                </label>

                                <input
                                    type="text"
                                    name="title"
                                    class="form-control"
                                    placeholder="Enter ticket title"
                                    required>

                            </div>


                            <!-- Description -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Description
                                </label>

                                <textarea
                                    name="description"
                                    class="form-control"
                                    rows="5"
                                    placeholder="Describe the issue in detail"
                                    required></textarea>

                            </div>


                            <!-- Category -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Category
                                </label>

                                <select
                                    name="category"
                                    class="form-select"
                                    required>

                                    <option value="">
                                        Select Category
                                    </option>

                                    <option value="Hardware">
                                        Hardware
                                    </option>

                                    <option value="Software">
                                        Software
                                    </option>

                                    <option value="Network">
                                        Network
                                    </option>

                                    <option value="Access">
                                        Access / Login
                                    </option>

                                    <option value="Email">
                                        Email
                                    </option>

                                    <option value="Other">
                                        Other
                                    </option>

                                </select>

                            </div>


                            <!-- Priority -->

                            <div class="mb-4">

                                <label class="form-label">
                                    Priority
                                </label>

                                <select
                                    name="priority"
                                    class="form-select"
                                    required>

                                    <option value="">
                                        Select Priority
                                    </option>

                                    <option value="LOW">
                                        Low
                                    </option>

                                    <option value="MEDIUM">
                                        Medium
                                    </option>

                                    <option value="HIGH">
                                        High
                                    </option>

                                    <option value="CRITICAL">
                                        Critical
                                    </option>

                                </select>

                            </div>


                            <!-- Buttons -->

                            <div class="d-flex gap-2">

                                <button
                                    type="submit"
                                    class="btn btn-primary">

                                    <i class="bi bi-send"></i>
                                    Create Ticket

                                </button>

                                <a
                                    href="dashboard.jsp"
                                    class="btn btn-secondary">

                                    <i class="bi bi-arrow-left"></i>
                                    Back to Dashboard

                                </a>

                            </div>

                        </form>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>