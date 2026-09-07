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