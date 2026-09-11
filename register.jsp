<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>SmartDesk - Create Account</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <style>

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #1e3a8a);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
        }

        .register-card {
            width: 450px;
            background: white;
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
        }

        .logo {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            color: #1e3a8a;
        }

        .subtitle {
            text-align: center;
            color: #6b7280;
            margin-bottom: 25px;
        }

        .form-control,
        .form-select {
            border-radius: 10px;
            padding: 11px;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            font-weight: bold;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

    </style>

</head>

<body>

<div class="register-card">

    <div class="logo">
        SmartDesk
    </div>

    <p class="subtitle">
        Create your SmartDesk account
    </p>


    <form action="${pageContext.request.contextPath}/RegisterServlet"
          method="post">


        <!-- Name -->

        <div class="mb-3">

            <label class="form-label">
                Full Name
            </label>

            <input type="text"
                   name="name"
                   class="form-control"
                   placeholder="Enter your full name"
                   required>

        </div>


        <!-- Email -->

        <div class="mb-3">

            <label class="form-label">
                Email Address
            </label>

            <input type="email"
                   name="email"
                   class="form-control"
                   placeholder="Enter your email"
                   required>

        </div>


        <!-- Password -->

        <div class="mb-3">

            <label class="form-label">
                Password
            </label>

            <input type="password"
                   name="password"
                   class="form-control"
                   placeholder="Create a password"
                   required>

        </div>


        <!-- Role -->

        <div class="mb-3">

            <label class="form-label">
                Role
            </label>

            <select name="role"
                    class="form-select"
                    required>

                <option value="">
                    Select Role
                </option>

                <option value="EMPLOYEE">
                    Employee
                </option>

                <option value="ENGINEER">
                    Engineer
                </option>

                <option value="ADMIN">
                    Admin
                </option>

            </select>

        </div>


        <!-- Department -->

        <div class="mb-4">

            <label class="form-label">
                Department
            </label>

            <select name="department"
                    class="form-select"
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

            </select>

        </div>


        <!-- Submit -->

        <button type="submit"
                class="btn btn-primary btn-register">

            Create Account

        </button>


    </form>


    <div class="login-link">

        Already have an account?

        <a href="login.jsp">
            Sign In
        </a>

    </div>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>