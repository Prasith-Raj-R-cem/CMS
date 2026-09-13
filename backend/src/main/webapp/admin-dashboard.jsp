<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cms.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    String email = user != null ? user.getEmail() : "admin@campus.local";
    String role = user != null && user.getRole() != null
            ? user.getRole().name()
            : "ADMIN";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | Campus CMS</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                Roboto,
                Arial,
                sans-serif;

            background: #f4f6fc;
            color: #172033;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* =========================
           SVG ICON SYSTEM
           ========================= */

        .icon {
            width: 20px;
            height: 20px;
            display: block;
            fill: none;
            stroke: currentColor;
            stroke-width: 1.8;
            stroke-linecap: round;
            stroke-linejoin: round;
        }

        .icon-small {
            width: 17px;
            height: 17px;
        }

        .icon-large {
            width: 23px;
            height: 23px;
        }

        .icon-white {
            color: #ffffff;
        }

        .icon-purple {
            color: #4f46e5;
        }


        /* =========================
           MAIN LAYOUT
           ========================= */

        .dashboard-layout {
            min-height: 100vh;
            display: flex;
        }


        /* =========================
           SIDEBAR
           ========================= */

        .sidebar {
            width: 260px;
            min-width: 260px;
            height: 100vh;

            position: fixed;
            left: 0;
            top: 0;

            background: #ffffff;
            border-right: 1px solid #e5e7eb;

            display: flex;
            flex-direction: column;

            z-index: 100;
        }


        /* Brand */

        .brand {
            height: 116px;

            padding: 28px 20px;

            display: flex;
            align-items: center;

            border-bottom: 1px solid #eef0f5;
        }

        .brand-logo {
            width: 38px;
            height: 38px;

            border-radius: 11px;

            background: linear-gradient(
                135deg,
                #4f46e5,
                #6366f1
            );

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;

            box-shadow:
                0 8px 18px rgba(79, 70, 229, 0.25);
        }

        .brand-logo svg {
            width: 20px;
            height: 20px;
        }

        .brand-text {
            margin-left: 12px;
        }

        .brand-title {
            font-size: 15px;
            font-weight: 700;
            color: #18213a;
        }

        .brand-subtitle {
            margin-top: 3px;
            font-size: 11px;
            color: #9aa3b7;
        }


        /* Sidebar content */

        .sidebar-content {
            flex: 1;
            padding: 22px 12px;
            overflow-y: auto;
        }

        .nav-section {
            margin-bottom: 24px;
        }

        .nav-title {
            padding: 0 12px 9px;

            font-size: 10px;
            font-weight: 700;

            letter-spacing: 0.8px;
            text-transform: uppercase;

            color: #9aa3b7;
        }

        .nav-item {
            height: 42px;

            margin-bottom: 4px;
            padding: 0 12px;

            display: flex;
            align-items: center;
            gap: 11px;

            border-radius: 9px;

            color: #40506d;

            font-size: 13px;
            font-weight: 500;

            transition:
                background 0.2s ease,
                color 0.2s ease,
                transform 0.2s ease;
        }

        .nav-item svg {
            color: #6b7280;
            transition: color 0.2s ease;
        }

        .nav-item:hover {
            background: #f4f3ff;
            color: #4f46e5;
        }

        .nav-item:hover svg {
            color: #4f46e5;
        }

        .nav-item.active {
            background: linear-gradient(
                135deg,
                #4f46e5,
                #6366f1
            );

            color: #ffffff;

            box-shadow:
                0 7px 16px rgba(79, 70, 229, 0.20);
        }

        .nav-item.active svg {
            color: #ffffff;
        }


        /* Sidebar footer */

        .sidebar-footer {
            padding: 16px 12px;

            border-top: 1px solid #eef0f5;
        }

        .logout {
            color: #ef4444;
        }

        .logout svg {
            color: #ef4444;
        }

        .logout:hover {
            background: #fff1f2;
            color: #dc2626;
        }


        /* =========================
           MAIN CONTENT
           ========================= */

        .main-content {
            margin-left: 260px;

            width: calc(100% - 260px);

            min-height: 100vh;

            padding: 0 32px 40px;
        }


        /* =========================
           TOP BAR
           ========================= */

        .topbar {
            height: 100px;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .page-title {
            font-size: 26px;
            font-weight: 750;
            color: #172033;
        }

        .page-subtitle {
            margin-top: 5px;

            font-size: 13px;

            color: #8b97ad;
        }


        /* Profile */

        .profile-box {
            display: flex;
            align-items: center;
            gap: 12px;

            padding: 7px 12px 7px 7px;

            background: #ffffff;

            border: 1px solid #edf0f5;

            border-radius: 12px;

            box-shadow:
                0 4px 15px rgba(30, 41, 59, 0.05);
        }

        .profile-avatar {
            width: 36px;
            height: 36px;

            border-radius: 10px;

            background: linear-gradient(
                135deg,
                #4f46e5,
                #6366f1
            );

            color: #ffffff;

            display: flex;
            align-items: center;
            justify-content: center;

            font-weight: 700;
            font-size: 14px;
        }

        .profile-info {
            line-height: 1.2;
        }

        .profile-email {
            font-size: 12px;
            font-weight: 600;
            color: #1f2937;
        }

        .profile-role {
            margin-top: 3px;

            font-size: 10px;
            font-weight: 700;

            color: #4f46e5;
            letter-spacing: 0.5px;
        }


        /* =========================
           WELCOME CARD
           ========================= */

        .welcome-card {
            position: relative;

            min-height: 102px;

            padding: 27px 28px;

            overflow: hidden;

            border-radius: 15px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5 0%,
                    #6366f1 100%
                );

            color: #ffffff;

            box-shadow:
                0 12px 25px rgba(79, 70, 229, 0.18);
        }

        .welcome-card::before {
            content: "";

            position: absolute;

            width: 150px;
            height: 150px;

            right: -35px;
            top: -65px;

            border-radius: 50%;

            background: rgba(255, 255, 255, 0.08);
        }

        .welcome-card::after {
            content: "";

            position: absolute;

            width: 95px;
            height: 95px;

            right: 65px;
            bottom: -65px;

            border-radius: 50%;

            background: rgba(255, 255, 255, 0.05);
        }

        .welcome-content {
            position: relative;
            z-index: 2;
        }

        .welcome-title {
            font-size: 21px;
            font-weight: 700;
        }

        .welcome-text {
            margin-top: 7px;

            font-size: 12px;

            color: rgba(255, 255, 255, 0.88);
        }


        /* =========================
           MANAGEMENT HEADER
           ========================= */

        .management-header {
            margin-top: 30px;
            margin-bottom: 12px;
        }

        .management-title {
            font-size: 16px;
            font-weight: 700;
            color: #18213a;
        }

        .management-subtitle {
            margin-top: 3px;

            font-size: 11px;
            color: #9aa3b7;
        }


        /* =========================
           MANAGEMENT GRID
           ========================= */

        .management-grid {
            display: grid;

            grid-template-columns:
                repeat(3, minmax(0, 1fr));

            gap: 17px;
        }


        /* =========================
           MANAGEMENT CARD
           ========================= */

        .management-card {
            position: relative;

            min-height: 128px;

            padding: 20px;

            background: #ffffff;

            border: 1px solid #edf0f5;

            border-radius: 13px;

            box-shadow:
                0 4px 13px rgba(30, 41, 59, 0.045);

            transition:
                transform 0.2s ease,
                box-shadow 0.2s ease,
                border-color 0.2s ease;
        }

        .management-card:hover {
            transform: translateY(-3px);

            border-color: #e1defe;

            box-shadow:
                0 12px 25px rgba(30, 41, 59, 0.09);
        }


        /* Card icon */

        .card-icon {
            width: 39px;
            height: 39px;

            border-radius: 10px;

            background: #f0efff;

            color: #4f46e5;

            display: flex;
            align-items: center;
            justify-content: center;

            margin-bottom: 15px;
        }

        .card-icon svg {
            width: 20px;
            height: 20px;
        }


        /* Arrow */

        .card-arrow {
            position: absolute;

            top: 20px;
            right: 20px;

            width: 28px;
            height: 28px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 7px;

            color: #c4cada;

            transition:
                background 0.2s ease,
                color 0.2s ease;
        }

        .management-card:hover .card-arrow {
            background: #f0efff;
            color: #4f46e5;
        }


        /* Card text */

        .card-title {
            font-size: 13px;
            font-weight: 700;

            color: #18213a;
        }

        .card-description {
            margin-top: 6px;

            font-size: 10.5px;
            line-height: 1.5;

            color: #91a0b8;
        }


        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 1200px) {

            .management-grid {
                grid-template-columns:
                    repeat(2, minmax(0, 1fr));
            }

        }


        @media (max-width: 800px) {

            .sidebar {
                width: 220px;
                min-width: 220px;
            }

            .main-content {
                margin-left: 220px;
                width: calc(100% - 220px);

                padding-left: 20px;
                padding-right: 20px;
            }

            .management-grid {
                grid-template-columns: 1fr;
            }

        }


        @media (max-width: 600px) {

            .sidebar {
                width: 72px;
                min-width: 72px;
            }

            .brand {
                justify-content: center;
                padding: 20px 10px;
            }

            .brand-text,
            .nav-title,
            .nav-item span {
                display: none;
            }

            .nav-item {
                justify-content: center;
                padding: 0;
            }

            .sidebar-footer .nav-item {
                justify-content: center;
            }

            .main-content {
                margin-left: 72px;
                width: calc(100% - 72px);

                padding-left: 15px;
                padding-right: 15px;
            }

            .topbar {
                height: 90px;
            }

            .page-title {
                font-size: 22px;
            }

            .page-subtitle {
                font-size: 11px;
            }

            .profile-info {
                display: none;
            }

            .profile-box {
                padding: 5px;
            }

            .welcome-card {
                padding: 22px;
            }

            .welcome-title {
                font-size: 18px;
            }

        }

    </style>
</head>

<body>

<div class="dashboard-layout">


    <!-- =====================================================
         SIDEBAR
         ===================================================== -->

    <aside class="sidebar">


        <!-- BRAND -->

        <div class="brand">

            <div class="brand-logo">

                <!-- Campus / C SVG -->
                <svg
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round">

                    <path d="M5 4h14"/>
                    <path d="M5 4v16"/>
                    <path d="M5 20h14"/>
                    <path d="M19 4v16"/>
                    <path d="M9 8h6"/>
                    <path d="M9 12h6"/>
                    <path d="M9 16h4"/>

                </svg>

            </div>

            <div class="brand-text">

                <div class="brand-title">
                    Campus CMS
                </div>

                <div class="brand-subtitle">
                    Administration
                </div>

            </div>

        </div>


        <!-- SIDEBAR NAVIGATION -->

        <div class="sidebar-content">


            <!-- OVERVIEW -->

            <div class="nav-section">

                <div class="nav-title">
                    Overview
                </div>


                <a href="<%= request.getContextPath() %>/admin/dashboard"
                   class="nav-item active">

                    <!-- Dashboard SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <rect x="3" y="3" width="7" height="7" rx="1"/>
                        <rect x="14" y="3" width="7" height="7" rx="1"/>
                        <rect x="3" y="14" width="7" height="7" rx="1"/>
                        <rect x="14" y="14" width="7" height="7" rx="1"/>

                    </svg>

                    <span>
                        Dashboard
                    </span>

                </a>

            </div>


            <!-- MANAGEMENT -->

            <div class="nav-section">

                <div class="nav-title">
                    Management
                </div>


                <!-- Users -->

                <a href="<%= request.getContextPath() %>/admin/users"
                   class="nav-item">

                    <!-- Users SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                        <circle cx="9" cy="7" r="4"/>
                        <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"/>

                    </svg>

                    <span>
                        User Management
                    </span>

                </a>


                <!-- Students -->

                <a href="<%= request.getContextPath() %>/admin/students"
                   class="nav-item">

                    <!-- Student SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M3 9l9-5 9 5-9 5-9-5z"/>
                        <path d="M7 11v5c0 2 3 4 5 4s5-2 5-4v-5"/>
                        <path d="M21 9v6"/>

                    </svg>

                    <span>
                        Student Management
                    </span>

                </a>


                <!-- Faculty -->

                <a href="<%= request.getContextPath() %>/admin/faculties"
                   class="nav-item">

                    <!-- Faculty SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <circle cx="12" cy="8" r="4"/>
                        <path d="M4 21c0-4 3.5-7 8-7s8 3 8 7"/>

                    </svg>

                    <span>
                        Faculty Management
                    </span>

                </a>


                <!-- Departments -->

                <a href="<%= request.getContextPath() %>/admin/departments"
                   class="nav-item">

                    <!-- Department SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M3 21h18"/>
                        <path d="M5 21V8l7-4 7 4v13"/>
                        <path d="M9 21v-4h6v4"/>
                        <path d="M9 10h1"/>
                        <path d="M14 10h1"/>
                        <path d="M9 13h1"/>
                        <path d="M14 13h1"/>

                    </svg>

                    <span>
                        Department Management
                    </span>

                </a>


                <!-- Academic Years -->

                <a href="<%= request.getContextPath() %>/admin/academic-years"
                   class="nav-item">

                    <!-- Calendar SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <rect x="3" y="4" width="18" height="17" rx="2"/>
                        <path d="M16 2v4"/>
                        <path d="M8 2v4"/>
                        <path d="M3 10h18"/>
                        <path d="M8 14h.01"/>
                        <path d="M12 14h.01"/>
                        <path d="M16 14h.01"/>
                        <path d="M8 18h.01"/>
                        <path d="M12 18h.01"/>

                    </svg>

                    <span>
                        Academic Years
                    </span>

                </a>


                <!-- Semesters -->

                <a href="<%= request.getContextPath() %>/admin/semesters"
                   class="nav-item">

                    <!-- Layers SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M12 3l9 5-9 5-9-5 9-5z"/>
                        <path d="M3 12l9 5 9-5"/>
                        <path d="M3 16l9 5 9-5"/>

                    </svg>

                    <span>
                        Semesters
                    </span>

                </a>


                <!-- Classes -->

                <a href="<%= request.getContextPath() %>/admin/classes"
                   class="nav-item">

                    <!-- Class SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <rect x="3" y="4" width="18" height="16" rx="2"/>
                        <path d="M3 9h18"/>
                        <path d="M8 4v5"/>
                        <path d="M16 4v5"/>
                        <path d="M8 13h3"/>
                        <path d="M13 13h3"/>
                        <path d="M8 17h3"/>

                    </svg>

                    <span>
                        Classes
                    </span>

                </a>


                <!-- Subjects -->

                <a href="<%= request.getContextPath() %>/admin/subjects"
                   class="nav-item">

                    <!-- Book SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M4 4h13a3 3 0 0 1 3 3v13H7a3 3 0 0 1-3-3V4z"/>
                        <path d="M7 20V7a3 3 0 0 1 3-3"/>
                        <path d="M10 9h6"/>
                        <path d="M10 13h6"/>

                    </svg>

                    <span>
                        Subjects
                    </span>

                </a>


                <!-- Rooms -->

                <a href="<%= request.getContextPath() %>/admin/rooms"
                   class="nav-item">

                    <!-- Building SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M4 21V4h10v17"/>
                        <path d="M14 8h6v13"/>
                        <path d="M7 8h2"/>
                        <path d="M7 12h2"/>
                        <path d="M7 16h2"/>
                        <path d="M17 12h1"/>
                        <path d="M17 16h1"/>
                        <path d="M8 21v-3h3v3"/>

                    </svg>

                    <span>
                        Rooms
                    </span>

                </a>


                <!-- Periods -->

                <a href="<%= request.getContextPath() %>/admin/periods"
                   class="nav-item">

                    <!-- Clock SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <circle cx="12" cy="12" r="9"/>
                        <path d="M12 7v5l3 2"/>

                    </svg>

                    <span>
                        Periods
                    </span>

                </a>


                <!-- Timetable -->

                <a href="<%= request.getContextPath() %>/admin/timetables"
                   class="nav-item">

                    <!-- Timetable SVG -->
                    <svg class="icon" viewBox="0 0 24 24">

                        <rect x="3" y="4" width="18" height="17" rx="2"/>
                        <path d="M3 10h18"/>
                        <path d="M8 4v17"/>
                        <path d="M13 10v11"/>
                        <path d="M18 10v11"/>

                    </svg>

                    <span>
                        Timetable
                    </span>

                </a>

            </div>

        </div>


        <!-- LOGOUT -->

        <div class="sidebar-footer">

            <a href="<%= request.getContextPath() %>/logout"
               class="nav-item logout">

                <!-- Logout SVG -->
                <svg class="icon" viewBox="0 0 24 24">

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


    <!-- =====================================================
         MAIN CONTENT
         ===================================================== -->

    <main class="main-content">


        <!-- TOP BAR -->

        <header class="topbar">

            <div>

                <h1 class="page-title">
                    Dashboard
                </h1>

                <p class="page-subtitle">
                    Manage your Campus Management System
                </p>

            </div>


            <!-- PROFILE -->

            <div class="profile-box">

                <div class="profile-avatar">
                    <%= email.substring(0, 1).toUpperCase() %>
                </div>

                <div class="profile-info">

                    <div class="profile-email">
                        <%= email %>
                    </div>

                    <div class="profile-role">
                        <%= role %>
                    </div>

                </div>

            </div>

        </header>


        <!-- =================================================
             WELCOME CARD
             ================================================= -->

        <section class="welcome-card">

            <div class="welcome-content">

                <h2 class="welcome-title">
                    Welcome back, Admin
                </h2>

                <p class="welcome-text">
                    Manage users, academic data, resources and
                    timetables from one central dashboard.
                </p>

            </div>

        </section>


        <!-- =================================================
             MANAGEMENT HEADER
             ================================================= -->

        <section class="management-header">

            <h2 class="management-title">
                Management
            </h2>

            <p class="management-subtitle">
                Select a module to manage
            </p>

        </section>


        <!-- =================================================
             MANAGEMENT GRID
             ================================================= -->

        <section class="management-grid">


            <!-- USER MANAGEMENT -->

            <a href="<%= request.getContextPath() %>/admin/users"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
                        <circle cx="9" cy="7" r="4"/>
                        <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
                        <path d="M16 3.13a4 4 0 0 1 0 7.75"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    User Management
                </h3>

                <p class="card-description">
                    Manage system users, roles, passwords and account status.
                </p>

            </a>


            <!-- STUDENT MANAGEMENT -->

            <a href="<%= request.getContextPath() %>/admin/students"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M3 9l9-5 9 5-9 5-9-5z"/>
                        <path d="M7 11v5c0 2 3 4 5 4s5-2 5-4v-5"/>
                        <path d="M21 9v6"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Student Management
                </h3>

                <p class="card-description">
                    Manage student profiles and academic information.
                </p>

            </a>


            <!-- FACULTY MANAGEMENT -->

            <a href="<%= request.getContextPath() %>/admin/faculties"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <circle cx="12" cy="8" r="4"/>
                        <path d="M4 21c0-4 3.5-7 8-7s8 3 8 7"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Faculty Management
                </h3>

                <p class="card-description">
                    Manage faculty accounts, departments and employee details.
                </p>

            </a>


            <!-- DEPARTMENT MANAGEMENT -->

            <a href="<%= request.getContextPath() %>/admin/departments"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M3 21h18"/>
                        <path d="M5 21V8l7-4 7 4v13"/>
                        <path d="M9 21v-4h6v4"/>
                        <path d="M9 10h1"/>
                        <path d="M14 10h1"/>
                        <path d="M9 13h1"/>
                        <path d="M14 13h1"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Department Management
                </h3>

                <p class="card-description">
                    Manage academic departments and department information.
                </p>

            </a>


            <!-- ACADEMIC YEARS -->

            <a href="<%= request.getContextPath() %>/admin/academic-years"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <rect x="3" y="4" width="18" height="17" rx="2"/>
                        <path d="M16 2v4"/>
                        <path d="M8 2v4"/>
                        <path d="M3 10h18"/>
                        <path d="M8 14h.01"/>
                        <path d="M12 14h.01"/>
                        <path d="M16 14h.01"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Academic Years
                </h3>

                <p class="card-description">
                    Manage academic years and their active periods.
                </p>

            </a>


            <!-- SEMESTERS -->

            <a href="<%= request.getContextPath() %>/admin/semesters"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M12 3l9 5-9 5-9-5 9-5z"/>
                        <path d="M3 12l9 5 9-5"/>
                        <path d="M3 16l9 5 9-5"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Semesters
                </h3>

                <p class="card-description">
                    Manage semesters associated with academic years.
                </p>

            </a>


            <!-- CLASSES -->

            <a href="<%= request.getContextPath() %>/admin/classes"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <rect x="3" y="4" width="18" height="16" rx="2"/>
                        <path d="M3 9h18"/>
                        <path d="M8 4v5"/>
                        <path d="M16 4v5"/>
                        <path d="M8 13h3"/>
                        <path d="M13 13h3"/>
                        <path d="M8 17h3"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Classes
                </h3>

                <p class="card-description">
                    Manage classes, sections, departments and semesters.
                </p>

            </a>


            <!-- SUBJECTS -->

            <a href="<%= request.getContextPath() %>/admin/subjects"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M4 4h13a3 3 0 0 1 3 3v13H7a3 3 0 0 1-3-3V4z"/>
                        <path d="M7 20V7a3 3 0 0 1 3-3"/>
                        <path d="M10 9h6"/>
                        <path d="M10 13h6"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Subjects
                </h3>

                <p class="card-description">
                    Manage subjects, credits and subject types.
                </p>

            </a>


            <!-- ROOMS -->

            <a href="<%= request.getContextPath() %>/admin/rooms"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <path d="M4 21V4h10v17"/>
                        <path d="M14 8h6v13"/>
                        <path d="M7 8h2"/>
                        <path d="M7 12h2"/>
                        <path d="M7 16h2"/>
                        <path d="M17 12h1"/>
                        <path d="M17 16h1"/>
                        <path d="M8 21v-3h3v3"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Rooms
                </h3>

                <p class="card-description">
                    Manage classrooms, labs, halls and room capacity.
                </p>

            </a>


            <!-- PERIODS -->

            <a href="<%= request.getContextPath() %>/admin/periods"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <circle cx="12" cy="12" r="9"/>
                        <path d="M12 7v5l3 2"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Periods
                </h3>

                <p class="card-description">
                    Manage timetable periods and class timings.
                </p>

            </a>


            <!-- TIMETABLE -->

            <a href="<%= request.getContextPath() %>/admin/timetables"
               class="management-card">

                <div class="card-icon">

                    <svg class="icon" viewBox="0 0 24 24">

                        <rect x="3" y="4" width="18" height="17" rx="2"/>
                        <path d="M3 10h18"/>
                        <path d="M8 4v17"/>
                        <path d="M13 10v11"/>
                        <path d="M18 10v11"/>

                    </svg>

                </div>

                <div class="card-arrow">

                    <svg class="icon-small" viewBox="0 0 24 24">

                        <path d="M9 18l6-6-6-6"/>

                    </svg>

                </div>

                <h3 class="card-title">
                    Timetable
                </h3>

                <p class="card-description">
                    Create and manage class timetables and schedules.
                </p>

            </a>


        </section>

    </main>

</div>

</body>
</html>