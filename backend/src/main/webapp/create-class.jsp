<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.TimetableOption" %>

<%
    List<TimetableOption> departments =
            (List<TimetableOption>) request.getAttribute("departments");

    List<TimetableOption> academicYears =
            (List<TimetableOption>) request.getAttribute("academicYears");

    List<TimetableOption> semesters =
            (List<TimetableOption>) request.getAttribute("semesters");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Add Class</title>

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
            margin-bottom: 30px;
        }

        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.08);
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-size: 14px;
            font-weight: 600;
            color: #334155;
        }

        input,
        select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 14px;
            background-color: #ffffff;
            color: #334155;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #4f46e5;
        }

        .buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        button,
        .cancel-button {
            flex: 1;
            padding: 11px 20px;
            border: none;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }

        button {
            background-color: #4f46e5;
            color: #ffffff;
        }

        button:hover {
            background-color: #4338ca;
        }

        .cancel-button {
            background-color: #64748b;
            color: #ffffff;
        }

        .cancel-button:hover {
            background-color: #475569;
        }

    </style>

</head>

<body>

<h1>Add Class</h1>


<form method="post"
      action="<%= request.getContextPath() %>/admin/classes/create">


    <!-- Class Name -->

    <label for="className">
        Class Name
    </label>

    <input type="text"
           id="className"
           name="className"
           placeholder="Example: CSE S3"
           maxlength="50"
           required>


    <!-- Department -->

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
            if (departments != null) {

                for (TimetableOption option : departments) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>


    <!-- Academic Year -->

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
            if (academicYears != null) {

                for (TimetableOption option : academicYears) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>


    <!-- Semester -->

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
            if (semesters != null) {

                for (TimetableOption option : semesters) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>


    <!-- Section -->

    <label for="section">
        Section
    </label>

    <input type="text"
           id="section"
           name="section"
           placeholder="Example: A"
           maxlength="10"
           required>


    <!-- Buttons -->

    <div class="buttons">

        <button type="submit">
            Create Class
        </button>

        <a class="cancel-button"
           href="<%= request.getContextPath() %>/admin/classes">
            Cancel
        </a>

    </div>

</form>


</body>

</html>