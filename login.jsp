<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Login</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {
            min-height: 100vh;
            margin: 0;
            background: #f4f7fb;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            width: 100%;
            max-width: 450px;
            background: white;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 15px 45px rgba(15, 23, 42, 0.10);
        }

        .logo {
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            color: #1e3a8a;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #64748b;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 600;
            color: #334155;
        }

        .input-group-text {
            background: #f8fafc;
            color: #64748b;
        }

        .form-control {
            height: 48px;
        }

        .login-btn {
            width: 100%;
            height: 50px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            font-weight: 600;
            font-size: 16px;
        }

        .login-btn:hover {
            background: #1d4ed8;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #64748b;
        }

        .register-link a {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="login-wrapper">

    <div class="login-card">

        <div class="logo">
            <i class="bi bi-headset"></i>
            SmartDesk
        </div>

        <p class="subtitle">
            IT Service Desk & Incident Management
        </p>


        <!-- Registration Success Message -->

        <%
            String registered = request.getParameter("registered");

            if ("true".equals(registered)) {
        %>
<%
String logout = request.getParameter("logout");
String error = request.getParameter("error");
%>
            <div class="alert alert-success alert-dismissible fade show">

                <i class="bi bi-check-circle-fill me-2"></i>

                <strong>Registration successful!</strong>
                You can now sign in to SmartDesk.

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        <%
            }
        %>

<!-- Logout Success Message -->

<%
    String logout = request.getParameter("logout");

    if ("true".equals(logout)) {
%>

    <div class="alert alert-success alert-dismissible fade show">

        <i class="bi bi-check-circle-fill me-2"></i>

        <strong>Logout successful!</strong>
        You have been logged out of SmartDesk.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>

    </div>

<%
    }
%>
        <!-- Login Form -->

        <form action="${pageContext.request.contextPath}/LoginServlet"
      method="post">

            <div class="mb-3">

                <label class="form-label">
                    Email Address
                </label>

                <div class="input-group">

                    <span class="input-group-text">
                        <i class="bi bi-envelope"></i>
                    </span>

                    <input
                        type="email"
                        name="email"
                        class="form-control"
                        placeholder="Enter your email"
                        required>

                </div>

            </div>


            <div class="mb-4">

                <label class="form-label">
                    Password
                </label>

                <div class="input-group">

                    <span class="input-group-text">
                        <i class="bi bi-lock"></i>
                    </span>

                    <input
                        type="password"
                        name="password"
                        class="form-control"
                        placeholder="Enter your password"
                        required>

                </div>

            </div>


            <button type="submit"
                    class="login-btn">

                <i class="bi bi-box-arrow-in-right me-2"></i>

                Sign In

            </button>

        </form>


        <div class="register-link">

            Don't have an account?

            <a href="register.jsp">
                Create Account
            </a>

        </div>

    </div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>