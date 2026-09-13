<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.AcademicYear" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Semester</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fc;
            color: #142b49;
        }

        .container {
            width: 90%;
            max-width: 650px;
            margin: 55px auto;
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
            margin-bottom: 22px;
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

    <h1>Add Semester</h1>

    <div class="form-card">

        <form method="post"
              action="<%= request.getContextPath() %>/admin/semesters/create">

            <!-- Academic Year -->
            <div class="form-group">

                <label for="academicYearId">
                    Academic Year
                </label>

                <select id="academicYearId"
                        name="academicYearId"
                        required>

                    <option value="">
                        Select Academic Year
                    </option>

                    <%
                        List<AcademicYear> academicYears =
                                (List<AcademicYear>)
                                        request.getAttribute("academicYears");

                        if (academicYears != null) {

                            for (AcademicYear academicYear : academicYears) {
                    %>

                    <option value="<%= academicYear.getId() %>">
                        <%= academicYear.getYearName() %>
                    </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <!-- Semester Number -->
            <div class="form-group">

                <label for="semesterNumber">
                    Semester Number
                </label>

                <input type="number"
                       id="semesterNumber"
                       name="semesterNumber"
                       min="1"
                       max="12"
                       placeholder="Enter semester number"
                       required>

            </div>


            <!-- Semester Name -->
            <div class="form-group">

                <label for="semesterName">
                    Semester Name
                </label>

                <input type="text"
                       id="semesterName"
                       name="semesterName"
                       maxlength="30"
                       placeholder="Example: Semester 4"
                       required>

            </div>


            <!-- Buttons -->
            <div class="button-container">

                <a href="<%= request.getContextPath() %>/admin/semesters"
                   class="btn btn-back">
                    Back
                </a>

                <button type="submit"
                        class="btn btn-submit">
                    Add Semester
                </button>

            </div>

        </form>

    </div>

</div>

</body>
</html>