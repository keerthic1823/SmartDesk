<%@ page import="com.smartdesk.model.User" %>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect(
        request.getContextPath() + "/login.jsp"
    );
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Users - SmartDesk</title>

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

    <a href="users.jsp" class="active">
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

            <h2>Users</h2>

            <p class="text-muted mb-0">
                User account information
            </p>

        </div>

    </div>


    <div class="card shadow-sm">

        <div class="card-body">

            <h5 class="mb-4">
                <i class="bi bi-person-circle me-2"></i>
                Current User
            </h5>

            <div class="table-responsive">

                <table class="table table-hover align-middle">

                    <thead class="table-light">

                        <tr>

                            <th>User ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Department</th>
                            <th>Status</th>

                        </tr>

                    </thead>

                    <tbody>

                        <tr>

                            <td>
                                <%= user.getUserId() %>
                            </td>

                            <td>
                                <strong>
                                    <%= user.getName() %>
                                </strong>
                            </td>

                            <td>
                                <%= user.getEmail() %>
                            </td>

                            <td>
                                <span class="badge bg-primary">
                                    <%= user.getRole() %>
                                </span>
                            </td>

                            <td>
                                <%= user.getDepartment() %>
                            </td>

                            <td>

                                <span class="badge bg-success">
                                    <%= user.getStatus() %>
                                </span>

                            </td>

                        </tr>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

</div>

</div>

</body>
</html>