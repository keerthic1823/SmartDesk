<%@ page import="com.smartdesk.model.User" %>
<%@ page import="com.smartdesk.service.TicketService" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
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

    int unresolvedTickets =
            openTickets + inProgressTickets;

    int openPercentage =
            totalTickets > 0
            ? (openTickets * 100 / totalTickets)
            : 0;

    int progressPercentage =
            totalTickets > 0
            ? (inProgressTickets * 100 / totalTickets)
            : 0;

    int resolvedPercentage =
            totalTickets > 0
            ? (resolvedTickets * 100 / totalTickets)
            : 0;

    int resolutionRate =
            totalTickets > 0
            ? (resolvedTickets * 100 / totalTickets)
            : 0;

    String userName = user.getName();

    String firstLetter = "U";

    if (userName != null && !userName.trim().isEmpty()) {
        firstLetter =
                userName.substring(0, 1).toUpperCase();
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SmartDesk | Dashboard</title>


    <!-- =====================================================
         BOOTSTRAP
    ====================================================== -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- =====================================================
         BOOTSTRAP ICONS
    ====================================================== -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <!-- =====================================================
         GOOGLE FONT
    ====================================================== -->

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <!-- =====================================================
         CHART JS
    ====================================================== -->

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <!-- =====================================================
         EXISTING SMARTDESK CSS
    ====================================================== -->

    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/css/style.css">


    <!-- =====================================================
         DASHBOARD DESIGN
    ====================================================== -->

    <style>

        * {
            box-sizing: border-box;
        }


        /* =====================================================
           BODY
        ====================================================== */

        body {

            margin: 0;

            font-family: 'Inter', sans-serif;

            color: #111827;

            min-height: 100vh;

            background:

                radial-gradient(
                    circle at 5% 5%,
                    rgba(99, 102, 241, 0.10),
                    transparent 25%
                ),

                radial-gradient(
                    circle at 95% 15%,
                    rgba(124, 58, 237, 0.08),
                    transparent 28%
                ),

                linear-gradient(
                    135deg,
                    #f8fafc 0%,
                    #eef2ff 50%,
                    #f8fafc 100%
                );

        }


        /* =====================================================
           STICKY NAVBAR
        ====================================================== */

        .sd-navbar {

            position: sticky;

            top: 0;

            z-index: 1050;

            min-height: 72px;

            background:
                rgba(15, 23, 42, 0.96) !important;

            backdrop-filter:
                blur(16px);

            -webkit-backdrop-filter:
                blur(16px);

            box-shadow:
                0 8px 30px
                rgba(15, 23, 42, 0.18);

            border-bottom:
                1px solid
                rgba(255,255,255,.06);

        }


        /* =====================================================
           BRAND
        ====================================================== */

        .brand-logo {

            width: 42px;

            height: 42px;

            border-radius: 13px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #7c3aed
                );

            color: white;

            font-size: 21px;

            box-shadow:
                0 8px 20px
                rgba(99,102,241,.35);

        }


        .brand-name {

            color: white;

            font-size: 21px;

            font-weight: 800;

            letter-spacing: -.5px;

        }


        /* =====================================================
           NAV LINKS
        ====================================================== */

        .nav-link-custom {

            color: #cbd5e1 !important;

            font-weight: 500;

            padding:
                10px 15px !important;

            border-radius: 10px;

            margin-right: 3px;

            transition: .25s ease;

        }


        .nav-link-custom:hover {

            color: white !important;

            background:
                rgba(255,255,255,.08);

            transform:
                translateY(-1px);

        }


        .nav-link-custom.active {

            color: white !important;

            background:
                rgba(255,255,255,.10);

            box-shadow:
                inset 0 0 0 1px
                rgba(255,255,255,.04);

        }


        /* =====================================================
           SEARCH
        ====================================================== */

        .nav-search {

            width: 235px;

            height: 44px;

            border-radius: 12px;

            border:
                1px solid
                rgba(255,255,255,.10);

            background:
                rgba(255,255,255,.08);

            color: white;

            padding:
                0 15px;

            outline: none;

            transition: .25s ease;

        }


        .nav-search::placeholder {

            color:
                #94a3b8;

        }


        .nav-search:focus {

            border-color:
                rgba(129,140,248,.7);

            background:
                rgba(255,255,255,.12);

            box-shadow:
                0 0 0 3px
                rgba(99,102,241,.15);

        }


        /* =====================================================
           PROFILE
        ====================================================== */

        .profile-button {

            border: none;

            background: transparent;

            color: white;

            display: flex;

            align-items: center;

            gap: 9px;

            padding: 5px 8px;

            border-radius: 12px;

        }


        .profile-button:hover {

            background:
                rgba(255,255,255,.08);

        }


        .profile-avatar {

            width: 38px;

            height: 38px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #8b5cf6,
                    #6366f1
                );

            color: white;

            font-weight: 700;

        }


        /* =====================================================
           MAIN CONTAINER
        ====================================================== */

        .dashboard-container {

            max-width: 1450px;

            margin: auto;

            padding:
                32px 28px 50px;

        }


        /* =====================================================
           HERO
        ====================================================== */

        .hero-section {

            position: relative;

            overflow: hidden;

            min-height: 330px;

            padding:
                44px 42px;

            border-radius: 26px;

            color: white;

            background:

                radial-gradient(
                    circle at 90% 15%,
                    rgba(139,92,246,.35),
                    transparent 24%
                ),

                radial-gradient(
                    circle at 80% 90%,
                    rgba(99,102,241,.30),
                    transparent 28%
                ),

                linear-gradient(
                    135deg,
                    #111827,
                    #1e1b4b 50%,
                    #4c1d95
                );

            box-shadow:
                0 25px 60px
                rgba(49,46,129,.20);

        }


        .hero-section::before {

            content: "";

            position: absolute;

            width: 240px;

            height: 240px;

            border-radius: 50%;

            border:
                1px solid
                rgba(255,255,255,.12);

            right: 70px;

            top: -120px;

        }


        .hero-section::after {

            content: "";

            position: absolute;

            width: 300px;

            height: 300px;

            border-radius: 50%;

            border:
                1px solid
                rgba(255,255,255,.08);

            right: -50px;

            bottom: -190px;

        }


        .hero-content {

            position: relative;

            z-index: 2;

            max-width: 780px;

        }


        .hero-badge {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding:
                9px 15px;

            border-radius: 30px;

            background:
                rgba(255,255,255,.10);

            border:
                1px solid
                rgba(255,255,255,.15);

            color: #f8fafc;

            font-size: 12px;

            font-weight: 700;

            letter-spacing: .5px;

            text-transform: uppercase;

        }


        .hero-title {

            margin-top: 22px;

            margin-bottom: 12px;

            font-size: clamp(30px, 4vw, 46px);

            line-height: 1.1;

            font-weight: 800;

            letter-spacing: -1.5px;

        }


        .hero-description {

            color:
                #cbd5e1;

            font-size: 15px;

            line-height: 1.8;

            max-width: 700px;

        }


        .hero-actions {

            display: flex;

            gap: 12px;

            margin-top: 28px;

        }


        .btn-hero-primary {

            background: white;

            color: #312e81;

            border: none;

            border-radius: 12px;

            padding:
                13px 20px;

            font-weight: 700;

            transition: .25s ease;

        }


        .btn-hero-primary:hover {

            background: #f8fafc;

            color: #312e81;

            transform:
                translateY(-2px);

            box-shadow:
                0 10px 25px
                rgba(0,0,0,.15);

        }


        .btn-hero-secondary {

            color: white;

            background:
                rgba(255,255,255,.08);

            border:
                1px solid
                rgba(255,255,255,.18);

            border-radius: 12px;

            padding:
                13px 20px;

            font-weight: 600;

            transition: .25s ease;

        }


        .btn-hero-secondary:hover {

            color: white;

            background:
                rgba(255,255,255,.14);

            transform:
                translateY(-2px);

        }


        /* =====================================================
           SECTION HEADERS
        ====================================================== */

        .section-heading {

            margin-top: 36px;

            margin-bottom: 18px;

        }


        .section-heading h4 {

            font-weight: 800;

            margin-bottom: 4px;

        }


        .section-heading p {

            color: #64748b;

            margin: 0;

            font-size: 14px;

        }


        /* =====================================================
           STAT CARDS
        ====================================================== */

        .stat-card {

            position: relative;

            background: rgba(255,255,255,.92);

            border:
                1px solid
                #e2e8f0;

            border-radius: 20px;

            padding: 24px;

            height: 100%;

            overflow: hidden;

            box-shadow:
                0 8px 30px
                rgba(15,23,42,.05);

            transition:
                transform .25s ease,
                box-shadow .25s ease,
                border-color .25s ease;

        }


        .stat-card:hover {

            transform:
                translateY(-6px);

            border-color:
                #c7d2fe;

            box-shadow:
                0 18px 40px
                rgba(15,23,42,.10);

        }


        .stat-card::after {

            content: "";

            position: absolute;

            width: 90px;

            height: 90px;

            border-radius: 50%;

            right: -35px;

            top: -35px;

            background:
                rgba(99,102,241,.05);

        }


        .stat-icon {

            width: 48px;

            height: 48px;

            border-radius: 14px;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 21px;

        }


        .icon-blue {

            background: #eff6ff;

            color: #2563eb;

        }


        .icon-orange {

            background: #fff7ed;

            color: #f97316;

        }


        .icon-purple {

            background: #f5f3ff;

            color: #7c3aed;

        }


        .icon-green {

            background: #ecfdf5;

            color: #16a34a;

        }


        .stat-number {

            font-size: 31px;

            font-weight: 800;

            color: #111827;

            margin-top: 22px;

        }


        .stat-title {

            color: #475569;

            font-weight: 600;

            font-size: 13px;

            margin-top: 2px;

        }


        .stat-subtitle {

            color: #94a3b8;

            font-size: 12px;

            margin-top: 7px;

        }


        .stat-more {

            position: absolute;

            right: 20px;

            top: 22px;

            color: #64748b;

            border: none;

            background: transparent;

        }


        /* =====================================================
           ANALYTICS CARD
        ====================================================== */

        .content-card {

            background:
                rgba(255,255,255,.94);

            border:
                1px solid
                #e2e8f0;

            border-radius: 22px;

            padding: 26px;

            height: 100%;

            box-shadow:
                0 8px 30px
                rgba(15,23,42,.045);

        }


        .card-title {

            font-size: 17px;

            font-weight: 800;

            margin-bottom: 4px;

        }


        .card-description {

            color: #94a3b8;

            font-size: 12px;

        }


        /* =====================================================
           PROGRESS
        ====================================================== */

        .progress-row {

            margin-top: 23px;

        }


        .progress-header {

            display: flex;

            justify-content: space-between;

            margin-bottom: 8px;

            font-size: 13px;

            font-weight: 600;

        }


        .custom-progress {

            height: 10px;

            border-radius: 20px;

            background: #e5e7eb;

            overflow: hidden;

        }


        .custom-progress .progress-bar {

            border-radius: 20px;

        }


        /* =====================================================
           CHART
        ====================================================== */

        .chart-container {

            position: relative;

            height: 280px;

            display: flex;

            align-items: center;

            justify-content: center;

        }


        /* =====================================================
           QUICK ACTIONS
        ====================================================== */

        .quick-action {

            display: flex;

            align-items: center;

            gap: 14px;

            text-decoration: none;

            color: #111827;

            background: white;

            border:
                1px solid
                #e2e8f0;

            padding: 17px;

            border-radius: 15px;

            transition: .25s ease;

        }


        .quick-action:hover {

            color: #111827;

            transform:
                translateX(4px);

            border-color:
                #c7d2fe;

            box-shadow:
                0 10px 25px
                rgba(15,23,42,.07);

        }


        .quick-icon {

            width: 44px;

            height: 44px;

            border-radius: 12px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                #eef2ff;

            color:
                #4f46e5;

            font-size: 19px;

        }


        .quick-title {

            font-size: 13px;

            font-weight: 700;

        }


        .quick-description {

            color: #94a3b8;

            font-size: 11px;

            margin-top: 3px;

        }


        /* =====================================================
           ACTIVITY
        ====================================================== */

        .activity-item {

            display: flex;

            gap: 13px;

            padding: 15px 0;

            border-bottom:
                1px solid
                #f1f5f9;

        }


        .activity-item:last-child {

            border-bottom: none;

        }


        .activity-icon {

            width: 36px;

            height: 36px;

            flex-shrink: 0;

            border-radius: 10px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #f1f5f9;

            color: #475569;

        }


        .activity-title {

            font-size: 13px;

            font-weight: 600;

        }


        .activity-time {

            font-size: 11px;

            color: #94a3b8;

            margin-top: 3px;

        }


        /* =====================================================
           SUPPORT CARD
        ====================================================== */

        .support-card {

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #f5f3ff
                );

            border:
                1px solid
                #e0e7ff;

            border-radius: 20px;

            padding: 24px;

        }


        .support-icon {

            width: 48px;

            height: 48px;

            border-radius: 14px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                #4f46e5;

            color: white;

            font-size: 20px;

        }


        /* =====================================================
           PROFILE CARD
        ====================================================== */

        .profile-card {

            background: white;

            border:
                1px solid
                #e2e8f0;

            border-radius: 20px;

            padding: 25px;

            box-shadow:
                0 8px 30px
                rgba(15,23,42,.045);

        }


        .profile-large-avatar {

            width: 68px;

            height: 68px;

            border-radius: 20px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #7c3aed
                );

            color: white;

            font-size: 25px;

            font-weight: 800;

            box-shadow:
                0 10px 25px
                rgba(99,102,241,.25);

        }


        .profile-name {

            font-weight: 800;

            font-size: 18px;

        }


        .profile-role {

            color: #64748b;

            font-size: 12px;

        }


        .profile-detail {

            display: flex;

            justify-content: space-between;

            padding:
                12px 0;

            border-bottom:
                1px solid
                #f1f5f9;

            font-size: 13px;

        }


        .profile-detail:last-child {

            border-bottom: none;

        }


        /* =====================================================
           BADGES
        ====================================================== */

        .status-badge {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            padding:
                6px 10px;

            border-radius: 20px;

            font-size: 11px;

            font-weight: 700;

        }


        .status-active {

            background: #ecfdf5;

            color: #15803d;

        }


        .status-dot {

            width: 7px;

            height: 7px;

            border-radius: 50%;

            background: #22c55e;

        }


        /* =====================================================
           FOOTER
        ====================================================== */

        .dashboard-footer {

            text-align: center;

            color: #94a3b8;

            font-size: 11px;

            margin-top: 45px;

        }


        /* =====================================================
           ANIMATION
        ====================================================== */

        .fade-up {

            animation:
                fadeUp .6s ease both;

        }


        @keyframes fadeUp {

            from {

                opacity: 0;

                transform:
                    translateY(15px);

            }

            to {

                opacity: 1;

                transform:
                    translateY(0);

            }

        }


        .delay-1 {

            animation-delay: .08s;

        }


        .delay-2 {

            animation-delay: .16s;

        }


        .delay-3 {

            animation-delay: .24s;

        }


        .delay-4 {

            animation-delay: .32s;

        }


        /* =====================================================
           MOBILE
        ====================================================== */

        @media (max-width: 991px) {

            .nav-search {

                display: none;

            }

            .navbar-nav {

                margin-left: 0 !important;

                margin-top: 12px;

            }

            .hero-section {

                padding: 34px 28px;

            }

        }


        @media (max-width: 576px) {

            .dashboard-container {

                padding:
                    20px 14px 35px;

            }

            .hero-section {

                min-height: auto;

                border-radius: 20px;

                padding: 30px 22px;

            }

            .hero-title {

                font-size: 29px;

            }

            .hero-actions {

                flex-direction: column;

            }

            .btn-hero-primary,
            .btn-hero-secondary {

                width: 100%;

                text-align: center;

            }

            .stat-card {

                padding: 20px;

            }

            .content-card {

                padding: 20px;

            }

        }

    </style>

</head>


<body>


<!-- =========================================================
     NAVBAR
========================================================= -->

<nav class="navbar navbar-expand-lg sd-navbar">

    <div class="container-fluid px-4">


        <!-- BRAND -->

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


        <!-- MOBILE BUTTON -->

        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#mainNavbar">

            <span class="navbar-toggler-icon"></span>

        </button>


        <!-- NAV CONTENT -->

        <div
            class="collapse navbar-collapse"
            id="mainNavbar">


            <!-- LINKS -->

            <ul class="navbar-nav ms-4 me-auto">


                <li class="nav-item">

                    <a
                        class="nav-link nav-link-custom active"
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
                        class="nav-link nav-link-custom"
                        href="<%= request.getContextPath() %>/reports.jsp">

                        <i class="bi bi-bar-chart me-1"></i>

                        Reports

                    </a>

                </li>

            </ul>


            <!-- RIGHT SIDE -->

            <div class="d-flex align-items-center gap-2">


                <!-- SEARCH -->

                <input
                    type="text"
                    class="nav-search"
                    placeholder="Search tickets...">


                <!-- NOTIFICATION -->

                <button
                    class="btn text-white"
                    type="button"
                    data-bs-toggle="modal"
                    data-bs-target="#notificationModal">

                    <i class="bi bi-bell fs-5"></i>

                </button>


                <!-- PROFILE -->

                <div class="dropdown">

                    <button
                        class="profile-button dropdown-toggle"
                        type="button"
                        data-bs-toggle="dropdown"
                        aria-expanded="false">

                        <div class="profile-avatar">

                            <%= firstLetter %>

                        </div>

                        <span class="d-none d-md-inline">

                            <%= userName %>

                        </span>

                    </button>


                    <ul class="dropdown-menu dropdown-menu-end shadow border-0">

                        <li>

                            <h6 class="dropdown-header">

                                <%= userName %>

                            </h6>

                        </li>

                        <li>

                            <span class="dropdown-item-text small text-muted">

                                <%= user.getEmail() %>

                            </span>

                        </li>

                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <li>

                            <a
                                class="dropdown-item"
                                href="<%= request.getContextPath() %>/users.jsp">

                                <i class="bi bi-person me-2"></i>

                                My Profile

                            </a>

                        </li>

                        <li>

                            <a
                                class="dropdown-item"
                                href="<%= request.getContextPath() %>/settings.jsp">

                                <i class="bi bi-gear me-2"></i>

                                Settings

                            </a>

                        </li>

                        <li>

                            <a
                                class="dropdown-item text-danger"
                                href="<%= request.getContextPath() %>/LogoutServlet">

                                <i class="bi bi-box-arrow-right me-2"></i>

                                Logout

                            </a>

                        </li>

                    </ul>

                </div>

            </div>

        </div>

    </div>

</nav>


<!-- =========================================================
     MAIN DASHBOARD
========================================================= -->

<main class="dashboard-container">


    <!-- =====================================================
         HERO
    ====================================================== -->

    <section class="hero-section fade-up">


        <div class="hero-content">


            <div class="hero-badge">

                <i class="bi bi-stars"></i>

                Smart IT Service Management

            </div>


            <h1 class="hero-title">

                Welcome back, <%= userName %>

            </h1>


            <p class="hero-description">

                Manage your IT support requests, track incidents,
                monitor ticket progress and stay connected with
                your support team from one simple workspace.

            </p>


            <div class="hero-actions">


                <a
                    href="<%= request.getContextPath() %>/create-ticket.jsp"
                    class="btn btn-hero-primary">

                    <i class="bi bi-plus-lg me-2"></i>

                    Create New Ticket

                </a>


                <a
                    href="<%= request.getContextPath() %>/MyTicketServlet"
                    class="btn btn-hero-secondary">

                    <i class="bi bi-ticket-perforated me-2"></i>

                    View My Tickets

                </a>

            </div>

        </div>

    </section>


    <!-- =====================================================
         TICKET OVERVIEW
    ====================================================== -->

    <div class="section-heading">

        <h4>
            Ticket Overview
        </h4>

        <p>
            A quick summary of your current support activity
        </p>

    </div>


    <div class="row g-4">


        <!-- TOTAL -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="stat-card fade-up delay-1">


                <div class="stat-icon icon-blue">

                    <i class="bi bi-ticket-perforated"></i>

                </div>


                <button class="stat-more">

                    <i class="bi bi-three-dots"></i>

                </button>


                <div class="stat-number">

                    <%= totalTickets %>

                </div>


                <div class="stat-title">

                    Total Tickets

                </div>


                <div class="stat-subtitle">

                    All requests created by you

                </div>

            </div>

        </div>


        <!-- OPEN -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="stat-card fade-up delay-2">


                <div class="stat-icon icon-orange">

                    <i class="bi bi-envelope-open"></i>

                </div>


                <button class="stat-more">

                    <i class="bi bi-three-dots"></i>

                </button>


                <div class="stat-number">

                    <%= openTickets %>

                </div>


                <div class="stat-title">

                    Open Tickets

                </div>


                <div class="stat-subtitle">

                    Waiting for support action

                </div>

            </div>

        </div>


        <!-- IN PROGRESS -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="stat-card fade-up delay-3">


                <div class="stat-icon icon-purple">

                    <i class="bi bi-arrow-repeat"></i>

                </div>


                <button class="stat-more">

                    <i class="bi bi-three-dots"></i>

                </button>


                <div class="stat-number">

                    <%= inProgressTickets %>

                </div>


                <div class="stat-title">

                    In Progress

                </div>


                <div class="stat-subtitle">

                    Currently being handled

                </div>

            </div>

        </div>


        <!-- RESOLVED -->

        <div class="col-12 col-sm-6 col-xl-3">

            <div class="stat-card fade-up delay-4">


                <div class="stat-icon icon-green">

                    <i class="bi bi-check2-circle"></i>

                </div>


                <button class="stat-more">

                    <i class="bi bi-three-dots"></i>

                </button>


                <div class="stat-number">

                    <%= resolvedTickets %>

                </div>


                <div class="stat-title">

                    Resolved Tickets

                </div>


                <div class="stat-subtitle">

                    Successfully completed

                </div>

            </div>

        </div>

    </div>


    <!-- =====================================================
         ANALYTICS
    ====================================================== -->

    <div class="section-heading">

        <h4>
            Support Analytics
        </h4>

        <p>
            Understand your current ticket workload
        </p>

    </div>


    <div class="row g-4">


        <!-- PROGRESS -->

        <div class="col-lg-7">

            <div class="content-card">


                <div class="card-title">

                    Ticket Status

                </div>


                <div class="card-description">

                    Current distribution of your support requests

                </div>


                <!-- OPEN -->

                <div class="progress-row">

                    <div class="progress-header">

                        <span>

                            <i class="bi bi-circle-fill text-danger me-2"></i>

                            Open

                        </span>

                        <span>

                            <%= openTickets %>

                        </span>

                    </div>


                    <div class="progress custom-progress">

                        <div
                            class="progress-bar bg-danger"
                            style="width:<%= openPercentage %>%">

                        </div>

                    </div>

                </div>


                <!-- IN PROGRESS -->

                <div class="progress-row">

                    <div class="progress-header">

                        <span>

                            <i class="bi bi-circle-fill text-warning me-2"></i>

                            In Progress

                        </span>

                        <span>

                            <%= inProgressTickets %>

                        </span>

                    </div>


                    <div class="progress custom-progress">

                        <div
                            class="progress-bar bg-warning"
                            style="width:<%= progressPercentage %>%">

                        </div>

                    </div>

                </div>


                <!-- RESOLVED -->

                <div class="progress-row">

                    <div class="progress-header">

                        <span>

                            <i class="bi bi-circle-fill text-success me-2"></i>

                            Resolved

                        </span>

                        <span>

                            <%= resolvedTickets %>

                        </span>

                    </div>


                    <div class="progress custom-progress">

                        <div
                            class="progress-bar bg-success"
                            style="width:<%= resolvedPercentage %>%">

                        </div>

                    </div>

                </div>


                <!-- SUMMARY -->

                <div class="row g-3 mt-4">


                    <div class="col-6">

                        <div class="p-3 rounded-4 bg-light">

                            <small class="text-muted">
                                Active workload
                            </small>

                            <div class="fw-bold fs-4 mt-1">

                                <%= unresolvedTickets %>

                            </div>

                        </div>

                    </div>


                    <div class="col-6">

                        <div class="p-3 rounded-4 bg-light">

                            <small class="text-muted">
                                Resolution rate
                            </small>

                            <div class="fw-bold fs-4 mt-1">

                                <%= resolutionRate %>%

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- CHART -->

        <div class="col-lg-5">

            <div class="content-card">


                <div class="card-title">

                    Ticket Distribution

                </div>


                <div class="card-description">

                    Visual representation of ticket status

                </div>


                <div class="chart-container">

                    <canvas id="ticketChart"></canvas>

                </div>

            </div>

        </div>

    </div>


    <!-- =====================================================
         QUICK ACTIONS + ACTIVITY
    ====================================================== -->

    <div class="row g-4 mt-1">


        <!-- QUICK ACTIONS -->

        <div class="col-lg-7">

            <div class="content-card">


                <div class="card-title">

                    Quick Actions

                </div>


                <div class="card-description mb-3">

                    Frequently used SmartDesk features

                </div>


                <div class="row g-3">


                    <!-- CREATE -->

                    <div class="col-md-6">

                        <a
                            href="<%= request.getContextPath() %>/create-ticket.jsp"
                            class="quick-action">

                            <div class="quick-icon">

                                <i class="bi bi-plus-circle"></i>

                            </div>


                            <div>

                                <div class="quick-title">

                                    Create Ticket

                                </div>

                                <div class="quick-description">

                                    Report a new IT issue

                                </div>

                            </div>


                            <i class="bi bi-chevron-right ms-auto text-muted"></i>

                        </a>

                    </div>


                    <!-- MY TICKETS -->

                    <div class="col-md-6">

                        <a
                            href="<%= request.getContextPath() %>/MyTicketServlet"
                            class="quick-action">

                            <div class="quick-icon">

                                <i class="bi bi-ticket-detailed"></i>

                            </div>


                            <div>

                                <div class="quick-title">

                                    My Tickets

                                </div>

                                <div class="quick-description">

                                    View your support requests

                                </div>

                            </div>


                            <i class="bi bi-chevron-right ms-auto text-muted"></i>

                        </a>

                    </div>


                    <!-- REPORTS -->

                    <div class="col-md-6">

                        <a
                            href="<%= request.getContextPath() %>/reports.jsp"
                            class="quick-action">

                            <div class="quick-icon">

                                <i class="bi bi-bar-chart-line"></i>

                            </div>


                            <div>

                                <div class="quick-title">

                                    Reports

                                </div>

                                <div class="quick-description">

                                    View ticket analytics

                                </div>

                            </div>


                            <i class="bi bi-chevron-right ms-auto text-muted"></i>

                        </a>

                    </div>


                    <!-- PROFILE -->

                    <div class="col-md-6">

                        <a
                            href="<%= request.getContextPath() %>/users.jsp"
                            class="quick-action">

                            <div class="quick-icon">

                                <i class="bi bi-person"></i>

                            </div>


                            <div>

                                <div class="quick-title">

                                    My Profile

                                </div>

                                <div class="quick-description">

                                    View account information

                                </div>

                            </div>


                            <i class="bi bi-chevron-right ms-auto text-muted"></i>

                        </a>

                    </div>

                </div>

            </div>

        </div>


        <!-- RECENT ACTIVITY -->

        <div class="col-lg-5">

            <div class="content-card">


                <div class="card-title">

                    Recent Activity

                </div>


                <div class="card-description">

                    SmartDesk workspace activity

                </div>


                <div class="activity-item">

                    <div class="activity-icon">

                        <i class="bi bi-ticket"></i>

                    </div>

                    <div>

                        <div class="activity-title">

                            Ticket workspace is ready

                        </div>

                        <div class="activity-time">

                            SmartDesk service desk

                        </div>

                    </div>

                </div>


                <div class="activity-item">

                    <div class="activity-icon">

                        <i class="bi bi-shield-check"></i>

                    </div>

                    <div>

                        <div class="activity-title">

                            Account authenticated

                        </div>

                        <div class="activity-time">

                            Current session

                        </div>

                    </div>

                </div>


                <div class="activity-item">

                    <div class="activity-icon">

                        <i class="bi bi-graph-up"></i>

                    </div>

                    <div>

                        <div class="activity-title">

                            Ticket analytics updated

                        </div>

                        <div class="activity-time">

                            Live dashboard statistics

                        </div>

                    </div>

                </div>


            </div>

        </div>

    </div>


    <!-- =====================================================
         SUPPORT + PROFILE
    ====================================================== -->

    <div class="row g-4 mt-1">


        <!-- SUPPORT -->

        <div class="col-lg-7">

            <div class="support-card">


                <div class="d-flex align-items-start gap-3">


                    <div class="support-icon">

                        <i class="bi bi-headset"></i>

                    </div>


                    <div>

                        <h5 class="fw-bold mb-1">

                            Need IT Support?

                        </h5>


                        <p class="text-muted small mb-3">

                            Create a support ticket and provide
                            the details of your issue. Your support
                            team can then track and resolve it.

                        </p>


                        <a
                            href="<%= request.getContextPath() %>/create-ticket.jsp"
                            class="btn btn-dark btn-sm rounded-3 px-3">

                            <i class="bi bi-plus-lg me-1"></i>

                            Raise a Ticket

                        </a>

                    </div>

                </div>

            </div>

        </div>


        <!-- PROFILE -->

        <div class="col-lg-5">

            <div class="profile-card">


                <div class="d-flex align-items-center gap-3 mb-4">


                    <div class="profile-large-avatar">

                        <%= firstLetter %>

                    </div>


                    <div>

                        <div class="profile-name">

                            <%= userName %>

                        </div>


                        <div class="profile-role">

                            <%= user.getRole() %>

                            &nbsp; • &nbsp;

                            <%= user.getDepartment() %>

                        </div>

                    </div>

                </div>


                <div class="profile-detail">

                    <span class="text-muted">

                        Email

                    </span>

                    <strong class="text-end">

                        <%= user.getEmail() %>

                    </strong>

                </div>


                <div class="profile-detail">

                    <span class="text-muted">

                        Department

                    </span>

                    <strong>

                        <%= user.getDepartment() %>

                    </strong>

                </div>


                <div class="profile-detail">

                    <span class="text-muted">

                        Account Status

                    </span>

                    <span class="status-badge status-active">

                        <span class="status-dot"></span>

                        <%= user.getStatus() %>

                    </span>

                </div>


            </div>

        </div>

    </div>


    <!-- =====================================================
         FOOTER
    ====================================================== -->

    <div class="dashboard-footer">

        SmartDesk IT Service Desk & Incident Management

        <br>

        <span>
            Secure workspace • 2026
        </span>

    </div>

</main>


<!-- =========================================================
     NOTIFICATION MODAL
========================================================= -->

<div
    class="modal fade"
    id="notificationModal"
    tabindex="-1"
    aria-hidden="true">


    <div class="modal-dialog modal-dialog-centered">


        <div class="modal-content border-0 rounded-4 shadow">


            <div class="modal-header border-0">

                <h5 class="modal-title fw-bold">

                    <i class="bi bi-bell me-2 text-primary"></i>

                    Notifications

                </h5>


                <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="modal">
                </button>

            </div>


            <div class="modal-body pt-0">


                <div class="p-3 rounded-4 bg-light mb-3">

                    <div class="d-flex gap-3">

                        <i class="bi bi-info-circle text-primary fs-5"></i>

                        <div>

                            <strong class="small">

                                SmartDesk is ready

                            </strong>

                            <p class="text-muted small mb-0 mt-1">

                                You can create and track
                                your support tickets from
                                this dashboard.

                            </p>

                        </div>

                    </div>

                </div>


                <div class="p-3 rounded-4 bg-light">

                    <div class="d-flex gap-3">

                        <i class="bi bi-ticket-perforated text-success fs-5"></i>

                        <div>

                            <strong class="small">

                                Ticket summary updated

                            </strong>

                            <p class="text-muted small mb-0 mt-1">

                                Your dashboard statistics
                                are calculated from your
                                current tickets.

                            </p>

                        </div>

                    </div>

                </div>

            </div>


            <div class="modal-footer border-0">

                <button
                    type="button"
                    class="btn btn-dark rounded-3 px-4"
                    data-bs-dismiss="modal">

                    Close

                </button>

            </div>

        </div>

    </div>

</div>


<!-- =========================================================
     BOOTSTRAP JS
========================================================= -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<!-- =========================================================
     CHART
========================================================= -->

<script>

    const totalTickets = <%= totalTickets %>;

    const openTickets = <%= openTickets %>;

    const inProgressTickets = <%= inProgressTickets %>;

    const resolvedTickets = <%= resolvedTickets %>;


    const chartElement =
        document.getElementById("ticketChart");


    if (chartElement) {

        new Chart(
            chartElement,
            {

                type: "doughnut",

                data: {

                    labels: [
                        "Open",
                        "In Progress",
                        "Resolved"
                    ],

                    datasets: [

                        {

                            data: [

                                openTickets,

                                inProgressTickets,

                                resolvedTickets

                            ],

                            backgroundColor: [

                                "#f97316",

                                "#7c3aed",

                                "#16a34a"

                            ],

                            borderWidth: 0,

                            hoverOffset: 8

                        }

                    ]

                },

                options: {

                    responsive: true,

                    maintainAspectRatio: false,

                    cutout: "72%",

                    plugins: {

                        legend: {

                            position: "bottom",

                            labels: {

                                usePointStyle: true,

                                padding: 18,

                                font: {

                                    size: 11

                                }

                            }

                        }

                    }

                }

            }

        );

    }

</script>


</body>

</html>