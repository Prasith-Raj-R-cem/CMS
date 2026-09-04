<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.cms.model.User" %>

<%
    User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit User</title>

</head>

<body>

<h1>Edit User</h1>

<form
    method="post"
    action="<%= request.getContextPath() %>/admin/users/edit"
>

    <input
        type="hidden"
        name="id"
        value="<%= user.getId() %>"
    >

    <div>

        <label>Email:</label>

        <input
            type="email"
            name="email"
            value="<%= user.getEmail() %>"
            required
        >

    </div>

    <br>

    <div>

        <label>Role:</label>

        <select name="role" required>

            <option
                value="ADMIN"
                <%= "ADMIN".equals(user.getRole().name())
                        ? "selected"
                        : "" %>
            >
                ADMIN
            </option>

            <option
                value="FACULTY"
                <%= "FACULTY".equals(user.getRole().name())
                        ? "selected"
                        : "" %>
            >
                FACULTY
            </option>

            <option
                value="STUDENT"
                <%= "STUDENT".equals(user.getRole().name())
                        ? "selected"
                        : "" %>
            >
                STUDENT
            </option>

        </select>

    </div>

    <br>

    <div>

        <label>Status:</label>

        <select name="status" required>

            <option
                value="ACTIVE"
                <%= "ACTIVE".equals(user.getStatus())
                        ? "selected"
                        : "" %>
            >
                ACTIVE
            </option>

            <option
                value="INACTIVE"
                <%= "INACTIVE".equals(user.getStatus())
                        ? "selected"
                        : "" %>
            >
                INACTIVE
            </option>

        </select>

    </div>

    <br>

    <button type="submit">
        Save Changes
    </button>

</form>

<br>

<a href="<%= request.getContextPath() %>/admin/users">
    Cancel
</a>

<hr>

<h3>Reset Password</h3>

<form method="post"
      action="<%= request.getContextPath() %>/admin/users/reset-password">

    <input type="hidden"
           name="id"
           value="<%= user.getId() %>">

    <label for="newPassword">New Password:</label>

    <input type="password"
           id="newPassword"
           name="newPassword"
           required>

    <button type="submit">
        Reset Password
    </button>

</form>

</body>

</html>