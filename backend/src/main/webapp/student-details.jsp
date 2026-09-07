<%@ page import="com.cms.model.Student" %>

<%
    Student student =
            (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Details</title>
</head>

<body>

<h1>Student Details</h1>

<hr>

<h2>Academic Information</h2>

<p>
    <strong>Register Number:</strong>
    <%= student.getRegisterNo() %>
</p>

<p>
    <strong>Department:</strong>
    <%= student.getDepartment() %>
</p>

<p>
    <strong>Semester:</strong>
    <%= student.getSemester() %>
</p>

<p>
    <strong>Admission Year:</strong>
    <%= student.getAdmissionYear() %>
</p>

<hr>

<h2>Personal Information</h2>

<p>
    <strong>First Name:</strong>
    <%= student.getFirstName() %>
</p>

<p>
    <strong>Last Name:</strong>
    <%= student.getLastName() %>
</p>

<p>
    <strong>Date of Birth:</strong>
    <%= student.getDateOfBirth() %>
</p>

<p>
    <strong>Gender:</strong>
    <%= student.getGender() %>
</p>

<p>
    <strong>Phone:</strong>
    <%= student.getPhone() %>
</p>

<hr>

<h2>Account Information</h2>

<p>
    <strong>User ID:</strong>
    <%= student.getUserId() %>
</p>

<hr>

<a href="<%= request.getContextPath() %>/admin/students">
    Back to Student Management
</a>

</body>
</html>