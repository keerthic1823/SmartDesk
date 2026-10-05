<%@ page import="com.smartdesk.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Create Ticket</title>


    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/css/style.css">

</head>


<body>


<!-- =====================================================
     STICKY NAVBAR
====================================================== -->

<nav class="navbar navbar-expand-lg sd-navbar">

    <div class="container-fluid px-4">


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


        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#ticketNav">

            <span class="navbar-toggler-icon"></span>

        </button>


        <div
            class="collapse navbar-collapse"
            id="ticketNav">


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
                        class="nav-link nav-link-custom"
                        href="<%= request.getContextPath() %>/MyTicketServlet">

                        <i class="bi bi-ticket-perforated me-1"></i>

                        My Tickets

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link nav-link-custom active"
                        href="<%= request.getContextPath() %>/create-ticket.jsp">

                        <i class="bi bi-plus-circle me-1"></i>

                        Create Ticket

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


            <div class="d-flex align-items-center gap-3">

                <div class="profile-avatar">

                    <%= user.getName()
                           .substring(0,1)
                           .toUpperCase() %>

                </div>

                <span class="text-white d-none d-md-inline">

                    <%= user.getName() %>

                </span>

            </div>

        </div>

    </div>

</nav>


<!-- =====================================================
     CONTENT
====================================================== -->

<div class="container py-5">


    <div class="row justify-content-center">


        <div class="col-lg-9">


            <div class="content-card">


                <div class="d-flex align-items-center gap-3 mb-4">


                    <div
                        class="brand-logo">

                        <i class="bi bi-ticket-perforated"></i>

                    </div>


                    <div>

                        <h3 class="fw-bold mb-1">

                            Create Support Ticket

                        </h3>


                        <p class="text-muted mb-0">

                            Describe your issue and our support
                            team will take care of it.

                        </p>

                    </div>

                </div>


                <% if ("true".equals(success)) { %>

                    <div class="alert alert-success sd-alert">

                        <i class="bi bi-check-circle me-2"></i>

                        Ticket created successfully.

                    </div>

                <% } %>


                <% if ("true".equals(error)) { %>

                    <div class="alert alert-danger sd-alert">

                        <i class="bi bi-exclamation-circle me-2"></i>

                        Unable to create ticket. Please try again.

                    </div>

                <% } %>


                <form
                    action="<%= request.getContextPath() %>/CreateTicketServlet"
                    method="post">


                    <div class="mb-3">

                        <label class="form-label">

                            Ticket Title

                        </label>


                        <input
                            type="text"
                            name="title"
                            class="sd-input"
                            placeholder="Example: Laptop is not connecting to Wi-Fi"
                            required>

                    </div>


                    <div class="mb-3">

                        <label class="form-label">

                            Description

                        </label>


                        <textarea
                            name="description"
                            class="sd-input sd-textarea"
                            placeholder="Describe the issue in detail..."
                            required></textarea>

                    </div>


                    <div class="row g-3">


                        <div class="col-md-6">

                            <label class="form-label">

                                Category

                            </label>


                            <select
                                name="category"
                                class="sd-select"
                                required>

                                <option value="">
                                    Select Category
                                </option>

                                <option value="HARDWARE">
                                    Hardware
                                </option>

                                <option value="SOFTWARE">
                                    Software
                                </option>

                                <option value="NETWORK">
                                    Network
                                </option>

                                <option value="ACCESS">
                                    Access / Account
                                </option>

                                <option value="OTHER">
                                    Other
                                </option>

                            </select>

                        </div>


                        <div class="col-md-6">

                            <label class="form-label">

                                Priority

                            </label>


                            <select
                                name="priority"
                                class="sd-select"
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

                    </div>


                    <div class="d-flex gap-2 mt-4">


                        <button
                            type="submit"
                            class="btn btn-primary px-4 py-2 rounded-3 fw-semibold"
                            style="
                                background:linear-gradient(135deg,#4f46e5,#7c3aed);
                                border:none;
                            ">

                            <i class="bi bi-send me-2"></i>

                            Submit Ticket

                        </button>


                        <a
                            href="<%= request.getContextPath() %>/dashboard.jsp"
                            class="btn btn-light px-4 py-2 rounded-3">

                            Cancel

                        </a>

                    </div>


                </form>

            </div>

        </div>

    </div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>