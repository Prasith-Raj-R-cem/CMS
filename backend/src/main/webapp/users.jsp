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

        h1 {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 20px;
        }

        body > a {
            display: block;
            width: fit-content;
            margin: 0 auto 24px;
            background-color: #4f46e5;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(79, 70, 229, 0.35);
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        body > a:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        table {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
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
            padding: 14px 12px;
            text-align: left;
        }

        tbody tr {
            border-bottom: 1px solid #eef0f5;
            transition: background-color 0.15s ease;
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

        td.status-active {
            font-weight: 600;
            color: #16a34a;
        }

        td a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            margin-right: 10px;
        }

        td a:hover {
            text-decoration: underline;
        }

        form {
            display: inline-block;
        }

        form button {
            background-color: #f59e0b;
            color: #ffffff;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        form button:hover {
            background-color: #d97706;
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