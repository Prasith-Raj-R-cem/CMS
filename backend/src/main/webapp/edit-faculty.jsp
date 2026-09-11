<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Faculty" %>
<%@ page import="com.cms.model.Department" %>

<%
    Faculty faculty =
            (Faculty) request.getAttribute("faculty");

    List<Department> departments =
            (List<Department>) request.getAttribute("departments");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Faculty</title>
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
            padding: 32px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.1);
            width: 100%;
            max-width: 420px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 6px;
        }

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
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="text"]:focus,
        select:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        button[type="submit"] {
            background-color: #4f46e5;
            color: #ffffff;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 8px;
            margin-right: 12px;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        button[type="submit"]:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        form a {
            display: inline-block;
            color: #64748b;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        form a:hover {
            color: #475569;
            text-decoration: underline;
        }
    </style>
</head>

<body>

<h1>Edit Faculty</h1>

<form method="post"
      action="<%= request.getContextPath() %>/admin/faculties/edit">

    <!-- Faculty ID -->
    <input type="hidden"
           name="id"
           value="<%= faculty.getId() %>">

    <label>Employee ID:</label>
    <br>

    <input type="text"
           name="employeeId"
           value="<%= faculty.getEmployeeId() %>"
           required>

    <br><br>

    <label>Department:</label>
    <br>

    <select name="departmentId" required>

        <%
            if (departments != null) {
                for (Department department : departments) {
        %>

            <option value="<%= department.getId() %>"
                <%= department.getId() == faculty.getDepartmentId()
                        ? "selected"
                        : "" %>>

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
        Update Faculty
    </button>

    <a href="<%= request.getContextPath() %>/admin/faculties">
        Cancel
    </a>

</form>

</body>
</html>