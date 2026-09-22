<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.User" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>User Management</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 40px 24px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, #f4f6fb 0%, #e9edf5 100%);
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
           TOP BUTTON AREA
           ========================= */

        .top-actions {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto 26px auto;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* =========================
           ADD USER BUTTON
           ========================= */

        .add-user-btn {
            display: inline-block;

            background-color: #4f46e5;
            color: #ffffff;

            text-decoration: none;

            padding: 10px 20px;

            border-radius: 8px;

            font-weight: 600;
            font-size: 14px;

            box-shadow: 0 2px 6px rgba(79, 70, 229, 0.35);

            transition:
                background-color 0.2s ease,
                transform 0.2s ease;
        }

        .add-user-btn:hover {
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

            box-shadow: 0 2px 6px rgba(100, 116, 139, 0.30);

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
            max-width: 1000px;

            margin: 0 auto;

            border-collapse: collapse;

            background-color: #ffffff;

            border-radius: 12px;

            overflow: hidden;

            box-shadow:
                0 4px 16px rgba(15, 23, 42, 0.08);
        }

        /* =========================
           TABLE HEADER
           ========================= */

        thead {
            background: linear-gradient(
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
            font-weight: 600;
            color: #16a34a;
        }

        .status-inactive {
            font-weight: 600;
            color: #dc2626;
        }

        /* =========================
           EDIT LINK
           ========================= */

        td a.edit-link {
            color: #4f46e5;

            text-decoration: none;

            font-weight: 600;

            font-size: 13px;

            margin-right: 10px;
        }

        td a.edit-link:hover {
            text-decoration: underline;
        }

        /* =========================
           STATUS FORM
           ========================= */

        .status-form {
            display: inline-block;
            margin: 0;
        }

        /* =========================
           DEACTIVATE / ACTIVATE
           ========================= */

        .status-btn {
            background-color: #f59e0b;

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

        .status-btn:hover {
            background-color: #d97706;

            transform: translateY(-1px);
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 768px) {

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

            .add-user-btn,
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

    <h1>User Management</h1>


    <!-- =========================
         TOP ACTION BUTTONS
         ========================= -->

    <div class="top-actions">

        <!-- Add User -->

        <a
            class="add-user-btn"
            href="<%= request.getContextPath() %>/admin/users/create"
        >
            Add User
        </a>


        <!-- Back to Admin Dashboard -->

        <a
            class="back-btn"
            href="<%= request.getContextPath() %>/admin/dashboard"
        >
            Back to Admin Dashboard
        </a>

    </div>


    <!-- =========================
         USER TABLE
         ========================= -->

    <table>

        <thead>

            <tr>

                <th>ID</th>

                <th>Email</th>

                <th>Role</th>

                <th>Status</th>

                <th>Action</th>

            </tr>

        </thead>


        <tbody>

        <%
            List<User> users =
                    (List<User>) request.getAttribute("users");

            if (users != null) {

                for (User user : users) {
        %>

            <tr>

                <!-- ID -->

                <td>
                    <%= user.getId() %>
                </td>


                <!-- EMAIL -->

                <td>
                    <%= user.getEmail() %>
                </td>


                <!-- ROLE -->

                <td>
                    <%= user.getRole() %>
                </td>


                <!-- STATUS -->

                <td class="<%= "ACTIVE".equals(user.getStatus())
                        ? "status-active"
                        : "status-inactive" %>">

                    <%= user.getStatus() %>

                </td>


                <!-- ACTION -->

                <td>

                    <!-- EDIT -->

                    <a
                        class="edit-link"
                        href="<%= request.getContextPath() %>/admin/users/edit?id=<%= user.getId() %>"
                    >
                        Edit
                    </a>


                    <!-- ACTIVATE / DEACTIVATE -->

                    <form
                        class="status-form"
                        method="post"
                        action="<%= request.getContextPath() %>/admin/users/status"
                    >

                        <input
                            type="hidden"
                            name="id"
                            value="<%= user.getId() %>"
                        >


                        <input
                            type="hidden"
                            name="status"
                            value="<%= "ACTIVE".equals(user.getStatus())
                                    ? "INACTIVE"
                                    : "ACTIVE" %>"
                        >


                        <button
                            type="submit"
                            class="status-btn"
                        >

                            <%= "ACTIVE".equals(user.getStatus())
                                    ? "Deactivate"
                                    : "Activate" %>

                        </button>

                    </form>

                </td>

            </tr>

        <%
                }

            }
        %>

        </tbody>

    </table>

</body>

</html>