<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Student" %>

<%
    List<Student> students =
            (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Management</title>
</head>

<body>

    <h1>Student Management</h1>

    <a href="<%= request.getContextPath() %>/admin/dashboard">
        Back to Dashboard
    </a>

    <br><br>

    <table border="1" cellpadding="8" cellspacing="0">

        <thead>
            <tr>
                <th>ID</th>
                <th>Register No</th>
                <th>Name</th>
                <th>Department</th>
                <th>Semester</th>
                <th>Admission Year</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>

        <% for (Student student : students) { %>

            <tr>

                <td>
                    <%= student.getId() %>
                </td>

                <td>
                    <%= student.getRegisterNo() %>
                </td>

                <td>
                    <%= student.getFirstName() %>
                    <%= student.getLastName() %>
                </td>

                <td>
                    <%= student.getDepartment() %>
                </td>

                <td>
                    <%= student.getSemester() %>
                </td>

                <td>
                    <%= student.getAdmissionYear() %>
                </td>

                <td>
                    <a href="<%= request.getContextPath() %>/admin/students/view?id=<%= student.getId() %>">
                        View
                    </a>
                </td>
            </tr>

        <% } %>

        </tbody>

    </table>

</body>
</html>