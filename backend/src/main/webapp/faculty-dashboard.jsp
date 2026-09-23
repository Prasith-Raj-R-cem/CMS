<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.cms.model.User" %>

<%
    User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Faculty Dashboard | Campus CMS</title>


    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        /* =========================
           BODY
           ========================= */

        body {

            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                sans-serif;

            background: #f8fafc;

            color: #111827;
        }


        /* =========================
           LAYOUT
           ========================= */

        .layout {

            display: flex;

            min-height: 100vh;
        }


        /* =========================
           SIDEBAR
           ========================= */

        .sidebar {

            width: 260px;

            background: white;

            border-right: 1px solid #e5e7eb;

            position: fixed;

            left: 0;
            top: 0;
            bottom: 0;

            display: flex;

            flex-direction: column;

            z-index: 10;
        }


        /* =========================
           BRAND
           ========================= */

        .brand {

            height: 82px;

            display: flex;

            align-items: center;

            gap: 12px;

            padding: 0 25px;

            border-bottom: 1px solid #f1f5f9;
        }


        .brand-icon {

            width: 40px;
            height: 40px;

            border-radius: 11px;

            display: flex;

            align-items: center;
            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            color: white;
        }


        .brand-text h2 {

            font-size: 17px;

            color: #312e81;
        }


        .brand-text span {

            display: block;

            font-size: 11px;

            color: #9ca3af;

            margin-top: 2px;
        }


        /* =========================
           NAVIGATION
           ========================= */

        .nav {

            padding: 25px 14px;

            flex: 1;
        }


        .nav-title {

            font-size: 11px;

            text-transform: uppercase;

            letter-spacing: .08em;

            color: #9ca3af;

            font-weight: 700;

            padding: 0 12px 10px;
        }


        .nav-item {

            display: flex;

            align-items: center;

            gap: 12px;

            padding: 12px 13px;

            margin-bottom: 5px;

            border-radius: 10px;

            text-decoration: none;

            color: #6b7280;

            font-size: 14px;

            font-weight: 600;

            transition: .2s;
        }


        .nav-item:hover {

            background: #eef2ff;

            color: #4f46e5;
        }


        .nav-item.active {

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #f5f3ff
                );

            color: #4f46e5;
        }


        .nav-icon {

            width: 19px;
            height: 19px;

            flex-shrink: 0;
        }


        /* =========================
           SIDEBAR FOOTER
           ========================= */

        .sidebar-footer {

            padding: 18px;

            border-top: 1px solid #f1f5f9;
        }


        .logout {

            display: flex;

            align-items: center;

            gap: 10px;

            text-decoration: none;

            color: #ef4444;

            font-size: 14px;

            font-weight: 600;

            padding: 11px 12px;

            border-radius: 10px;
        }


        .logout:hover {

            background: #fef2f2;
        }


        /* =========================
           MAIN
           ========================= */

        .main {

            margin-left: 260px;

            width: calc(100% - 260px);

            min-height: 100vh;
        }


        /* =========================
           TOPBAR
           ========================= */

        .topbar {

            height: 82px;

            background: white;

            border-bottom: 1px solid #e5e7eb;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 35px;
        }


        .topbar-title h1 {

            font-size: 20px;

            color: #111827;
        }


        .profile {

            display: flex;

            align-items: center;

            gap: 11px;
        }


        .avatar {

            width: 38px;
            height: 38px;

            border-radius: 50%;

            display: flex;

            align-items: center;
            justify-content: center;

            color: white;

            font-weight: 700;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );
        }


        .profile-info {

            text-align: right;
        }


        .profile-info strong {

            display: block;

            font-size: 13px;
        }


        .profile-info span {

            font-size: 11px;

            color: #9ca3af;
        }


        /* =========================
           CONTENT
           ========================= */

        .content {

            padding: 35px;
        }


        /* =========================
           WELCOME
           ========================= */

        .welcome {

            border-radius: 20px;

            padding: 30px;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #4338ca,
                    #6d28d9
                );

            box-shadow:
                0 15px 35px
                rgba(79, 70, 229, .18);

            margin-bottom: 30px;

            position: relative;

            overflow: hidden;
        }


        .welcome h2 {

            font-size: 26px;

            margin-bottom: 8px;
        }


        /* =========================
           SECTION TITLE
           ========================= */

        .section-title {

            font-size: 17px;

            font-weight: 750;

            margin-bottom: 17px;

            color: #1f2937;
        }


        /* =========================
           CARDS
           ========================= */

        .cards {

            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 18px;

            max-width: 1000px;
        }


        .card {

            background: white;

            border: 1px solid #e5e7eb;

            border-radius: 17px;

            padding: 22px;

            text-decoration: none;

            color: inherit;

            transition:
                transform .2s,
                box-shadow .2s;
        }


        .card:hover {

            transform: translateY(-3px);

            box-shadow:
                0 15px 30px
                rgba(15, 23, 42, .08);
        }


        .card-icon {

            width: 43px;
            height: 43px;

            border-radius: 12px;

            background: #eef2ff;

            color: #4f46e5;

            display: flex;

            align-items: center;
            justify-content: center;

            margin-bottom: 16px;
        }


        .card h3 {

            font-size: 15px;

            margin-bottom: 5px;
        }


        .card p {

            font-size: 12px;

            color: #9ca3af;

            line-height: 1.5;
        }


        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 1050px) {

            .cards {

                grid-template-columns:
                    repeat(2, 1fr);
            }
        }


        @media (max-width: 750px) {

            .sidebar {

                width: 75px;
            }


            .brand-text,
            .nav-title,
            .nav-item span,
            .logout span {

                display: none;
            }


            .brand {

                justify-content: center;

                padding: 0;
            }


            .nav-item {

                justify-content: center;
            }


            .main {

                margin-left: 75px;

                width: calc(100% - 75px);
            }


            .topbar {

                padding: 0 20px;
            }


            .content {

                padding: 20px;
            }


            .profile-info {

                display: none;
            }
        }


        @media (max-width: 550px) {

            .cards {

                grid-template-columns: 1fr;
            }
        }

    </style>

</head>


<body>


<div class="layout">


    <!-- =========================
         SIDEBAR
         ========================= -->

    <aside class="sidebar">


        <!-- BRAND -->

        <div class="brand">

            <div class="brand-icon">

                <svg width="22"
                     height="22"
                     viewBox="0 0 24 24"
                     fill="none"
                     stroke="currentColor"
                     stroke-width="2">

                    <path d="M3 10l9-6 9 6"/>
                    <path d="M5 10v10h14V10"/>
                    <path d="M9 20v-6h6v6"/>

                </svg>

            </div>


            <div class="brand-text">

                <h2>Campus CMS</h2>

                <span>Faculty Portal</span>

            </div>

        </div>


        <!-- NAVIGATION -->

        <nav class="nav">


            <div class="nav-title">
                Overview
            </div>


            <!-- DASHBOARD -->

            <a
                href="<%= request.getContextPath() %>/faculty/dashboard"
                class="nav-item active"
            >

                <svg
                    class="nav-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                >

                    <rect x="3"
                          y="3"
                          width="7"
                          height="7"/>

                    <rect x="14"
                          y="3"
                          width="7"
                          height="7"/>

                    <rect x="3"
                          y="14"
                          width="7"
                          height="7"/>

                    <rect x="14"
                          y="14"
                          width="7"
                          height="7"/>

                </svg>

                <span>Dashboard</span>

            </a>


            <!-- ACADEMIC -->

            <div
                class="nav-title"
                style="margin-top:25px;"
            >
                Academic
            </div>


            <!-- CREATE ASSIGNMENT -->

            <a
                href="<%= request.getContextPath() %>/faculty/assignments/create"
                class="nav-item"
            >

                <svg
                    class="nav-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                >

                    <path d="M4 4h16v16H4z"/>

                    <path d="M8 8h8M8 12h6M8 16h4"/>

                </svg>

                <span>Create Assignment</span>

            </a>


            <!-- MY ASSIGNMENTS -->

            <a
    href="<%= request.getContextPath() %>/faculty/assignments"
    class="nav-item"
>

                <svg
                    class="nav-icon"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                >

                    <rect x="3"
                          y="4"
                          width="18"
                          height="17"
                          rx="2"/>

                    <path d="M8 2v4M16 2v4M3 10h18"/>

                </svg>

                <span>My Assignments</span>

            </a>


        </nav>


        <!-- LOGOUT -->

        <div class="sidebar-footer">

            <a
                href="<%= request.getContextPath() %>/logout"
                class="logout"
            >

                <svg
                    width="19"
                    height="19"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                >

                    <path
                        d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"
                    />

                    <path
                        d="M16 17l5-5-5-5"
                    />

                    <path
                        d="M21 12H9"
                    />

                </svg>

                <span>Logout</span>

            </a>

        </div>


    </aside>


    <!-- =========================
         MAIN CONTENT
         ========================= -->

    <main class="main">


        <!-- TOPBAR -->

        <header class="topbar">


            <div class="topbar-title">

                <h1>
                    Dashboard
                </h1>

            </div>


            <div class="profile">


                <div class="profile-info">

                    <strong>

                        <%= user != null
                                ? user.getEmail()
                                : "Faculty" %>

                    </strong>

                    <span>
                        FACULTY
                    </span>

                </div>


                <div class="avatar">
                    F
                </div>


            </div>

        </header>


        <!-- CONTENT -->

        <section class="content">


            <!-- WELCOME -->

            <div class="welcome">

                <h2>
                    Welcome back, Faculty
                </h2>

            </div>


            <!-- SECTION -->

            <h2 class="section-title">
                Academic Management
            </h2>


            <!-- CARDS -->

            <div class="cards">


                <!-- CREATE ASSIGNMENT -->

                <a
                    href="<%= request.getContextPath() %>/faculty/assignments/create"
                    class="card"
                >

                    <div class="card-icon">

                        <svg
                            width="22"
                            height="22"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                        >

                            <path d="M12 5v14"/>

                            <path d="M5 12h14"/>

                        </svg>

                    </div>


                    <h3>
                        Create Assignment
                    </h3>


                    <p>
                        Publish a new assignment with
                        a submission deadline.
                    </p>

                </a>


                <!-- MY ASSIGNMENTS -->

                <a
    href="<%= request.getContextPath() %>/faculty/assignments"
    class="card"
>

                    <div class="card-icon">

                        <svg
                            width="22"
                            height="22"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                        >

                            <rect
                                x="4"
                                y="4"
                                width="16"
                                height="16"
                            />

                            <path d="M8 8h8"/>

                            <path d="M8 12h8"/>

                            <path d="M8 16h5"/>

                        </svg>

                    </div>


                    <h3>
                        My Assignments
                    </h3>


                    <p>
                        View and manage assignments
                        created for your classes.
                    </p>

                </a>


            </div>


        </section>


    </main>


</div>


</body>

</html>