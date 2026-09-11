<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.TimetableOption" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Timetable</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 50px 20px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, #f4f6fb 0%, #e9edf5 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #1f2937;
        }

        h1 {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            color: #1e293b;
            margin: 0 0 24px;
        }

        form {
            background-color: #ffffff;
            padding: 36px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.1);
            width: 100%;
            max-width: 520px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 6px;
        }

        select {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            outline: none;
            font-family: inherit;
            background-color: #ffffff;
            color: #1f2937;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        select:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        button[type="submit"] {
            width: 100%;
            background-color: #4f46e5;
            color: #ffffff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 8px;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        button[type="submit"]:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        body > a {
            display: block;
            width: 100%;
            max-width: 520px;
            text-align: center;
            margin: 16px auto 0;
            color: #64748b;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        body > a:hover {
            color: #475569;
            text-decoration: underline;
        }
    </style>
</head>

<body>

<h1>Create Timetable</h1>

<form method="post"
      action="<%= request.getContextPath() %>/admin/timetables/create">

    <!-- Class -->
    <label for="classId">Class:</label>
    <select name="classId" id="classId" required>

        <option value="">Select Class</option>

        <%
            List<TimetableOption> classes =
                    (List<TimetableOption>) request.getAttribute("classes");

            if (classes != null) {
                for (TimetableOption option : classes) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>

    <br><br>


    <!-- Subject -->
    <label for="subjectId">Subject:</label>
    <select name="subjectId" id="subjectId" required>

        <option value="">Select Subject</option>

        <%
            List<TimetableOption> subjects =
                    (List<TimetableOption>) request.getAttribute("subjects");

            if (subjects != null) {
                for (TimetableOption option : subjects) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>

    <br><br>


    <!-- Faculty -->
    <label for="facultyId">Faculty:</label>
    <select name="facultyId" id="facultyId" required>

        <option value="">Select Faculty</option>

        <%
            List<TimetableOption> faculties =
                    (List<TimetableOption>) request.getAttribute("faculties");

            if (faculties != null) {
                for (TimetableOption option : faculties) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>

    <br><br>


    <!-- Period -->
    <label for="periodId">Period:</label>
    <select name="periodId" id="periodId" required>

        <option value="">Select Period</option>

        <%
            List<TimetableOption> periods =
                    (List<TimetableOption>) request.getAttribute("periods");

            if (periods != null) {
                for (TimetableOption option : periods) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>

    <br><br>


    <!-- Room -->
    <label for="roomId">Room:</label>
    <select name="roomId" id="roomId">

        <option value="">No Room</option>

        <%
            List<TimetableOption> rooms =
                    (List<TimetableOption>) request.getAttribute("rooms");

            if (rooms != null) {
                for (TimetableOption option : rooms) {
        %>

            <option value="<%= option.getId() %>">
                <%= option.getLabel() %>
            </option>

        <%
                }
            }
        %>

    </select>

    <br><br>


    <!-- Academic Year -->
    <label for="academicYearId">Academic Year:</label>
    <select name="academicYearId" id="academicYearId" required>

        <option value="">Select Academic Year</option>

        <%
            List<TimetableOption> academicYears =
                    (List<TimetableOption>)
                            request.getAttribute("academicYears");

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

    <br><br>


    <!-- Semester -->
    <label for="semesterId">Semester:</label>
    <select name="semesterId" id="semesterId" required>

        <option value="">Select Semester</option>

        <%
            List<TimetableOption> semesters =
                    (List<TimetableOption>)
                            request.getAttribute("semesters");

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

    <br><br>


    <!-- Day -->
    <label for="dayOfWeek">Day:</label>
    <select name="dayOfWeek" id="dayOfWeek" required>

        <option value="">Select Day</option>
        <option value="MONDAY">Monday</option>
        <option value="TUESDAY">Tuesday</option>
        <option value="WEDNESDAY">Wednesday</option>
        <option value="THURSDAY">Thursday</option>
        <option value="FRIDAY">Friday</option>
        <option value="SATURDAY">Saturday</option>
        <option value="SUNDAY">Sunday</option>

    </select>

    <br><br>

    <button type="submit">
        Create Timetable
    </button>

</form>

<br>

<a href="<%= request.getContextPath() %>/admin/timetables">
    Back to Timetable
</a>

</body>
</html>