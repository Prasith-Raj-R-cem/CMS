<%@ page import="com.cms.model.Student" %>

<%
    Student student =
            (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Details</title>
     <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 40px 24px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, #f4f6fb 0%, #e9edf5 100%);
            color: #1f2937;
        }

        h1 {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 24px;
        }

        h2 {
            font-size: 16px;
            font-weight: 700;
            color: #4f46e5;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin: 0 0 16px;
        }

        hr {
            display: none;
        }

        p {
            max-width: 640px;
            margin: 0 auto 12px;
            padding: 12px 16px;
            background-color: #ffffff;
            border-radius: 8px;
            font-size: 14px;
            color: #334155;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.06);
            display: flex;
            gap: 8px;
        }

        p strong {
            min-width: 160px;
            color: #1e293b;
            font-weight: 600;
        }

        h2 {
            max-width: 640px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 32px;
        }

        h2:first-of-type {
            margin-top: 0;
        }

        a {
            display: block;
            width: fit-content;
            margin: 32px auto 0;
            background-color: #64748b;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(100, 116, 139, 0.35);
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        a:hover {
            background-color: #475569;
            transform: translateY(-1px);
        }
    </style>
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