<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Department" %>
<%@ page import="com.cms.model.Semester" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Subject</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fc;
            color: #142b49;
        }

        .container {
            width: 90%;
            max-width: 700px;
            margin: 45px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 30px;
            color: #142b49;
        }

        .form-card {
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.10);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #142b49;
        }

        input,
        select {
            width: 100%;
            padding: 12px 13px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            font-size: 14px;
            outline: none;
            background: white;
        }

        input:focus,
        select:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.10);
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 22px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 3px 7px rgba(0, 0, 0, 0.12);
        }

        .btn-submit {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: white;
        }

        .btn-submit:hover {
            transform: translateY(-1px);
        }

        .btn-back {
            background: #64748b;
            color: white;
        }

        .btn-back:hover {
            background: #475569;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Add Subject</h1>

    <div class="form-card">

        <form method="post"
              action="<%= request.getContextPath() %>/admin/subjects/create">

            <!-- Subject Code -->
            <div class="form-group">

                <label for="subjectCode">
                    Subject Code
                </label>

                <input type="text"
                       id="subjectCode"
                       name="subjectCode"
                       maxlength="30"
                       placeholder="Example: CS302"
                       required>

            </div>


            <!-- Subject Name -->
            <div class="form-group">

                <label for="subjectName">
                    Subject Name
                </label>

                <input type="text"
                       id="subjectName"
                       name="subjectName"
                       maxlength="150"
                       placeholder="Example: Database Management Systems"
                       required>

            </div>


            <!-- Department -->
            <div class="form-group">

                <label for="departmentId">
                    Department
                </label>

                <select id="departmentId"
                        name="departmentId"
                        required>

                    <option value="">
                        Select Department
                    </option>

                    <%
                        List<Department> departments =
                                (List<Department>)
                                        request.getAttribute("departments");

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

            </div>


            <!-- Semester -->
            <div class="form-group">

                <label for="semesterId">
                    Semester
                </label>

                <select id="semesterId"
                        name="semesterId"
                        required>

                    <option value="">
                        Select Semester
                    </option>

                    <%
                        List<Semester> semesters =
                                (List<Semester>)
                                        request.getAttribute("semesters");

                        if (semesters != null) {

                            for (Semester semester : semesters) {
                    %>

                    <option value="<%= semester.getId() %>">
                        <%= semester.getSemesterName() %>
                    </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <!-- Credits -->
            <div class="form-group">

                <label for="credits">
                    Credits
                </label>

                <input type="number"
                       id="credits"
                       name="credits"
                       min="0.5"
                       max="9.9"
                       step="0.1"
                       placeholder="Example: 4.0"
                       required>

            </div>

            <label for="classId">Class:</label>

<select id="classId" name="classId" required>

    <option value="">Select Class</option>

    <option value="1">
        CSE S3 - Computer Science - A
    </option>

    <option value="2">
        CSE S3 - Civil Engineering - A
    </option>

</select>

<br><br>


<label for="department">Department:</label>

<input
    type="text"
    id="department"
    name="department"
    value="Computer Science"
    required>

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


            <!-- Subject Type -->
            <div class="form-group">

                <label for="subjectType">
                    Subject Type
                </label>

                <select id="subjectType"
                        name="subjectType"
                        required>

                    <option value="">
                        Select Subject Type
                    </option>

                    <option value="THEORY">
                        THEORY
                    </option>

                    <option value="LAB">
                        LAB
                    </option>

                    <option value="ELECTIVE">
                        ELECTIVE
                    </option>

                    <option value="OTHER">
                        OTHER
                    </option>

                </select>

            </div>


            <!-- Buttons -->
            <div class="button-container">

                <a href="<%= request.getContextPath() %>/admin/subjects"
                   class="btn btn-back">
                    Back
                </a>

                <button type="submit"
                        class="btn btn-submit">
                    Add Subject
                </button>

            </div>

        </form>

    </div>

</div>

</body>
</html>