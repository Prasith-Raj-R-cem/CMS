<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Faculty" %>

<%
    List<Faculty> faculties =
            (List<Faculty>) request.getAttribute("faculties");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Faculty Management</title>
</head>

<body>

<h1>Faculty Management</h1>

<a href="<%= request.getContextPath() %>/admin/faculties/create">
    Add Faculty
</a>

<br><br>

<a href="<%= request.getContextPath() %>/admin/dashboard">
    Back to Dashboard
</a>

<br><br>

<table border="1" cellpadding="8" cellspacing="0">

    <tr>
        <th>ID</th>
        <th>Employee ID</th>
        <th>User ID</th>
        <th>Department ID</th>
        <th>Status</th>
        <th>Created At</th>
        <th>Action</th>
    </tr>

<%
    if (faculties != null && !faculties.isEmpty()) {

        for (Faculty faculty : faculties) {
%>

    <tr>

        <td>
            <%= faculty.getId() %>
        </td>

        <td>
            <%= faculty.getEmployeeId() %>
        </td>

        <td>
            <%= faculty.getUserId() %>
        </td>

        <td>
            <%= faculty.getDepartmentId() %>
        </td>

        <td>
            <%= faculty.getStatus() %>
        </td>

        <td>
            <%= faculty.getCreatedAt() %>
        </td>

        <td>
            <a href="<%= request.getContextPath() %>/admin/faculties/view?id=<%= faculty.getId() %>">
                View
            </a>
        </td>

    </tr>

<%
        }

    } else {
%>

    <tr>
        <td colspan="7">
            No faculty records found.
        </td>
    </tr>

<%
    }
%>

</table>

</body>
</html>