<%@ page import="com.cms.model.Student" %>

<%
    Student student =
            (Student) request.getAttribute("student");

    String errorMessage =
            (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
</head>

<body>

<h1>Edit Student</h1>

<%
    if (errorMessage != null) {
%>

    <p>
        <strong>Error:</strong>
        <%= errorMessage %>
    </p>

<%
    }
%>

<form method="post"
      action="<%= request.getContextPath() %>/admin/students/edit">

    <input type="hidden"
           name="id"
           value="<%= student.getId() %>">

    <h2>Student Information</h2>

    <label for="registerNo">Register Number:</label>
    <input type="text"
           id="registerNo"
           name="registerNo"
           value="<%= student.getRegisterNo() %>"
           required>

    <br><br>

    <label for="firstName">First Name:</label>
    <input type="text"
           id="firstName"
           name="firstName"
           value="<%= student.getFirstName() %>"
           required>

    <br><br>

    <label for="lastName">Last Name:</label>
    <input type="text"
           id="lastName"
           name="lastName"
           value="<%= student.getLastName() %>">

    <br><br>

    <label for="dateOfBirth">Date of Birth:</label>
    <input type="date"
           id="dateOfBirth"
           name="dateOfBirth"
           value="<%= student.getDateOfBirth() %>">

    <br><br>

    <label for="gender">Gender:</label>
    <select id="gender" name="gender">

        <option value="">Select</option>

        <option value="Male"
            <%= "Male".equals(student.getGender()) ? "selected" : "" %>>
            Male
        </option>

        <option value="Female"
            <%= "Female".equals(student.getGender()) ? "selected" : "" %>>
            Female
        </option>

        <option value="Other"
            <%= "Other".equals(student.getGender()) ? "selected" : "" %>>
            Other
        </option>

    </select>

    <br><br>

    <label for="phone">Phone:</label>
    <input type="text"
           id="phone"
           name="phone"
           value="<%= student.getPhone() %>">

    <br><br>

    <label for="department">Department:</label>
    <input type="text"
           id="department"
           name="department"
           value="<%= student.getDepartment() %>"
           required>

    <br><br>

    <label for="semester">Semester:</label>
    <select id="semester"
            name="semester"
            required>

        <option value="1"
            <%= student.getSemester() == 1 ? "selected" : "" %>>
            1
        </option>

        <option value="2"
            <%= student.getSemester() == 2 ? "selected" : "" %>>
            2
        </option>

        <option value="3"
            <%= student.getSemester() == 3 ? "selected" : "" %>>
            3
        </option>

        <option value="4"
            <%= student.getSemester() == 4 ? "selected" : "" %>>
            4
        </option>

        <option value="5"
            <%= student.getSemester() == 5 ? "selected" : "" %>>
            5
        </option>

        <option value="6"
            <%= student.getSemester() == 6 ? "selected" : "" %>>
            6
        </option>

        <option value="7"
            <%= student.getSemester() == 7 ? "selected" : "" %>>
            7
        </option>

        <option value="8"
            <%= student.getSemester() == 8 ? "selected" : "" %>>
            8
        </option>

    </select>

    <br><br>

    <label for="admissionYear">Admission Year:</label>
    <input type="number"
           id="admissionYear"
           name="admissionYear"
           value="<%= student.getAdmissionYear() %>"
           min="2000"
           max="2100"
           required>

    <br><br>

    <button type="submit">Update Student</button>

</form>

<br>

<a href="<%= request.getContextPath() %>/admin/students">
    Cancel
</a>

</body>
</html>