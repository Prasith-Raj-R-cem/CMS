<!DOCTYPE html>
<html>
<head>
    <title>Create Student</title>
</head>
<body>

<h1>Create Student</h1>

<form method="post"
      action="<%= request.getContextPath() %>/admin/students/create">

    <h2>Account Information</h2>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>

    <hr>

    <h2>Student Information</h2>

    <label for="registerNo">Register Number:</label>
    <input type="text" id="registerNo" name="registerNo" required>

    <br><br>

    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstName" required>

    <br><br>

    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastName">

    <br><br>

    <label for="dateOfBirth">Date of Birth:</label>
    <input type="date" id="dateOfBirth" name="dateOfBirth">

    <br><br>

    <label for="gender">Gender:</label>
    <select id="gender" name="gender">
        <option value="">Select</option>
        <option value="Male">Male</option>
        <option value="Female">Female</option>
        <option value="Other">Other</option>
    </select>

    <br><br>

    <label for="phone">Phone:</label>
    <input type="text" id="phone" name="phone">

    <br><br>

    <label for="department">Department:</label>
    <input type="text" id="department" name="department" required>

    <br><br>

    <label for="semester">Semester:</label>
    <select id="semester" name="semester" required>
        <option value="">Select</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
    </select>

    <br><br>

    <label for="admissionYear">Admission Year:</label>
    <input type="number" id="admissionYear"
           name="admissionYear"
           min="2000"
           max="2100"
           required>

    <br><br>

    <button type="submit">Create Student</button>

</form>

<br>

<a href="${pageContext.request.contextPath}/admin/students">
    Back to Student Management
</a>

</body>
</html>