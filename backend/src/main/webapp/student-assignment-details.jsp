<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.cms.model.Student" %>
<%@ page import="com.cms.model.Assignment" %>

<%
    Student student =
            (Student) request.getAttribute("student");

    Assignment assignment =
            (Assignment) request.getAttribute("assignment");

    if (student == null || assignment == null) {

        response.sendRedirect(
                request.getContextPath() + "/calendar"
        );

        return;
    }

    String contextPath =
            request.getContextPath();

    String firstName =
            student.getFirstName() != null
                    ? student.getFirstName()
                    : "Student";

    String initials =
            firstName.substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Assignment Details | Campus CMS</title>


    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
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

            background: #f5f7fc;

            color: #172033;

            min-height: 100vh;
        }


        a {
            text-decoration: none;
        }


        .app {

            display: flex;

            min-height: 100vh;
        }


        /* =====================================================
           SIDEBAR
        ===================================================== */

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

            flex-shrink: 0;

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
        }


        .brand-subtitle {

            font-size: 10px;

            color: #8a94a7;

            margin-top: 4px;
        }


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

            font-size: 13px;

            font-weight: 500;
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
                0 7px 16px
                rgba(79, 70, 229, 0.18);
        }


        .nav-item svg {

            width: 17px;
            height: 17px;

            flex-shrink: 0;
        }


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

            font-size: 13px;

            font-weight: 500;
        }


        .logout:hover {

            background: #fff1f2;
        }


        .logout svg {

            width: 17px;
            height: 17px;
        }



        .nav-item:focus-visible,
        .back-button:focus-visible,
        .notification-button:focus-visible {
            outline: 2px solid #5548e8;
            outline-offset: 2px;
        }

        /* =====================================================
           MAIN
        ===================================================== */

        .main {

            margin-left: 234px;

            width:
                calc(100% - 234px);

            min-height: 100vh;
        }


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
        }


        .page-heading p {

            font-size: 11px;

            color: #7b879b;

            margin-top: 5px;
        }


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
        }


        .user-name {

            font-size: 11px;

            font-weight: 700;
        }


        .user-role {

            font-size: 10px;

            color: #667085;

            margin-top: 3px;
        }


        /* =====================================================
           CONTENT
        ===================================================== */

        .content {

            padding: 27px 29px 35px;
        }


        .back-button {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            font-size: 12px;

            font-weight: 600;

            color: #4f46e5;

            margin-bottom: 18px;
        }


        .back-button:hover {

            color: #3730a3;
        }


        .assignment-card {

            background: #ffffff;

            border: 1px solid #e3e7ef;

            border-radius: 14px;

            padding: 30px;

            width: 100%;

            max-width: 980px;

            box-shadow: 0 4px 18px rgba(15, 23, 42, 0.035);
        }


        .assignment-header {

            display: flex;

            justify-content: space-between;

            align-items: flex-start;

            gap: 20px;

            padding-bottom: 22px;

            border-bottom: 1px solid #edf0f5;
        }


        .assignment-title {

            font-size: 25px;

            font-weight: 700;

            color: #172033;
        }


        .assignment-subject {

            font-size: 13px;

            color: #64748b;

            margin-top: 7px;
        }


        .status {

            display: inline-flex;

            align-items: center;

            padding: 6px 11px;

            border-radius: 20px;

            background: #ecfdf3;

            color: #15803d;

            font-size: 10px;

            font-weight: 700;
        }


        .details-grid {

            display: grid;

            grid-template-columns:
                repeat(2, minmax(0, 1fr));

            gap: 14px;

            margin-top: 24px;
        }


        .detail-box {

            padding: 17px 18px;

            background: #f8f9fc;

            border: 1px solid #e9edf3;

            border-radius: 10px;
        }


        .detail-label {

            font-size: 10px;

            text-transform: uppercase;

            letter-spacing: .7px;

            color: #98a1b2;

            font-weight: 700;
        }


        .detail-value {

            font-size: 13px;

            color: #1f2937;

            font-weight: 600;

            margin-top: 6px;
        }


        .description-section {

            margin-top: 28px;
        }


        .section-title {

            font-size: 13px;

            font-weight: 700;

            margin-bottom: 10px;
        }


        .description {

            background: #fafbfc;

            border: 1px solid #e9edf3;

            border-radius: 10px;

            padding: 20px;

            min-height: 150px;

            font-size: 13px;

            line-height: 1.75;

            color: #475569;

            white-space: pre-wrap;
        }


        .empty-description {

            color: #98a1b2;

            font-style: italic;
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


            .details-grid {

                grid-template-columns: 1fr;
            }
        }


        @media (max-width: 520px) {

            .assignment-card {

                padding: 20px;
            }


            .assignment-header {

                flex-direction: column;
            }


            .assignment-title {

                font-size: 20px;
            }
        }

    </style>

</head>


<body>


<div class="app">


    <!-- SIDEBAR -->

    <aside class="sidebar">


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


        <nav class="nav">


            <div class="nav-section-title">
                Overview
            </div>


            <a href="<%= contextPath %>/dashboard"
               class="nav-item">

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
<a href="<%= contextPath %>/calendar"
               class="nav-item active">

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

                <span>
                    Calendar
                </span>

            </a>


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


        </nav>


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


    <!-- MAIN -->

    <main class="main">


        <header class="topbar">

            <div class="page-heading">

                <h1>
                    Assignment Details
                </h1>

                <p>
                    View assignment information and deadline
                </p>

            </div>


            <div class="topbar-user">

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


                <div class="avatar">
                    <%= initials %>
                </div>


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


        <section class="content">


            <a href="<%= contextPath %>/calendar"
               class="back-button">

                ← Back to Calendar

            </a>


            <div class="assignment-card">


                <div class="assignment-header">

                    <div>

                        <div class="assignment-title">

                            <%= assignment.getTitle() %>

                        </div>


                        <div class="assignment-subject">

                            Assignment Details

                        </div>

                    </div>


                    <div class="status">

                        <%= assignment.getStatus() %>

                    </div>

                </div>


                <div class="details-grid">


                    <div class="detail-box">

                        <div class="detail-label">
                            Deadline
                        </div>

                        <div class="detail-value">

                            <%= assignment.getDeadline() %>

                        </div>

                    </div>


                    <div class="detail-box">

                        <div class="detail-label">
                            Class ID
                        </div>

                        <div class="detail-value">

                            <%= assignment.getClassId() %>

                        </div>

                    </div>


                    <div class="detail-box">

                        <div class="detail-label">
                            Subject ID
                        </div>

                        <div class="detail-value">

                            <%= assignment.getSubjectId() %>

                        </div>

                    </div>


                    <div class="detail-box">

                        <div class="detail-label">
                            Created
                        </div>

                        <div class="detail-value">

                            <%= assignment.getCreatedAt() != null
                                    ? assignment.getCreatedAt()
                                    : "Not available" %>

                        </div>

                    </div>


                </div>


                <div class="description-section">

                    <div class="section-title">
                        Description
                    </div>


                    <div class="description">

                        <%
                            if (assignment.getDescription() != null
                                    && !assignment.getDescription().isBlank()) {
                        %>

                            <%= assignment.getDescription() %>

                        <%
                            } else {
                        %>

                            <span class="empty-description">
                                No description provided.
                            </span>

                        <%
                            }
                        %>

                    </div>

                </div>


            </div>

        </section>

    </main>

</div>

</body>

</html>