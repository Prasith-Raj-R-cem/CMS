<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Department" %>

<%
    List<Department> departments =
            (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>
<html>

<head>
    <title>Create Faculty</title>
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
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            margin: 0 0 24px;
        }

        form {
            background-color: #ffffff;
            padding: 36px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.1);
            width: 100%;
            max-width: 440px;
        }

        h2 {
            font-size: 15px;
            font-weight: 700;
            color: #4f46e5;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin: 0 0 20px;
        }

        h2:not(:first-of-type) {
            margin-top: 28px;
            padding-top: 24px;
            border-top: 1px solid #eef0f5;
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
        input[type="text"],
        select {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            outline: none;
            font-family: inherit;
            background-color: #ffffff;
            color: #1f2937;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input:focus,
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
            margin-top: 8px;
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
            max-width: 440px;
            text-align: center;
            margin: 16px auto 0;
            color: #64748b;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        body > a:hover {
            color: #475569;
            text-decoration: underline;
        }
    </style>
</head>

<body>

<h1>Create Faculty</h1>

<form method="post"
      action="<%= request.getContextPath() %>/admin/faculties/create">

    <h2>Account Information</h2>

    <label for="email">Email:</label>

    <input type="email"
           id="email"
           name="email"
           required>

    <br><br>

    <label for="password">Password:</label>

    <input type="password"
           id="password"
           name="password"
           required>

    <br><br>

    <h2>Faculty Information</h2>

    <label for="employeeId">Employee ID:</label>

    <input type="text"
           id="employeeId"
           name="employeeId"
           required>

    <br><br>

    <label for="departmentId">Department:</label>

    <select id="departmentId"
            name="departmentId"
            required>

        <option value="">Select Department</option>

<%
        if (departments != null) {

            for (Department department : departments) {
%>

        <option value="<%= department.getId() %>">
            <%= department.getDepartmentCode() %>
            -
            <%= department.getDepartmentName() %>
        </option>

<%
            }
        }
%>

    </select>

    <br><br>

    <button type="submit">
        Create Faculty
    </button>

</form>

<br>

<a href="<%= request.getContextPath() %>/admin/faculties">
    Cancel
</a>

</body>

</html>