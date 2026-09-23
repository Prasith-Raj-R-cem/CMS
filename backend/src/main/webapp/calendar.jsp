<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.cms.model.Student" %>
<%@ page import="com.cms.model.AssignmentSummary" %>
<%@ page import="java.util.List" %>

<%
    Student student =
            (Student) request.getAttribute("student");

    List<AssignmentSummary> assignments =
            (List<AssignmentSummary>)
                    request.getAttribute("assignments");

    if (student == null) {

        response.sendRedirect(
                request.getContextPath() + "/login"
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

    <title>Calendar | Campus CMS</title>


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


        /* =========================================================
           APP
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
                0 6px 15px
                rgba(79, 70, 229, 0.20);
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


        /* =========================================================
           NAV
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

            font-size: 13px;

            font-weight: 500;
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
                0 7px 16px
                rgba(79, 70, 229, 0.18);
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

            font-size: 13px;

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
        }


        .page-heading p {

            font-size: 11px;

            color: #7b879b;

            margin-top: 6px;
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

            cursor: pointer;
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


        /* =========================================================
           CONTENT
        ========================================================= */

        .content {

            padding: 27px 29px 35px;
        }


        /* =========================================================
           CALENDAR HEADER
        ========================================================= */

        .calendar-header {

            background: #ffffff;

            border: 1px solid #e5e8ef;

            border-radius: 12px;

            padding: 20px 22px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            margin-bottom: 18px;
        }


        .calendar-title {

            font-size: 17px;

            font-weight: 700;
        }


        .calendar-description {

            font-size: 11px;

            color: #7b879b;

            margin-top: 6px;
        }


        .today-button {

            border: 1px solid #e0e3eb;

            background: #ffffff;

            color: #4f46e5;

            padding: 8px 13px;

            border-radius: 8px;

            font-size: 10px;

            font-weight: 600;

            cursor: pointer;
        }


        .today-button:hover {

            background: #f4f3ff;
        }


        /* =========================================================
           CALENDAR
        ========================================================= */

        .calendar-card {

            background: #ffffff;

            border: 1px solid #e5e8ef;

            border-radius: 12px;

            overflow: hidden;
        }


        .calendar-toolbar {

            height: 70px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 20px;

            border-bottom: 1px solid #edf0f5;
        }


        .month-title {

            font-size: 15px;

            font-weight: 700;
        }


        .month-controls {

            display: flex;

            gap: 7px;
        }


        .month-button {

            width: 32px;
            height: 32px;

            border: 1px solid #e3e6ee;

            background: #ffffff;

            border-radius: 8px;

            display: flex;

            align-items: center;

            justify-content: center;

            cursor: pointer;

            color: #596579;
        }


        .month-button:hover {

            background: #f5f4ff;

            color: #4f46e5;
        }


        .month-button svg {

            width: 15px;
            height: 15px;
        }


        /* =========================================================
           WEEK DAYS
        ========================================================= */

        .weekdays {

            display: grid;

            grid-template-columns:
                repeat(7, 1fr);

            border-bottom:
                1px solid #edf0f5;
        }


        .weekday {

            height: 42px;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 11px;

            font-weight: 700;

            color: #7b879b;

            text-transform: uppercase;
        }


        /* =========================================================
           CALENDAR GRID
        ========================================================= */

        .calendar-grid {

            display: grid;

            grid-template-columns:
                repeat(7, 1fr);
        }


        .calendar-day {

            min-height: 118px;

            border-right:
                1px solid #edf0f5;

            border-bottom:
                1px solid #edf0f5;

            padding: 11px;

            position: relative;
        }


        .calendar-day:nth-child(7n) {

            border-right: none;
        }


        .day-number {

            width: 25px;
            height: 25px;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 11px;

            font-weight: 600;

            color: #596579;

            border-radius: 50%;
        }


        .calendar-day.today
        .day-number {

            background: #5548e8;

            color: #ffffff;
        }


        .calendar-day.other-month {

            background: #fafbfc;
        }


        .calendar-day.other-month
        .day-number {

            color: #b6bdc9;
        }


        /* =========================================================
           ASSIGNMENT EVENT
        ========================================================= */

        .calendar-event {

            margin-top: 5px;

            padding: 8px 9px;

            border-radius: 6px;

            background: #f0efff;

            border-left:
                3px solid #5548e8;

            overflow: hidden;

            cursor: pointer;

            transition:
                background 0.15s ease,
                transform 0.15s ease,
                box-shadow 0.15s ease;
        }


        .calendar-event:hover {

            background: #e8e6ff;

            transform: translateY(-1px);

            box-shadow:
                0 3px 8px
                rgba(79, 70, 229, 0.12);
        }


        .event-title {

            font-size: 11px;

            font-weight: 700;

            color: #3730a3;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }


        .event-subject {

            font-size: 10px;

            color: #64748b;

            margin-top: 3px;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }



        .calendar-event:focus-visible {
            outline: 2px solid #5548e8;
            outline-offset: 2px;
        }

        /* =========================================================
           EMPTY
        ========================================================= */

        .empty-calendar {

            padding: 70px 20px;

            text-align: center;

            color: #8b95a7;
        }


        .empty-calendar svg {

            width: 35px;
            height: 35px;

            margin-bottom: 10px;
        }


        .empty-calendar p {

            font-size: 12px;
        }


        /* =========================================================
           RESPONSIVE
        ========================================================= */

        @media (max-width: 900px) {

            .calendar-day {

                min-height: 95px;
            }

            .event-subject {

                display: none;
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

            .calendar-day {

                min-height: 70px;

                padding: 5px;
            }


            .day-number {

                width: 21px;
                height: 21px;

                font-size: 9px;
            }


            .calendar-event {

                padding: 4px;

                border-left-width: 2px;
            }


            .event-title {

                font-size: 9px;
            }


            .calendar-header {

                padding: 15px;
            }


            .calendar-title {

                font-size: 15px;
            }


            .calendar-description {

                display: none;
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



        <nav class="nav">


            <div class="nav-section-title">
                Overview
            </div>


            <!-- DASHBOARD -->

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
                 style="margin-top:20px;">

                Academic

            </div>
<!-- CALENDAR -->

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



            <!-- NOTIFICATIONS -->

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
         MAIN
    ========================================================== -->

    <main class="main">


        <!-- TOPBAR -->

        <header class="topbar">


            <div class="page-heading">

                <h1>
                    Calendar
                </h1>

                <p>
                    View your academic deadlines
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



        <!-- =========================================================
             CONTENT
        ========================================================== -->

        <section class="content">


            <!-- CALENDAR HEADER -->

            <div class="calendar-header">


                <div>

                    <div class="calendar-title">

                        Academic Calendar

                    </div>


                    <div class="calendar-description">

                        Assignments and academic deadlines for your class

                    </div>

                </div>



                <button class="today-button"
                        onclick="goToToday()">

                    Today

                </button>


            </div>



            <!-- CALENDAR -->

            <div class="calendar-card">


                <div class="calendar-toolbar">


                    <div id="monthTitle"
                         class="month-title">

                    </div>



                    <div class="month-controls">


                        <button class="month-button"
                                onclick="previousMonth()">

                            <svg
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                stroke-linecap="round"
                                stroke-linejoin="round">

                                <path d="M15 18l-6-6 6-6"/>

                            </svg>

                        </button>



                        <button class="month-button"
                                onclick="nextMonth()">

                            <svg
                                viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="1.8"
                                stroke-linecap="round"
                                stroke-linejoin="round">

                                <path d="M9 18l6-6-6-6"/>

                            </svg>

                        </button>


                    </div>


                </div>



                <!-- WEEK DAYS -->

                <div class="weekdays">

                    <div class="weekday">Sun</div>

                    <div class="weekday">Mon</div>

                    <div class="weekday">Tue</div>

                    <div class="weekday">Wed</div>

                    <div class="weekday">Thu</div>

                    <div class="weekday">Fri</div>

                    <div class="weekday">Sat</div>

                </div>



                <!-- CALENDAR GRID -->

                <div id="calendarGrid"
                     class="calendar-grid">

                </div>


            </div>


        </section>


    </main>


</div>



<script>


    /* =========================================================
       ASSIGNMENT DATA FROM JSP
       
       IMPORTANT:
       Assignment ID has been added so that clicking an
       assignment can open its details page.
    ========================================================= */

    const assignments = [

        <%

            if (assignments != null) {

                for (
                    int i = 0;
                    i < assignments.size();
                    i++
                ) {

                    AssignmentSummary assignment =
                            assignments.get(i);

        %>


        {

            /*
             * Assignment ID
             */

            id:
                <%= assignment.getId() %>,


            /*
             * Assignment title
             */

            title:
                "<%= assignment.getTitle()
                        .replace("\\", "\\\\")
                        .replace("\"", "\\\"")
                        .replace("\n", " ")
                        .replace("\r", " ") %>",


            /*
             * Subject name
             */

            subject:
                "<%= assignment.getSubjectName() != null
                        ? assignment.getSubjectName()
                            .replace("\\", "\\\\")
                            .replace("\"", "\\\"")
                            .replace("\n", " ")
                            .replace("\r", " ")
                        : "" %>",


            /*
             * Deadline
             */

            deadline:
                "<%= assignment.getDeadline() != null
                        ? assignment.getDeadline()
                        : "" %>"

        }


        <%

                    if (
                        i < assignments.size() - 1
                    ) {

        %>

        ,

        <%

                    }

                }

            }

        %>

    ];



    /* =========================================================
       CALENDAR STATE
    ========================================================= */

    let currentDate = new Date();



    /* =========================================================
       RENDER CALENDAR
    ========================================================= */

    function renderCalendar() {


        const year =
            currentDate.getFullYear();


        const month =
            currentDate.getMonth();



        const monthNames = [

            "January",

            "February",

            "March",

            "April",

            "May",

            "June",

            "July",

            "August",

            "September",

            "October",

            "November",

            "December"

        ];



        document.getElementById("monthTitle")
            .textContent =
                monthNames[month] +
                " " +
                year;



        const firstDay =
            new Date(
                year,
                month,
                1
            ).getDay();



        const daysInMonth =
            new Date(
                year,
                month + 1,
                0
            ).getDate();



        const previousMonthDays =
            new Date(
                year,
                month,
                0
            ).getDate();



        const grid =
            document.getElementById(
                "calendarGrid"
            );



        grid.innerHTML = "";



        /*
         * Previous month's visible days
         */

        for (
            let i = firstDay - 1;
            i >= 0;
            i--
        ) {


            const day =
                previousMonthDays - i;


            createDay(
                grid,
                day,
                true,
                year,
                month - 1
            );

        }



        /*
         * Current month's days
         */

        for (
            let day = 1;
            day <= daysInMonth;
            day++
        ) {


            createDay(
                grid,
                day,
                false,
                year,
                month
            );

        }



        /*
         * Next month's visible days
         */

        const totalCells =
            grid.children.length;


        const remaining =
            42 - totalCells;



        for (
            let day = 1;
            day <= remaining;
            day++
        ) {


            createDay(
                grid,
                day,
                true,
                year,
                month + 1
            );

        }

    }



    /* =========================================================
       CREATE DAY
    ========================================================= */

    function createDay(
        grid,
        day,
        otherMonth,
        year,
        month
    ) {


        const cell =
            document.createElement("div");



        cell.className =
            "calendar-day";



        if (otherMonth) {

            cell.classList.add(
                "other-month"
            );

        }



        const number =
            document.createElement("div");



        number.className =
            "day-number";



        number.textContent =
            day;



        cell.appendChild(number);



        /*
         * Today's date
         */

        const today =
            new Date();



        if (

            !otherMonth &&

            day === today.getDate() &&

            month === today.getMonth() &&

            year === today.getFullYear()

        ) {

            cell.classList.add("today");

        }



        /*
         * Assignment events
         */

        const cellDate =
            new Date(
                year,
                month,
                day
            );



        assignments.forEach(
            function(assignment) {


                if (!assignment.deadline) {

                    return;

                }



                const deadline =
                    new Date(
                        assignment.deadline
                    );



                if (

                    deadline.getFullYear()
                        === cellDate.getFullYear()

                    &&

                    deadline.getMonth()
                        === cellDate.getMonth()

                    &&

                    deadline.getDate()
                        === cellDate.getDate()

                ) {


                    const event =
                        document.createElement(
                            "div"
                        );


                    event.className =
                        "calendar-event";



                    const title =
                        document.createElement(
                            "div"
                        );


                    title.className =
                        "event-title";


                    title.textContent =
                        assignment.title;



                    const subject =
                        document.createElement(
                            "div"
                        );


                    subject.className =
                        "event-subject";


                    subject.textContent =
                        assignment.subject;



                    event.appendChild(title);

                    event.appendChild(subject);



                    /*
                     * =================================================
                     * CLICK ASSIGNMENT
                     *
                     * Opens:
                     *
                     * /student/assignments/view?id=ASSIGNMENT_ID
                     * =================================================
                     */

                    event.addEventListener(
                        "click",
                        function () {

                            window.location.href =
                                "<%= contextPath %>"
                                + "/student/assignments/view?id="
                                + encodeURIComponent(
                                    assignment.id
                                );

                        }
                    );



                    /*
                     * Accessibility
                     */

                    event.setAttribute(
                        "role",
                        "button"
                    );


                    event.setAttribute(
                        "tabindex",
                        "0"
                    );


                    event.setAttribute(
                        "title",
                        "Open assignment: "
                        + assignment.title
                    );



                    /*
                     * Allow Enter key to open assignment
                     */

                    event.addEventListener(
                        "keydown",
                        function (eventObject) {

                            if (
                                eventObject.key === "Enter" ||
                                eventObject.key === " "
                            ) {

                                eventObject.preventDefault();

                                window.location.href =
                                    "<%= contextPath %>"
                                    + "/student/assignments/view?id="
                                    + encodeURIComponent(
                                        assignment.id
                                    );

                            }

                        }
                    );



                    cell.appendChild(event);

                }

            }
        );



        grid.appendChild(cell);

    }



    /* =========================================================
       PREVIOUS MONTH
    ========================================================= */

    function previousMonth() {

        currentDate.setMonth(
            currentDate.getMonth() - 1
        );

        renderCalendar();

    }



    /* =========================================================
       NEXT MONTH
    ========================================================= */

    function nextMonth() {

        currentDate.setMonth(
            currentDate.getMonth() + 1
        );

        renderCalendar();

    }



    /* =========================================================
       TODAY
    ========================================================= */

    function goToToday() {

        currentDate =
            new Date();

        renderCalendar();

    }



    /* =========================================================
       INITIALIZE
    ========================================================= */

    renderCalendar();


</script>


</body>

</html>