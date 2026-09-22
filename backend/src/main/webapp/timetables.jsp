<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.TimetableDetails" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Timetable Management</title>

    <style>

        * {
            box-sizing: border-box;
        }


        /* =========================
           PAGE
           ========================= */

        body {
            margin: 0;
            padding: 40px 24px;

            font-family:
                'Segoe UI',
                Roboto,
                Helvetica,
                Arial,
                sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #f4f6fb 0%,
                    #e9edf5 100%
                );

            color: #1f2937;
        }


        /* =========================
           PAGE TITLE
           ========================= */

        h1 {
            text-align: center;

            font-size: 28px;

            font-weight: 700;

            color: #1e293b;

            margin: 0 0 35px 0;
        }


        /* =========================
           TOP ACTIONS
           ========================= */

        .top-actions {

            width: 100%;

            max-width: 1200px;

            margin: 0 auto 26px auto;

            display: flex;

            justify-content: space-between;

            align-items: center;
        }


        /* =========================
           ADD TIMETABLE BUTTON
           ========================= */

        .add-timetable-btn {

            display: inline-block;

            background-color: #4f46e5;

            color: #ffffff;

            text-decoration: none;

            padding: 10px 20px;

            border-radius: 8px;

            font-weight: 600;

            font-size: 14px;

            box-shadow:
                0 2px 6px
                rgba(79, 70, 229, 0.35);

            transition:
                background-color 0.2s ease,
                transform 0.2s ease;
        }


        .add-timetable-btn:hover {

            background-color: #4338ca;

            transform: translateY(-1px);
        }


        /* =========================
           BACK BUTTON
           ========================= */

        .back-btn {

            display: inline-block;

            background-color: #64748b;

            color: #ffffff;

            text-decoration: none;

            padding: 10px 20px;

            border-radius: 8px;

            font-weight: 600;

            font-size: 14px;

            box-shadow:
                0 2px 6px
                rgba(100, 116, 139, 0.30);

            transition:
                background-color 0.2s ease,
                transform 0.2s ease;
        }


        .back-btn:hover {

            background-color: #475569;

            transform: translateY(-1px);
        }


        /* =========================
           TABLE WRAPPER
           ========================= */

        .table-container {

            width: 100%;

            max-width: 1200px;

            margin: 0 auto;

            overflow-x: auto;

            border-radius: 12px;

            box-shadow:
                0 4px 16px
                rgba(15, 23, 42, 0.08);
        }


        /* =========================
           TABLE
           ========================= */

        table {

            width: 100%;

            min-width: 1150px;

            border-collapse: collapse;

            background-color: #ffffff;

            border-radius: 12px;

            overflow: hidden;
        }


        /* =========================
           TABLE HEADER
           ========================= */

        thead {

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #6366f1
                );
        }


        th {

            color: #ffffff;

            font-size: 12px;

            text-transform: uppercase;

            letter-spacing: 0.04em;

            padding: 14px 10px;

            text-align: left;

            white-space: nowrap;
        }


        /* =========================
           TABLE BODY
           ========================= */

        tbody tr {

            border-bottom: 1px solid #eef0f5;

            transition:
                background-color 0.15s ease;
        }


        tbody tr:last-child {

            border-bottom: none;
        }


        tbody tr:nth-child(even) {

            background-color: #f9fafc;
        }


        tbody tr:hover {

            background-color: #eef2ff;
        }


        /* =========================
           TABLE CELLS
           ========================= */

        td {

            padding: 12px 10px;

            font-size: 13px;

            color: #334155;

            vertical-align: middle;
        }


        /* =========================
           STRONG VALUES
           ========================= */

        td strong {

            color: #1e293b;

            font-weight: 600;
        }


        /* =========================
           MULTI-LINE INFORMATION
           ========================= */

        .secondary-text {

            display: block;

            margin-top: 3px;

            color: #94a3b8;

            font-size: 11px;
        }


        /* =========================
           DAY
           ========================= */

        .day-text {

            font-weight: 600;

            color: #334155;
        }


        /* =========================
           PERIOD
           ========================= */

        .period-number {

            display: inline-block;

            margin-bottom: 3px;

            color: #4f46e5;

            font-weight: 700;
        }


        /* =========================
           STATUS
           ========================= */

        .status-active {

            display: inline-block;

            padding: 5px 9px;

            border-radius: 6px;

            background-color: #dcfce7;

            color: #15803d;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;
        }


        .status-inactive {

            display: inline-block;

            padding: 5px 9px;

            border-radius: 6px;

            background-color: #fee2e2;

            color: #dc2626;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;
        }


        /* =========================
           ACTION COLUMN
           ========================= */

        .action-cell {

            white-space: nowrap;
        }


        /* =========================
           EDIT LINK
           ========================= */

        .edit-link {

            color: #4f46e5;

            text-decoration: none;

            font-weight: 600;

            font-size: 13px;

            margin-right: 14px;
        }


        .edit-link:hover {

            text-decoration: underline;
        }


        /* =========================
           DELETE FORM
           ========================= */

        .delete-form {

            display: inline-block;

            margin: 0;
        }


        /* =========================
           DELETE BUTTON
           ========================= */

        .delete-btn {

            background-color: #ef4444;

            color: #ffffff;

            border: none;

            padding: 6px 14px;

            border-radius: 6px;

            font-size: 13px;

            font-weight: 600;

            cursor: pointer;

            transition:
                background-color 0.2s ease,
                transform 0.15s ease;
        }


        .delete-btn:hover {

            background-color: #dc2626;

            transform: translateY(-1px);
        }


        /* =========================
           EMPTY STATE
           ========================= */

        .empty-row td {

            text-align: center;

            padding: 24px;

            font-style: italic;

            color: #94a3b8;
        }


        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 900px) {

            body {

                padding: 25px 12px;
            }


            h1 {

                font-size: 24px;

                margin-bottom: 25px;
            }


            .top-actions {

                flex-direction: column;

                align-items: stretch;

                gap: 12px;
            }


            .add-timetable-btn,
            .back-btn {

                text-align: center;
            }


            .table-container {

                border-radius: 10px;
            }

        }

    </style>

</head>


<body>


    <!-- =========================
         PAGE TITLE
         ========================= -->

    <h1>
        Timetable Management
    </h1>


    <!-- =========================
         TOP ACTIONS
         ========================= -->

    <div class="top-actions">


        <!-- ADD TIMETABLE -->

        <a
            class="add-timetable-btn"
            href="<%= request.getContextPath() %>/admin/timetables/create"
        >
            Add Timetable
        </a>


        <!-- BACK TO DASHBOARD -->

        <a
            class="back-btn"
            href="<%= request.getContextPath() %>/admin/dashboard"
        >
            Back to Admin Dashboard
        </a>


    </div>


    <!-- =========================
         TABLE
         ========================= -->

    <div class="table-container">

        <table>


            <thead>

                <tr>

                    <th>
                        ID
                    </th>

                    <th>
                        Class
                    </th>

                    <th>
                        Subject
                    </th>

                    <th>
                        Faculty
                    </th>

                    <th>
                        Day
                    </th>

                    <th>
                        Period
                    </th>

                    <th>
                        Room
                    </th>

                    <th>
                        Academic Year
                    </th>

                    <th>
                        Semester
                    </th>

                    <th>
                        Status
                    </th>

                    <th>
                        Actions
                    </th>

                </tr>

            </thead>


            <tbody>


            <%
                List<TimetableDetails> timetables =
                        (List<TimetableDetails>)
                        request.getAttribute("timetables");

                if (timetables != null && !timetables.isEmpty()) {

                    for (TimetableDetails timetable : timetables) {
            %>


                <tr>


                    <!-- ID -->

                    <td>
                        <%= timetable.getId() %>
                    </td>


                    <!-- CLASS -->

                    <td>

                        <strong>
                            <%= timetable.getClassName() %>
                        </strong>

                        <%
                            if (timetable.getSection() != null &&
                                !timetable.getSection().isBlank()) {
                        %>

                            <span class="secondary-text">
                                Section <%= timetable.getSection() %>
                            </span>

                        <%
                            }
                        %>

                    </td>


                    <!-- SUBJECT -->

                    <td>

                        <strong>
                            <%= timetable.getSubjectCode() %>
                        </strong>

                        <span class="secondary-text">
                            <%= timetable.getSubjectName() %>
                        </span>

                    </td>


                    <!-- FACULTY -->

                    <td>
                        <strong>
                            <%= timetable.getEmployeeId() %>
                        </strong>
                    </td>


                    <!-- DAY -->

                    <td>

                        <span class="day-text">
                            <%= timetable.getDayOfWeek() %>
                        </span>

                    </td>


                    <!-- PERIOD -->

                    <td>

                        <strong class="period-number">
                            P<%= timetable.getPeriodNumber() %>
                        </strong>

                        <span class="secondary-text">

                            <%= timetable.getStartTime() %>
                            -
                            <%= timetable.getEndTime() %>

                        </span>

                    </td>


                    <!-- ROOM -->

                    <td>

                        <%
                            if (timetable.getRoomNumber() == null ||
                                timetable.getRoomNumber().isBlank()) {
                        %>

                            <span class="secondary-text">
                                No Room
                            </span>

                        <%
                            } else {
                        %>

                            <strong>
                                <%= timetable.getRoomNumber() %>
                            </strong>

                            <%
                                if (timetable.getBuilding() != null &&
                                    !timetable.getBuilding().isBlank()) {
                            %>

                                <span class="secondary-text">
                                    <%= timetable.getBuilding() %>
                                </span>

                            <%
                                }
                            %>

                        <%
                            }
                        %>

                    </td>


                    <!-- ACADEMIC YEAR -->

                    <td>
                        <%= timetable.getAcademicYear() %>
                    </td>


                    <!-- SEMESTER -->

                    <td>
                        <%= timetable.getSemesterName() %>
                    </td>


                    <!-- STATUS -->

                    <td>

                        <%
                            if ("ACTIVE".equals(timetable.getStatus())) {
                        %>

                            <span class="status-active">
                                ACTIVE
                            </span>

                        <%
                            } else {
                        %>

                            <span class="status-inactive">
                                <%= timetable.getStatus() %>
                            </span>

                        <%
                            }
                        %>

                    </td>


                    <!-- ACTIONS -->

                    <td class="action-cell">


                        <!-- EDIT -->

                        <a
                            class="edit-link"
                            href="<%= request.getContextPath() %>/admin/timetables/edit?id=<%= timetable.getId() %>"
                        >
                            Edit
                        </a>


                        <!-- DELETE -->

                        <form
                            class="delete-form"
                            method="post"
                            action="<%= request.getContextPath() %>/admin/timetables/delete"
                            onsubmit="return confirm('Are you sure you want to delete this timetable?');"
                        >

                            <input
                                type="hidden"
                                name="id"
                                value="<%= timetable.getId() %>"
                            >


                            <button
                                type="submit"
                                class="delete-btn"
                            >
                                Delete
                            </button>

                        </form>


                    </td>


                </tr>


            <%
                    }

                } else {
            %>


                <!-- EMPTY STATE -->

                <tr class="empty-row">

                    <td colspan="11">
                        No timetable entries found.
                    </td>

                </tr>


            <%
                }
            %>


            </tbody>


        </table>

    </div>


</body>

</html>