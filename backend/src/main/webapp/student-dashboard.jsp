<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.cms.model.Student" %>
<%@ page import="com.cms.model.AssignmentSummary" %>
<%@ page import="java.util.List" %>

<%
    // =========================================================
    // GET DATA FROM SERVLET
    // =========================================================

    Student student =
            (Student) request.getAttribute("student");

    List<AssignmentSummary> assignments =
            (List<AssignmentSummary>)
                    request.getAttribute("assignments");


    // =========================================================
    // SAFETY CHECK
    // =========================================================

    if (student == null) {

        response.sendRedirect(
                request.getContextPath() + "/login"
        );

        return;
    }


    // =========================================================
    // STUDENT DISPLAY DATA
    // =========================================================

    String contextPath =
            request.getContextPath();


    String firstName =
            student.getFirstName() != null
                    ? student.getFirstName()
                    : "Student";


    String lastName =
            student.getLastName() != null
                    ? student.getLastName()
                    : "";


    String initials =
            firstName.substring(0, 1).toUpperCase();
%>


<!DOCTYPE html>

<html lang="en">


<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Student Dashboard | Campus CMS</title>


    <style>

        /* =========================================================
           RESET
        ========================================================= */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        /* =========================================================
           BODY
        ========================================================= */

        body {

            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                Roboto,
                Arial,
                sans-serif;

            background: #f5f7fc;

            color: #172033;

            min-height: 100vh;
        }


        a {
            text-decoration: none;
        }


        /* =========================================================
           MAIN LAYOUT
        ========================================================= */

        .app {

            display: flex;

            min-height: 100vh;
        }


        /* =========================================================
           SIDEBAR
        ========================================================= */

        .sidebar {

            width: 234px;

            background: #ffffff;

            border-right: 1px solid #e7eaf2;

            position: fixed;

            left: 0;
            top: 0;
            bottom: 0;

            display: flex;

            flex-direction: column;

            z-index: 100;
        }


        /* =========================================================
           BRAND
        ========================================================= */

        .brand {

            height: 106px;

            padding: 0 18px;

            display: flex;

            align-items: center;

            gap: 11px;

            border-bottom: 1px solid #edf0f5;
        }


        .brand-icon {

            width: 36px;
            height: 36px;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    #5146e5,
                    #6366f1
                );

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            box-shadow:
                0 6px 15px rgba(79, 70, 229, 0.20);
        }


        .brand-icon svg {

            width: 19px;
            height: 19px;
        }


        .brand-text {

            display: flex;

            flex-direction: column;
        }


        .brand-title {

            font-size: 14px;

            font-weight: 700;

            color: #172033;

            line-height: 1.2;
        }


        .brand-subtitle {

            font-size: 10px;

            color: #8a94a7;

            margin-top: 4px;
        }


        /* =========================================================
           NAVIGATION
        ========================================================= */

        .nav {

            padding: 21px 11px;

            flex: 1;
        }


        .nav-section-title {

            font-size: 9px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 1px;

            color: #98a1b2;

            padding: 0 11px;

            margin-bottom: 10px;
        }


        .nav-item {

            height: 40px;

            display: flex;

            align-items: center;

            gap: 12px;

            padding: 0 11px;

            margin-bottom: 4px;

            border-radius: 9px;

            color: #4f5d73;

            font-size: 12px;

            font-weight: 500;

            transition:
                background 0.2s ease,
                color 0.2s ease;
        }


        .nav-item svg {

            width: 17px;
            height: 17px;

            flex-shrink: 0;
        }


        .nav-item:hover {

            background: #f1f2ff;

            color: #4f46e5;
        }


        .nav-item.active {

            background:
                linear-gradient(
                    135deg,
                    #5548e8,
                    #635bfa
                );

            color: #ffffff;

            box-shadow:
                0 7px 16px rgba(79, 70, 229, 0.18);
        }


        /* =========================================================
           LOGOUT
        ========================================================= */

        .sidebar-bottom {

            padding: 18px 11px;

            border-top: 1px solid #edf0f5;
        }


        .logout {

            height: 40px;

            display: flex;

            align-items: center;

            gap: 12px;

            padding: 0 11px;

            border-radius: 9px;

            color: #ef4444;

            font-size: 12px;

            font-weight: 500;
        }


        .logout svg {

            width: 17px;
            height: 17px;
        }


        .logout:hover {

            background: #fff1f2;
        }


        /* =========================================================
           MAIN
        ========================================================= */

        .main {

            margin-left: 234px;

            width:
                calc(100% - 234px);

            min-height: 100vh;
        }


        /* =========================================================
           TOPBAR
        ========================================================= */

        .topbar {

            height: 76px;

            background: #ffffff;

            border-bottom: 1px solid #e7eaf2;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 29px;
        }


        .page-heading h1 {

            font-size: 22px;

            font-weight: 700;

            color: #172033;

            line-height: 1.2;
        }


        .page-heading p {

            font-size: 10px;

            color: #8b95a7;

            margin-top: 5px;
        }


        /* =========================================================
           TOPBAR USER
        ========================================================= */

        .topbar-user {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .notification-button {

            width: 34px;
            height: 34px;

            border: 1px solid #e6e9f0;

            background: #ffffff;

            border-radius: 9px;

            display: flex;

            align-items: center;

            justify-content: center;

            color: #64748b;

            cursor: pointer;
        }


        .notification-button:hover {

            background: #f7f7ff;

            color: #4f46e5;
        }


        .notification-button svg {

            width: 17px;
            height: 17px;
        }


        .avatar {

            width: 34px;
            height: 34px;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    #5146e5,
                    #7c3aed
                );

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 12px;

            font-weight: 700;
        }


        .user-details {

            display: flex;

            flex-direction: column;

            min-width: 90px;
        }


        .user-name {

            font-size: 11px;

            font-weight: 700;

            color: #172033;
        }


        .user-role {

            font-size: 9px;

            color: #667085;

            margin-top: 3px;
        }


        /* =========================================================
           CONTENT
        ========================================================= */

        .content {

            padding: 27px 29px 35px;
        }


        /* =========================================================
           WELCOME BANNER
        ========================================================= */

        .welcome {

            height: 122px;

            border-radius: 14px;

            background:
                linear-gradient(
                    105deg,
                    #5146e5 0%,
                    #5c58ee 50%,
                    #6960f4 100%
                );

            position: relative;

            overflow: hidden;

            padding: 28px 25px;

            color: white;

            box-shadow:
                0 10px 25px rgba(79, 70, 229, 0.16);

            margin-bottom: 20px;
        }


        .welcome-content {

            position: relative;

            z-index: 2;
        }


        .welcome-small {

            font-size: 9px;

            text-transform: uppercase;

            letter-spacing: 1px;

            font-weight: 700;

            color: rgba(255,255,255,0.70);

            margin-bottom: 7px;
        }


        .welcome h2 {

            font-size: 21px;

            font-weight: 700;

            margin-bottom: 6px;
        }


        .welcome p {

            font-size: 10px;

            color: rgba(255,255,255,0.76);
        }


        /* =========================================================
           DECORATIVE CIRCLES
        ========================================================= */

        .circle-one {

            position: absolute;

            width: 125px;
            height: 125px;

            border-radius: 50%;

            border:
                1px solid rgba(255,255,255,0.13);

            right: 25px;

            top: -38px;
        }


        .circle-two {

            position: absolute;

            width: 76px;
            height: 76px;

            border-radius: 50%;

            border:
                1px solid rgba(255,255,255,0.13);

            right: 50px;

            top: -13px;
        }


        .circle-three {

            position: absolute;

            width: 65px;
            height: 65px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.035);

            right: 78px;

            bottom: -36px;
        }


        /* =========================================================
           STATISTICS
        ========================================================= */

        .stats {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 14px;

            margin-bottom: 20px;
        }


        .stat-card {

            min-height: 78px;

            background: #ffffff;

            border: 1px solid #e5e8ef;

            border-radius: 11px;

            padding: 15px 16px;

            display: flex;

            align-items: center;

            gap: 12px;

            transition:
                transform 0.2s ease,
                box-shadow 0.2s ease;
        }


        .stat-card:hover {

            transform: translateY(-2px);

            box-shadow:
                0 7px 20px rgba(15,23,42,0.05);
        }


        .stat-icon {

            width: 38px;
            height: 38px;

            border-radius: 9px;

            background: #f0efff;

            color: #5548e8;

            display: flex;

            align-items: center;

            justify-content: center;

            flex-shrink: 0;
        }


        .stat-icon svg {

            width: 18px;
            height: 18px;
        }


        .stat-label {

            font-size: 9px;

            color: #8490a4;

            margin-bottom: 5px;
        }


        .stat-value {

            font-size: 13px;

            font-weight: 700;

            color: #172033;
        }


        /* =========================================================
           CONTENT GRID
        ========================================================= */

        .content-grid {

            display: grid;

            grid-template-columns:
                minmax(0, 1.55fr)
                minmax(330px, 0.85fr);

            gap: 20px;

            align-items: stretch;
        }


        /* =========================================================
           CARD
        ========================================================= */

        .card {

            background: #ffffff;

            border: 1px solid #e5e8ef;

            border-radius: 12px;

            overflow: hidden;

            min-height: 330px;
        }


        .card-header {

            height: 76px;

            padding: 0 20px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            border-bottom: 1px solid #edf0f5;
        }


        .card-title {

            font-size: 15px;

            font-weight: 700;

            color: #172033;
        }


        .card-subtitle {

            font-size: 11px;

            color: #8a94a7;

            margin-top: 5px;
        }


        .card-link {

            color: #5146e5;

            font-size: 11px;

            font-weight: 600;
        }


        .card-link:hover {

            color: #3730a3;
        }


        /* =========================================================
           ASSIGNMENTS
        ========================================================= */

        .assignment-list {

            padding: 0 20px;
        }


        .assignment-item {

            min-height: 76px;

            display: flex;

            align-items: center;

            gap: 14px;

            border-bottom:
                1px solid #f0f2f6;

            transition:
                background 0.2s ease;
        }


        .assignment-item:last-child {

            border-bottom: none;
        }


        .assignment-item:hover {

            background: #fafaff;
        }


        .assignment-icon {

            width: 40px;
            height: 40px;

            border-radius: 9px;

            background: #f1f0ff;

            color: #5548e8;

            display: flex;

            align-items: center;

            justify-content: center;

            flex-shrink: 0;
        }


        .assignment-icon svg {

            width: 18px;
            height: 18px;
        }


        .assignment-info {

            flex: 1;

            min-width: 0;
        }


        .assignment-title {

            font-size: 13px;

            font-weight: 700;

            color: #263247;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }


        .assignment-meta {

            font-size: 10px;

            color: #8b95a7;

            margin-top: 5px;

            line-height: 1.4;
        }


        .assignment-deadline {

            min-width: 105px;

            text-align: right;

            margin-left: 10px;
        }


        .deadline-date {

            font-size: 10px;

            font-weight: 600;

            color: #4f5d73;
        }


        .deadline-time {

            font-size: 9px;

            color: #8b95a7;

            margin-top: 4px;
        }


        /* =========================================================
           EMPTY STATE
        ========================================================= */

        .empty {

            min-height: 250px;

            display: flex;

            flex-direction: column;

            align-items: center;

            justify-content: center;

            color: #8b95a7;
        }


        .empty-icon {

            width: 43px;
            height: 43px;

            border-radius: 10px;

            background: #f4f5f8;

            color: #8993a5;

            display: flex;

            align-items: center;

            justify-content: center;

            margin-bottom: 11px;
        }


        .empty-icon svg {

            width: 19px;
            height: 19px;
        }


        .empty p {

            font-size: 12px;

            color: #64748b;
        }


        /* =========================================================
           PROFILE
        ========================================================= */

        .profile {

            padding: 20px;
        }


        .profile-top {

            display: flex;

            align-items: center;

            gap: 13px;

            padding-bottom: 18px;

            border-bottom: 1px solid #edf0f5;

            margin-bottom: 2px;
        }


        .profile-avatar {

            width: 43px;
            height: 43px;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    #5146e5,
                    #7c3aed
                );

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 13px;

            font-weight: 700;
        }


        .profile-name {

            font-size: 14px;

            font-weight: 700;

            color: #172033;
        }


        .profile-register {

            font-size: 10px;

            color: #8a94a7;

            margin-top: 4px;
        }


        .profile-row {

            min-height: 48px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            border-bottom:
                1px solid #f0f2f6;
        }


        .profile-row:last-child {

            border-bottom: none;
        }


        .profile-label {

            font-size: 11px;

            color: #8490a4;
        }


        .profile-value {

            font-size: 11px;

            font-weight: 600;

            color: #263247;

            text-align: right;
        }


        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media (max-width: 1100px) {

            .stats {

                grid-template-columns:
                    repeat(2, 1fr);
            }


            .content-grid {

                grid-template-columns: 1fr;
            }
        }


        @media (max-width: 760px) {

            .sidebar {

                width: 68px;
            }


            .brand {

                justify-content: center;

                padding: 0;
            }


            .brand-text,
            .nav-section-title,
            .nav-item span,
            .logout span {

                display: none;
            }


            .nav-item {

                justify-content: center;

                padding: 0;
            }


            .nav-item svg {

                width: 18px;
                height: 18px;
            }


            .logout {

                justify-content: center;

                padding: 0;
            }


            .main {

                margin-left: 68px;

                width:
                    calc(100% - 68px);
            }


            .content {

                padding: 20px;
            }


            .topbar {

                padding: 0 20px;
            }


            .user-details {

                display: none;
            }
        }


        @media (max-width: 520px) {

            .stats {

                grid-template-columns: 1fr;
            }


            .welcome {

                height: auto;

                min-height: 122px;
            }


            .circle-one,
            .circle-two,
            .circle-three {

                display: none;
            }


            .page-heading h1 {

                font-size: 18px;
            }


            .page-heading p {

                display: none;
            }


            .assignment-item {

                align-items: flex-start;

                padding: 15px 0;
            }


            .assignment-deadline {

                min-width: 75px;

                margin-left: 0;
            }
        }

    </style>

</head>


<body>


<div class="app">


    <!-- =========================================================
         SIDEBAR
    ========================================================== -->

    <aside class="sidebar">


        <!-- BRAND -->

        <div class="brand">

            <div class="brand-icon">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <path d="M3 21h18"/>

                    <path d="M5 21V9l7-5 7 5v12"/>

                    <path d="M9 21v-6h6v6"/>

                    <path d="M9 10h.01"/>
                    <path d="M15 10h.01"/>

                </svg>

            </div>


            <div class="brand-text">

                <div class="brand-title">
                    Campus CMS
                </div>

                <div class="brand-subtitle">
                    Student Portal
                </div>

            </div>

        </div>


        <!-- NAVIGATION -->

        <nav class="nav">


            <div class="nav-section-title">
                Overview
            </div>


            <!-- Dashboard -->

            <a href="<%= contextPath %>/dashboard"
               class="nav-item active">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <rect x="3" y="3"
                          width="7"
                          height="7"/>

                    <rect x="14" y="3"
                          width="7"
                          height="7"/>

                    <rect x="3" y="14"
                          width="7"
                          height="7"/>

                    <rect x="14" y="14"
                          width="7"
                          height="7"/>

                </svg>

                <span>
                    Dashboard
                </span>

            </a>


            <div class="nav-section-title"
                 style="margin-top:24px;">

                Academic

            </div>


            <!-- Assignments -->

            <a href="#"
               class="nav-item">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <path d="M6 3h12v18H6z"/>

                    <path d="M9 7h6"/>
                    <path d="M9 11h6"/>
                    <path d="M9 15h4"/>

                </svg>

                <span>
                    Assignments
                </span>

            </a>


            <!-- Calendar -->

            <a href="<%= contextPath %>/calendar"
   class="nav-item">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <rect x="3"
                          y="5"
                          width="18"
                          height="16"
                          rx="2"/>

                    <path d="M16 3v4"/>
                    <path d="M8 3v4"/>

                    <path d="M3 10h18"/>

                    <path d="M8 14h.01"/>
                    <path d="M12 14h.01"/>
                    <path d="M16 14h.01"/>

                    <path d="M8 18h.01"/>
                    <path d="M12 18h.01"/>

                </svg>

                <span>
                    Calendar
                </span>

            </a>


            <!-- Notifications -->

            <a href="#"
               class="nav-item">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <path d="M18 8a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9"/>

                    <path d="M10 21h4"/>

                </svg>

                <span>
                    Notifications
                </span>

            </a>


            <!-- Profile -->

            <a href="#"
               class="nav-item">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <circle cx="12"
                            cy="8"
                            r="4"/>

                    <path d="M4 21c0-4.4 3.6-7 8-7s8 2.6 8 7"/>

                </svg>

                <span>
                    My Profile
                </span>

            </a>


        </nav>


        <!-- LOGOUT -->

        <div class="sidebar-bottom">

            <a href="<%= contextPath %>/logout"
               class="logout">

                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.8"
                    stroke-linecap="round"
                    stroke-linejoin="round">

                    <path d="M10 17l5-5-5-5"/>

                    <path d="M15 12H3"/>

                    <path d="M21 19V5a2 2 0 0 0-2-2h-6"/>

                </svg>

                <span>
                    Logout
                </span>

            </a>

        </div>


    </aside>



    <!-- =========================================================
         MAIN CONTENT
    ========================================================== -->

    <main class="main">


        <!-- TOPBAR -->

        <header class="topbar">


            <div class="page-heading">

                <h1>
                    Dashboard
                </h1>

                <p>
                    Overview of your academic activities
                </p>

            </div>


            <div class="topbar-user">


                <!-- Notification -->

                <button class="notification-button">

                    <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="1.8"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                        <path d="M18 8a6 6 0 0 0-12 0c0 7-3 7-3 9h18c0-2-3-2-3-9"/>

                        <path d="M10 21h4"/>

                    </svg>

                </button>


                <!-- Avatar -->

                <div class="avatar">

                    <%= initials %>

                </div>


                <!-- User -->

                <div class="user-details">

                    <div class="user-name">

                        <%= firstName %>

                    </div>

                    <div class="user-role">

                        STUDENT

                    </div>

                </div>


            </div>

        </header>



        <!-- PAGE CONTENT -->

        <section class="content">


            <!-- =================================================
                 WELCOME
            ================================================== -->

            <div class="welcome">


                <div class="welcome-content">

                    <div class="welcome-small">

                        Welcome back

                    </div>


                    <h2>

                        Welcome back,
                        <%= firstName %>

                    </h2>


                    <p>

                        Here's an overview of your academic information.

                    </p>

                </div>


                <div class="circle-one"></div>

                <div class="circle-two"></div>

                <div class="circle-three"></div>


            </div>



            <!-- =================================================
                 STAT CARDS
            ================================================== -->

            <div class="stats">


                <!-- CLASS -->

                <div class="stat-card">

                    <div class="stat-icon">

                        <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            stroke-linecap="round"
                            stroke-linejoin="round">

                            <path d="M3 21h18"/>

                            <path d="M5 21V9l7-5 7 5v12"/>

                            <path d="M9 21v-6h6v6"/>

                        </svg>

                    </div>


                    <div>

                        <div class="stat-label">
                            Class ID
                        </div>

                        <div class="stat-value">

                            <%= student.getClassId() %>

                        </div>

                    </div>

                </div>



                <!-- SEMESTER -->

                <div class="stat-card">

                    <div class="stat-icon">

                        <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            stroke-linecap="round"
                            stroke-linejoin="round">

                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/>

                            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>

                        </svg>

                    </div>


                    <div>

                        <div class="stat-label">
                            Semester
                        </div>

                        <div class="stat-value">

                            <%= student.getSemester() %>

                        </div>

                    </div>

                </div>



                <!-- DEPARTMENT -->

                <div class="stat-card">

                    <div class="stat-icon">

                        <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            stroke-linecap="round"
                            stroke-linejoin="round">

                            <path d="M12 3L2 9l10 6 10-6-10-6z"/>

                            <path d="M5 12v5l7 4 7-4v-5"/>

                            <path d="M22 9v6"/>

                        </svg>

                    </div>


                    <div>

                        <div class="stat-label">
                            Department
                        </div>

                        <div class="stat-value">

                            <%= student.getDepartment() %>

                        </div>

                    </div>

                </div>



                <!-- ADMISSION YEAR -->

                <div class="stat-card">

                    <div class="stat-icon">

                        <svg
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.8"
                            stroke-linecap="round"
                            stroke-linejoin="round">

                            <rect x="3"
                                  y="5"
                                  width="18"
                                  height="16"
                                  rx="2"/>

                            <path d="M16 3v4"/>
                            <path d="M8 3v4"/>

                            <path d="M3 10h18"/>

                        </svg>

                    </div>


                    <div>

                        <div class="stat-label">
                            Admission Year
                        </div>

                        <div class="stat-value">

                            <%= student.getAdmissionYear() %>

                        </div>

                    </div>

                </div>


            </div>



            <!-- =================================================
                 LOWER GRID
            ================================================== -->

            <div class="content-grid">


                <!-- =================================================
                     ASSIGNMENTS CARD
                ================================================== -->

                <div class="card">


                    <div class="card-header">

                        <div>

                            <div class="card-title">

                                Upcoming Assignments

                            </div>


                            <div class="card-subtitle">

                                Your latest academic tasks

                            </div>

                        </div>


                        <a href="#"
                           class="card-link">

                            View all

                        </a>

                    </div>


                    <!-- =================================================
                         ASSIGNMENT DATA
                    ================================================== -->

                    <%
                        if (assignments != null
                                && !assignments.isEmpty()) {
                    %>


                        <div class="assignment-list">


                            <%
                                for (
                                    AssignmentSummary assignment
                                    : assignments
                                ) {
                            %>


                                <div class="assignment-item">


                                    <!-- ASSIGNMENT ICON -->

                                    <div class="assignment-icon">

                                        <svg
                                            viewBox="0 0 24 24"
                                            fill="none"
                                            stroke="currentColor"
                                            stroke-width="1.8"
                                            stroke-linecap="round"
                                            stroke-linejoin="round">

                                            <path d="M6 3h12v18H6z"/>

                                            <path d="M9 7h6"/>

                                            <path d="M9 11h6"/>

                                            <path d="M9 15h4"/>

                                        </svg>

                                    </div>



                                    <!-- ASSIGNMENT INFORMATION -->

                                    <div class="assignment-info">


                                        <div class="assignment-title">

                                            <%= assignment.getTitle() %>

                                        </div>


                                        <div class="assignment-meta">


                                            <%= assignment.getSubjectName() %>


                                            <% if (
                                                assignment.getSubjectCode()
                                                        != null
                                                &&
                                                !assignment.getSubjectCode()
                                                        .isBlank()
                                            ) {
                                            %>

                                                <span>
                                                    ·
                                                    <%= assignment.getSubjectCode() %>
                                                </span>

                                            <%
                                            }
                                            %>


                                            <span>

                                                ·

                                                <%= assignment.getClassName() %>


                                                <%
                                                    if (
                                                        assignment.getSection()
                                                                != null
                                                        &&
                                                        !assignment.getSection()
                                                                .isBlank()
                                                    ) {
                                                %>

                                                    - Section
                                                    <%= assignment.getSection() %>

                                                <%
                                                    }
                                                %>

                                            </span>


                                        </div>


                                    </div>



                                    <!-- DEADLINE -->

                                    <div class="assignment-deadline">


                                        <%
                                            String deadline =
                                                    assignment.getDeadline();


                                            String[] deadlineParts =
                                                    deadline != null
                                                            ? deadline.split("T")
                                                            : new String[]{"", ""};


                                            String datePart =
                                                    deadlineParts.length > 0
                                                            ? deadlineParts[0]
                                                            : "";


                                            String timePart =
                                                    deadlineParts.length > 1
                                                            ? deadlineParts[1]
                                                            : "";
                                        %>


                                        <div class="deadline-date">

                                            <%= datePart %>

                                        </div>


                                        <div class="deadline-time">

                                            <%= timePart %>

                                        </div>


                                    </div>


                                </div>


                            <%
                                }
                            %>


                        </div>


                    <%
                        } else {
                    %>


                        <!-- =================================================
                             EMPTY STATE
                        ================================================== -->

                        <div class="empty">


                            <div class="empty-icon">

                                <svg
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.8"
                                    stroke-linecap="round"
                                    stroke-linejoin="round">

                                    <path d="M6 3h12v18H6z"/>

                                    <path d="M9 7h6"/>

                                    <path d="M9 11h6"/>

                                    <path d="M9 15h4"/>

                                </svg>

                            </div>


                            <p>

                                No upcoming assignments.

                            </p>


                        </div>


                    <%
                        }
                    %>


                </div>



                <!-- =================================================
                     PROFILE CARD
                ================================================== -->

                <div class="card">


                    <div class="card-header">

                        <div>

                            <div class="card-title">

                                Student Profile

                            </div>


                            <div class="card-subtitle">

                                Your academic information

                            </div>

                        </div>


                        <a href="#"
                           class="card-link">

                            Profile

                        </a>

                    </div>



                    <div class="profile">


                        <!-- PROFILE HEADER -->

                        <div class="profile-top">


                            <div class="profile-avatar">

                                <%= initials %>

                            </div>


                            <div>


                                <div class="profile-name">

                                    <%= firstName %>


                                    <%
                                        if (!lastName.trim().isEmpty()) {
                                    %>

                                        <%= " " + lastName %>

                                    <%
                                        }
                                    %>

                                </div>


                                <div class="profile-register">

                                    <%= student.getRegisterNo() %>

                                </div>


                            </div>


                        </div>



                        <!-- REGISTER NUMBER -->

                        <div class="profile-row">

                            <span class="profile-label">

                                Register Number

                            </span>


                            <span class="profile-value">

                                <%= student.getRegisterNo() %>

                            </span>

                        </div>



                        <!-- DEPARTMENT -->

                        <div class="profile-row">

                            <span class="profile-label">

                                Department

                            </span>


                            <span class="profile-value">

                                <%= student.getDepartment() %>

                            </span>

                        </div>



                        <!-- SEMESTER -->

                        <div class="profile-row">

                            <span class="profile-label">

                                Semester

                            </span>


                            <span class="profile-value">

                                <%= student.getSemester() %>

                            </span>

                        </div>



                        <!-- ADMISSION YEAR -->

                        <div class="profile-row">

                            <span class="profile-label">

                                Admission Year

                            </span>


                            <span class="profile-value">

                                <%= student.getAdmissionYear() %>

                            </span>

                        </div>



                        <!-- CLASS -->

                        <div class="profile-row">

                            <span class="profile-label">

                                Class ID

                            </span>


                            <span class="profile-value">

                                <%= student.getClassId() %>

                            </span>

                        </div>


                    </div>


                </div>


            </div>


        </section>


    </main>


</div>


</body>

</html>