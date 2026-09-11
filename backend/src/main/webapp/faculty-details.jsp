<%@ page import="com.cms.model.FacultyDetails" %>

<%
    FacultyDetails faculty =
            (FacultyDetails) request.getAttribute("faculty");
%>

<!DOCTYPE html>
<html>

<head>
    <title>Faculty Details</title>
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
            margin-bottom: 4px;
        }

        h2 {
            text-align: center;
            font-size: 14px;
            font-weight: 700;
            color: #4f46e5;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin: 0 0 24px;
        }

        table {
            width: 100%;
            max-width: 640px;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.08);
            border: none !important;
        }

        tr {
            border-bottom: 1px solid #eef0f5;
        }

        tr:last-child {
            border-bottom: none;
        }

        tr:nth-child(even) {
            background-color: #f9fafc;
        }

        th {
            width: 200px;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.03em;
            padding: 14px 16px !important;
            border: none !important;
            background-color: transparent;
        }

        td {
            font-size: 14px;
            font-weight: 500;
            color: #1e293b;
            padding: 14px 16px !important;
            border: none !important;
        }

        a {
            display: block;
            width: fit-content;
            margin: 24px auto 0;
            background-color: #64748b;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(100, 116, 139, 0.35);
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        a:hover {
            background-color: #475569;
            transform: translateY(-1px);
        }
    </style>
</head>

<body>

<h1>Faculty Details</h1>

<h2>Faculty Information</h2>

<table border="1" cellpadding="8" cellspacing="0">

    <tr>
        <th>Faculty ID</th>
        <td><%= faculty.getId() %></td>
    </tr>

    <tr>
        <th>Employee ID</th>
        <td><%= faculty.getEmployeeId() %></td>
    </tr>

    <tr>
        <th>Email</th>
        <td><%= faculty.getEmail() %></td>
    </tr>

    <tr>
        <th>User ID</th>
        <td><%= faculty.getUserId() %></td>
    </tr>

    <tr>
        <th>Department</th>
        <td>
            <%= faculty.getDepartmentCode() %>
            -
            <%= faculty.getDepartmentName() %>
        </td>
    </tr>

    <tr>
        <th>Status</th>
        <td><%= faculty.getStatus() %></td>
    </tr>

    <tr>
        <th>Created At</th>
        <td><%= faculty.getCreatedAt() %></td>
    </tr>

    <tr>
        <th>Updated At</th>
        <td><%= faculty.getUpdatedAt() %></td>
    </tr>

</table>

<br>

<a href="<%= request.getContextPath() %>/admin/faculties">
    Back to Faculty Management
</a>

</body>

</html>