<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Faculty" %>

<%
    List<Faculty> faculties =
            (List<Faculty>) request.getAttribute("faculties");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Faculty Management</title>

    <style>

        * {
            box-sizing: border-box;
        }

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
           ADD FACULTY BUTTON
           ========================= */

        .add-faculty-btn {

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


        .add-faculty-btn:hover {

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
           TABLE
           ========================= */

        table {

            width: 100%;

            max-width: 1200px;

            margin: 0 auto;

            border-collapse: collapse;

            background-color: #ffffff;

            border-radius: 12px;

            overflow: hidden;

            box-shadow:
                0 4px 16px
                rgba(15, 23, 42, 0.08);
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

            font-size: 13px;

            text-transform: uppercase;

            letter-spacing: 0.05em;

            padding: 14px 12px;

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

            padding: 12px;

            font-size: 14px;

            color: #334155;

            vertical-align: middle;
        }


        /* =========================
           STATUS
           ========================= */

        .status-active {

            color: #16a34a;

            font-weight: 600;
        }


        .status-inactive {

            color: #dc2626;

            font-weight: 600;
        }


        /* =========================
           ACTION COLUMN
           ========================= */

        .action-cell {

            white-space: nowrap;
        }


        /* =========================
           ACTION LINKS
           ========================= */

        .action-link {

            color: #4f46e5;

            text-decoration: none;

            font-weight: 600;

            font-size: 13px;

            margin-right: 14px;
        }


        .action-link:hover {

            text-decoration: underline;
        }


        /* =========================
           FORMS
           ========================= */

        .status-form,
        .delete-form {

            display: inline-block;

            margin: 0 14px 0 0;
        }


        /* =========================
           STATUS BUTTON
           ========================= */

        .status-btn {

            border: none;

            padding: 6px 14px;

            border-radius: 6px;

            font-size: 13px;

            font-weight: 600;

            cursor: pointer;

            color: #ffffff;

            transition:
                background-color 0.2s ease,
                transform 0.15s ease;
        }


        .status-btn:hover {

            transform: translateY(-1px);
        }


        /* Active faculty -> Deactivate */

        .deactivate-btn {

            background-color: #f59e0b;
        }


        .deactivate-btn:hover {

            background-color: #d97706;
        }


        /* Inactive faculty -> Activate */

        .activate-btn {

            background-color: #16a34a;
        }


        .activate-btn:hover {

            background-color: #15803d;
        }


        /* =========================
           DELETE BUTTON
           ========================= */

        .delete-btn {

            border: none;

            background-color: #ef4444;

            color: #ffffff;

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


            .add-faculty-btn,
            .back-btn {

                text-align: center;
            }


            table {

                display: block;

                overflow-x: auto;

                white-space: nowrap;
            }


            th,
            td {

                padding: 10px;
            }

        }

    </style>

</head>


<body>


    <!-- =========================
         PAGE TITLE
         ========================= -->

    <h1>
        Faculty Management
    </h1>


    <!-- =========================
         TOP ACTION BUTTONS
         ========================= -->

    <div class="top-actions">


        <!-- ADD FACULTY -->

        <a
            class="add-faculty-btn"
            href="<%= request.getContextPath() %>/admin/faculties/create"
        >
            Add Faculty
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
         FACULTY TABLE
         ========================= -->

    <table>

        <thead>

            <tr>

                <th>
                    ID
                </th>

                <th>
                    Employee ID
                </th>

                <th>
                    User ID
                </th>

                <th>
                    Department ID
                </th>

                <th>
                    Status
                </th>

                <th>
                    Created At
                </th>

                <th>
                    Action
                </th>

            </tr>

        </thead>


        <tbody>


        <%
            if (faculties != null && !faculties.isEmpty()) {

                for (Faculty faculty : faculties) {
        %>


            <tr>


                <!-- ID -->

                <td>
                    <%= faculty.getId() %>
                </td>


                <!-- EMPLOYEE ID -->

                <td>
                    <%= faculty.getEmployeeId() %>
                </td>


                <!-- USER ID -->

                <td>
                    <%= faculty.getUserId() %>
                </td>


                <!-- DEPARTMENT ID -->

                <td>
                    <%= faculty.getDepartmentId() %>
                </td>


                <!-- STATUS -->

                <td class="<%= "ACTIVE".equals(faculty.getStatus())
                        ? "status-active"
                        : "status-inactive" %>">

                    <%= faculty.getStatus() %>

                </td>


                <!-- CREATED AT -->

                <td>
                    <%= faculty.getCreatedAt() %>
                </td>


                <!-- ACTIONS -->

                <td class="action-cell">


                    <!-- VIEW -->

                    <a
                        class="action-link"
                        href="<%= request.getContextPath() %>/admin/faculties/view?id=<%= faculty.getId() %>"
                    >
                        View
                    </a>


                    <!-- EDIT -->

                    <a
                        class="action-link"
                        href="<%= request.getContextPath() %>/admin/faculties/edit?id=<%= faculty.getId() %>"
                    >
                        Edit
                    </a>


                    <!-- ACTIVATE / DEACTIVATE -->

                    <%
                        if ("ACTIVE".equals(faculty.getStatus())) {
                    %>

                        <form
                            class="status-form"
                            method="post"
                            action="<%= request.getContextPath() %>/admin/faculties/status"
                        >

                            <input
                                type="hidden"
                                name="id"
                                value="<%= faculty.getId() %>"
                            >

                            <input
                                type="hidden"
                                name="status"
                                value="INACTIVE"
                            >

                            <button
                                type="submit"
                                class="status-btn deactivate-btn"
                            >
                                Deactivate
                            </button>

                        </form>

                    <%
                        } else {
                    %>

                        <form
                            class="status-form"
                            method="post"
                            action="<%= request.getContextPath() %>/admin/faculties/status"
                        >

                            <input
                                type="hidden"
                                name="id"
                                value="<%= faculty.getId() %>"
                            >

                            <input
                                type="hidden"
                                name="status"
                                value="ACTIVE"
                            >

                            <button
                                type="submit"
                                class="status-btn activate-btn"
                            >
                                Activate
                            </button>

                        </form>

                    <%
                        }
                    %>


                    <!-- DELETE -->

                    <form
                        class="delete-form"
                        method="post"
                        action="<%= request.getContextPath() %>/admin/faculties/delete"
                        onsubmit="return confirm('Are you sure you want to permanently delete this faculty?');"
                    >

                        <input
                            type="hidden"
                            name="id"
                            value="<%= faculty.getId() %>"
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

                <td colspan="7">
                    No faculty records found.
                </td>

            </tr>


        <%
            }
        %>


        </tbody>

    </table>


</body>

</html>