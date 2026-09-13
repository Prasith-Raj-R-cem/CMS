<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Department" %>

<%
    List<Department> departments =
            (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Department Management</title>

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
            max-width: 900px;
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
            max-width: 900px;
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

        .status-active {
            font-weight: 600;
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

<h1>Department Management</h1>


<div class="top-buttons">

    <a class="add-button"
       href="<%= request.getContextPath() %>/admin/departments/create">

        Add Department

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
            <th>Department Code</th>
            <th>Department Name</th>
            <th>Status</th>

        </tr>

    </thead>


    <tbody>

    <%

        if (departments != null &&
            !departments.isEmpty()) {

            for (Department department : departments) {

    %>

        <tr>

            <td>
                <%= department.getId() %>
            </td>

            <td>
                <strong>
                    <%= department.getDepartmentCode() %>
                </strong>
            </td>

            <td>
                <%= department.getDepartmentName() %>
            </td>

            <td class="status-active">
                <%= department.getStatus() %>
            </td>

        </tr>

    <%

            }

        } else {

    %>

        <tr>

            <td colspan="4"
                class="empty-message">

                No active departments found.

            </td>

        </tr>

    <%

        }

    %>

    </tbody>

</table>


</body>

</html>