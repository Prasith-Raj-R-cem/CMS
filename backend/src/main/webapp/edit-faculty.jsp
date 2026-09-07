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