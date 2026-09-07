<%@ page import="com.cms.model.User" %>

<%
    User user =
            (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>

<head>
    <title>Admin Dashboard</title>
</head>

<body>

    <h1>Campus Management System</h1>

    <h2>Admin Dashboard</h2>

    <p>
        Welcome, <%= user.getEmail() %>
    </p>

    <p>
        Role: <%= user.getRole() %>
    </p>

    <hr>

    <h3>Management</h3>

    <p>
        <a href="<%= request.getContextPath() %>/admin/users">
            User Management
        </a>
    </p>

    <p>
        <a href="<%= request.getContextPath() %>/admin/students">
            Student Management
        </a>
    </p>
    <p>
        <a href="<%= request.getContextPath() %>/admin/faculties">
            Faculty Management
        </a>
    </p>
    <p>
        <a href="<%= request.getContextPath() %>/logout">
            Logout
        </a>
    </p>

</body>

</html>