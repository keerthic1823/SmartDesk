<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Create Account</title>


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

<nav class="navbar navbar-dark sd-navbar">

    <div class="container-fluid px-4">

        <a
            class="navbar-brand d-flex align-items-center gap-2"
            href="<%= request.getContextPath() %>/login.jsp">

            <div class="brand-logo">

                <i class="bi bi-headset"></i>

            </div>

            <span class="brand-name">

                SmartDesk

            </span>

        </a>

    </div>

</nav>


<!-- =====================================================
     REGISTER
====================================================== -->

<div class="auth-page">


    <div class="auth-wrapper">


        <div class="auth-box">


            <!-- =================================================
                 BRAND PANEL
            ================================================== -->

            <div class="auth-brand-panel">


                <div class="auth-brand-icon">

                    <i class="bi bi-person-plus"></i>

                </div>


                <div class="auth-brand-title">

                    Join SmartDesk

                </div>


                <p class="auth-brand-text">

                    Create your account and start managing
                    your IT support requests through a single,
                    organized workspace.

                </p>


                <div class="auth-feature">

                    <i class="bi bi-shield-check"></i>

                    Secure account access

                </div>


                <div class="auth-feature">

                    <i class="bi bi-ticket-perforated"></i>

                    Create and track tickets

                </div>


                <div class="auth-feature">

                    <i class="bi bi-people"></i>

                    Connect with your support team

                </div>


            </div>


            <!-- =================================================
                 FORM
            ================================================== -->

            <div class="auth-form-panel">


                <div class="auth-form-title">

                    Create Account

                </div>


                <div class="auth-form-subtitle">

                    Enter your details to create your SmartDesk account.

                </div>


                <%
                    String error = request.getParameter("error");
                %>


                <% if ("failed".equals(error)) { %>

                    <div class="alert alert-danger sd-alert">

                        <i class="bi bi-exclamation-circle me-2"></i>

                        Registration failed. Please try again.

                    </div>

                <% } %>


                <form
                    action="<%= request.getContextPath() %>/RegisterServlet"
                    method="post">


                    <!-- NAME -->

                    <div class="mb-3">

                        <label class="form-label">

                            Full Name

                        </label>


                        <input
                            type="text"
                            name="name"
                            class="sd-input"
                            placeholder="Enter your full name"
                            required>

                    </div>


                    <!-- EMAIL -->

                    <div class="mb-3">

                        <label class="form-label">

                            Email Address

                        </label>


                        <input
                            type="email"
                            name="email"
                            class="sd-input"
                            placeholder="Enter your email"
                            required>

                    </div>


                    <!-- PASSWORD -->

                    <div class="mb-3">

                        <label class="form-label">

                            Password

                        </label>


                        <input
                            type="password"
                            name="password"
                            class="sd-input"
                            placeholder="Create a password"
                            minlength="6"
                            required>

                    </div>


                    <!-- DEPARTMENT -->

                    <div class="mb-4">

                        <label class="form-label">

                            Department

                        </label>


                        <select
                            name="department"
                            class="sd-select"
                            required>

                            <option value="">
                                Select Department
                            </option>

                            <option value="IT">
                                IT
                            </option>

                            <option value="HR">
                                HR
                            </option>

                            <option value="FINANCE">
                                Finance
                            </option>

                            <option value="SALES">
                                Sales
                            </option>

                            <option value="OPERATIONS">
                                Operations
                            </option>

                        </select>

                    </div>


                    <!-- ROLE -->

                    <input
                        type="hidden"
                        name="role"
                        value="EMPLOYEE">


                    <!-- SUBMIT -->

                    <button
                        type="submit"
                        class="sd-primary-btn">

                        <i class="bi bi-person-plus me-2"></i>

                        Create Account

                    </button>


                </form>


                <div class="text-center mt-4">

                    <span class="text-muted small">

                        Already have an account?

                    </span>


                    <a
                        href="<%= request.getContextPath() %>/login.jsp"
                        class="fw-bold text-decoration-none ms-1"
                        style="color:#4f46e5;">

                        Sign In

                    </a>

                </div>


            </div>

        </div>

    </div>

</div>


</body>

</html>