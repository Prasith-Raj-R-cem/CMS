<%@ page import="com.cms.model.User" %>

<%
    User user =
            (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>

<head>
    <title>Admin Dashboard</title>
     <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 50px 20px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, #f4f6fb 0%, #e9edf5 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #1f2937;
        }

        h1 {
            text-align: center;
            font-size: 26px;
            font-weight: 700;
            color: #1e293b;
            margin: 0 0 4px;
        }

        h2 {
            text-align: center;
            font-size: 14px;
            font-weight: 700;
            color: #4f46e5;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin: 0 0 20px;
        }

        body > p {
            width: 100%;
            max-width: 480px;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 12px 18px;
            margin: 0 0 8px;
            font-size: 14px;
            color: #334155;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.06);
        }

        hr {
            width: 100%;
            max-width: 480px;
            border: none;
            border-top: 1px solid #dfe3ee;
            margin: 28px 0 24px;
        }

        h3 {
            width: 100%;
            max-width: 480px;
            font-size: 15px;
            font-weight: 700;
            color: #4f46e5;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin: 0 0 16px;
        }

        h3 + p,
        h3 ~ p {
            width: 100%;
            max-width: 480px;
            margin: 0 0 12px;
            padding: 0;
            background: none;
            box-shadow: none;
        }

        h3 ~ p a {
            display: block;
            background-color: #ffffff;
            color: #1e293b;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            padding: 16px 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.06);
            border-left: 4px solid #4f46e5;
            transition: transform 0.15s ease, box-shadow 0.15s ease, border-color 0.15s ease;
        }

        h3 ~ p a:hover {
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.15);
        }

        h3 ~ p:last-of-type a {
            border-left-color: #ef4444;
            color: #ef4444;
        }

        h3 ~ p:last-of-type a:hover {
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.15);
        }
    </style>
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