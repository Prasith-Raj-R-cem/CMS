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
<a href="<%= request.getContextPath() %>/admin/users/create">
    Add User
</a>

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
            <td>
                <a href="<%= request.getContextPath() %>/admin/users/edit?id=<%= user.getId() %>">
                    Edit
                </a>
            
                <form method="post"
                      action="<%= request.getContextPath() %>/admin/users/status"
                      style="display:inline;">
            
                    <input type="hidden"
                           name="id"
                           value="<%= user.getId() %>">
            
                    <input type="hidden"
                           name="status"
                           value="<%= "ACTIVE".equals(user.getStatus())
                                   ? "INACTIVE"
                                   : "ACTIVE" %>">
            
                    <button type="submit">
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