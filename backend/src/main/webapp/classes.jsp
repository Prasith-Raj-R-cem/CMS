<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Class" %>

<%
    List<Class> classes =
            (List<Class>) request.getAttribute("classes");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Class Management</title>

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

        h1 {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 8px;
        }

        .top-buttons {
            max-width: 1200px;
            margin: 25px auto 0;
            display: flex;
            justify-content: space-between;
        }

        .top-buttons a {
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            color: #ffffff;
        }

        .add-button {
            background-color: #4f46e5;
            box-shadow: 0 2px 6px rgba(79, 70, 229, 0.35);
        }

        .dashboard-button {
            background-color: #64748b;
            box-shadow: 0 2px 6px rgba(100, 116, 139, 0.35);
        }

        table {
            width: 100%;
            max-width: 1200px;
            margin: 30px auto 0;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.08);
        }

        thead {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
        }

        th {
            color: #ffffff;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 10px;
            text-align: left;
        }

        td {
            padding: 12px 10px;
            font-size: 14px;
            color: #334155;
            vertical-align: middle;
        }

        tbody tr {
            border-bottom: 1px solid #eef0f5;
        }

        tbody tr:nth-child(even) {
            background-color: #f9fafc;
        }

        tbody tr:hover {
            background-color: #eef2ff;
        }

        .edit-link {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
            margin-right: 10px;
        }

        form {
            display: inline;
        }

        button {
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            color: #ffffff;
            cursor: pointer;
        }

        .activate-button {
            background-color: #16a34a;
        }

        .deactivate-button {
            background-color: #f59e0b;
        }

        .delete-button {
            background-color: #ef4444;
        }

        .empty-message {
            text-align: center;
            padding: 25px;
            color: #94a3b8;
            font-style: italic;
        }

    </style>

</head>

<body>

<h1>Class Management</h1>


<div class="top-buttons">

    <a class="add-button"
       href="<%= request.getContextPath() %>/admin/classes/create">

        Add Class

    </a>


    <a class="dashboard-button"
       href="<%= request.getContextPath() %>/admin/dashboard">

        Back to Admin Dashboard

    </a>

</div>


<table>

    <thead>

        <tr>

            <th>ID</th>

            <th>Class Name</th>

            <th>Department ID</th>

            <th>Semester ID</th>

            <th>Academic Year ID</th>

            <th>Section</th>

            <th>Status</th>

            <th>Actions</th>

        </tr>

    </thead>


    <tbody>

    <%

        if (classes != null && !classes.isEmpty()) {

            for (Class classData : classes) {

    %>

        <tr>

            <td>
                <%= classData.getId() %>
            </td>

            <td>
                <strong>
                    <%= classData.getClassName() %>
                </strong>
            </td>

            <td>
                <%= classData.getDepartmentId() %>
            </td>

            <td>
                <%= classData.getSemesterId() %>
            </td>

            <td>
                <%= classData.getAcademicYearId() %>
            </td>

            <td>
                <%= classData.getSection() %>
            </td>

            <td>
                <%= classData.getStatus() %>
            </td>

            <td>

                <a class="edit-link"
                   href="<%= request.getContextPath() %>/admin/classes/edit?id=<%= classData.getId() %>">

                    Edit

                </a>


                <%

                    if ("ACTIVE".equals(classData.getStatus())) {

                %>

                    <form method="post"
                          action="<%= request.getContextPath() %>/admin/classes/status">

                        <input type="hidden"
                               name="id"
                               value="<%= classData.getId() %>">

                        <input type="hidden"
                               name="status"
                               value="INACTIVE">

                        <button type="submit"
                                class="deactivate-button">

                            Deactivate

                        </button>

                    </form>

                <%

                    } else {

                %>

                    <form method="post"
                          action="<%= request.getContextPath() %>/admin/classes/status">

                        <input type="hidden"
                               name="id"
                               value="<%= classData.getId() %>">

                        <input type="hidden"
                               name="status"
                               value="ACTIVE">

                        <button type="submit"
                                class="activate-button">

                            Activate

                        </button>

                    </form>

                <%

                    }

                %>


                <form method="post"
                      action="<%= request.getContextPath() %>/admin/classes/delete"
                      onsubmit="return confirm('Are you sure you want to delete this class?');">

                    <input type="hidden"
                           name="id"
                           value="<%= classData.getId() %>">

                    <button type="submit"
                            class="delete-button">

                        Delete

                    </button>

                </form>

            </td>

        </tr>

    <%

            }

        } else {

    %>

        <tr>

            <td colspan="8"
                class="empty-message">

                No classes found.

            </td>

        </tr>

    <%

        }

    %>

    </tbody>

</table>


</body>

</html>