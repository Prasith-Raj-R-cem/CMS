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
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 50px 20px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, #4f46e5 0%, #6366f1 50%, #818cf8 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #ffffff;
            font-size: 26px;
            font-weight: 700;
            text-align: center;
            margin: 0 0 28px;
            text-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
        }

        form {
            background-color: #ffffff;
            padding: 32px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.25);
            width: 100%;
            max-width: 420px;
        }

        form > div {
            margin-bottom: 4px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 6px;
        }

        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            outline: none;
            font-family: inherit;
            background-color: #ffffff;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="email"]:focus,
        input[type="password"]:focus,
        select:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        button[type="submit"] {
            width: 100%;
            background-color: #4f46e5;
            color: #ffffff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 12px;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        button[type="submit"]:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        body > a {
            display: block;
            width: 100%;
            max-width: 420px;
            text-align: center;
            margin: 16px auto 0;
            color: #ffffff;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            opacity: 0.9;
            transition: opacity 0.2s ease;
        }

        body > a:hover {
            opacity: 1;
            text-decoration: underline;
        }

        hr {
            width: 100%;
            max-width: 420px;
            border: none;
            border-top: 1px solid rgba(255, 255, 255, 0.35);
            margin: 32px 0;
        }

        h3 {
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            text-align: center;
            margin: 0 0 16px;
            text-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
        }

        form[action*="reset-password"] {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        form[action*="reset-password"] label {
            margin-bottom: -6px;
        }

        form[action*="reset-password"] button {
            width: 100%;
            background-color: #ef4444;
            color: #ffffff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        form[action*="reset-password"] button:hover {
            background-color: #dc2626;
            transform: translateY(-1px);
        }
    </style>

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