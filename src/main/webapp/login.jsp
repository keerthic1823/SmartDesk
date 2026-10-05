<%@ page import="com.smartdesk.model.User" %>

<%
    String registered = request.getParameter("registered");
    String logout = request.getParameter("logout");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Sign In</title>


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
     AUTH PAGE
====================================================== -->

<div class="auth-page">


    <div class="auth-wrapper">


        <div class="auth-box">


            <!-- =================================================
                 LEFT BRAND PANEL
            ================================================== -->

            <div class="auth-brand-panel">


                <div class="auth-brand-icon">

                    <i class="bi bi-headset"></i>

                </div>


                <div class="auth-brand-title">

                    Smart IT Service
                    Management

                </div>


                <p class="auth-brand-text">

                    Manage incidents, track support requests
                    and stay connected with your IT support
                    team from one intelligent workspace.

                </p>


                <div class="auth-feature">

                    <i class="bi bi-check-circle-fill"></i>

                    Centralized ticket management

                </div>


                <div class="auth-feature">

                    <i class="bi bi-check-circle-fill"></i>

                    Real-time ticket tracking

                </div>


                <div class="auth-feature">

                    <i class="bi bi-check-circle-fill"></i>

                    Simple and secure support workflow

                </div>


            </div>


            <!-- =================================================
                 LOGIN FORM
            ================================================== -->

            <div class="auth-form-panel">


                <div class="auth-form-title">

                    Welcome back

                </div>


                <div class="auth-form-subtitle">

                    Sign in to continue to your SmartDesk workspace.

                </div>


                <!-- REGISTERED -->

                <% if ("true".equals(registered)) { %>

                    <div class="alert alert-success sd-alert">

                        <i class="bi bi-check-circle me-2"></i>

                        Account created successfully.
                        Please sign in.

                    </div>

                <% } %>


                <!-- LOGOUT -->

                <% if ("true".equals(logout)) { %>

                    <div class="alert alert-info sd-alert">

                        <i class="bi bi-info-circle me-2"></i>

                        You have been logged out successfully.

                    </div>

                <% } %>


                <!-- ERROR -->

                <% if ("invalid".equals(error)) { %>

                    <div class="alert alert-danger sd-alert">

                        <i class="bi bi-exclamation-circle me-2"></i>

                        Invalid email or password.

                    </div>

                <% } %>


                <!-- LOGIN FORM -->

                <form
                    action="<%= request.getContextPath() %>/LoginServlet"
                    method="post">


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


                    <div class="mb-4">

                        <label class="form-label">

                            Password

                        </label>


                        <input
                            type="password"
                            name="password"
                            class="sd-input"
                            placeholder="Enter your password"
                            required>

                    </div>


                    <button
                        type="submit"
                        class="sd-primary-btn">

                        <i class="bi bi-box-arrow-in-right me-2"></i>

                        Sign In

                    </button>


                </form>


                <div class="text-center mt-4">

                    <span class="text-muted small">

                        Don't have an account?

                    </span>


                    <a
                        href="<%= request.getContextPath() %>/register.jsp"
                        class="fw-bold text-decoration-none ms-1"
                        style="color:#4f46e5;">

                        Create Account

                    </a>

                </div>


            </div>

        </div>

    </div>

</div>


</body>

</html>