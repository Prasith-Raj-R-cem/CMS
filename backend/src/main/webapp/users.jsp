<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.User" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>User Management</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

    </style>

</head>

<body>

<h1>User Management</h1>

<table>

    <thead>

        <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
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

            <td>
                <%= user.getId() %>
            </td>

            <td>
                <%= user.getEmail() %>
            </td>

            <td>
                <%= user.getRole() %>
            </td>

            <td class="status-active">
                <%= user.getStatus() %>
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