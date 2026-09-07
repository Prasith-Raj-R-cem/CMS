<%@ page import="com.cms.model.FacultyDetails" %>

<%
    FacultyDetails faculty =
            (FacultyDetails) request.getAttribute("faculty");
%>

<!DOCTYPE html>
<html>

<head>
    <title>Faculty Details</title>
</head>

<body>

<h1>Faculty Details</h1>

<h2>Faculty Information</h2>

<table border="1" cellpadding="8" cellspacing="0">

    <tr>
        <th>Faculty ID</th>
        <td><%= faculty.getId() %></td>
    </tr>

    <tr>
        <th>Employee ID</th>
        <td><%= faculty.getEmployeeId() %></td>
    </tr>

    <tr>
        <th>Email</th>
        <td><%= faculty.getEmail() %></td>
    </tr>

    <tr>
        <th>User ID</th>
        <td><%= faculty.getUserId() %></td>
    </tr>

    <tr>
        <th>Department</th>
        <td>
            <%= faculty.getDepartmentCode() %>
            -
            <%= faculty.getDepartmentName() %>
        </td>
    </tr>

    <tr>
        <th>Status</th>
        <td><%= faculty.getStatus() %></td>
    </tr>

    <tr>
        <th>Created At</th>
        <td><%= faculty.getCreatedAt() %></td>
    </tr>

    <tr>
        <th>Updated At</th>
        <td><%= faculty.getUpdatedAt() %></td>
    </tr>

</table>

<br>

<a href="<%= request.getContextPath() %>/admin/faculties">
    Back to Faculty Management
</a>

</body>

</html>