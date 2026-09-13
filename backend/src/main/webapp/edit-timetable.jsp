<%@ page import="com.cms.model.Timetable" %>
<%@ page import="com.cms.model.TimetableOption" %>
<%@ page import="java.util.List" %>

<%
    Timetable timetable = (Timetable) request.getAttribute("timetable");

    List<TimetableOption> classes =
            (List<TimetableOption>) request.getAttribute("classes");

    List<TimetableOption> subjects =
            (List<TimetableOption>) request.getAttribute("subjects");

    List<TimetableOption> faculties =
            (List<TimetableOption>) request.getAttribute("faculties");

    List<TimetableOption> periods =
            (List<TimetableOption>) request.getAttribute("periods");

    List<TimetableOption> rooms =
            (List<TimetableOption>) request.getAttribute("rooms");

    List<TimetableOption> academicYears =
            (List<TimetableOption>) request.getAttribute("academicYears");

    List<TimetableOption> semesters =
            (List<TimetableOption>) request.getAttribute("semesters");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Edit Timetable</title>

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
            background: #ffffff;
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

<h1>Edit Timetable</h1>


<form method="post"
      action="<%= request.getContextPath() %>/admin/timetables/edit">


    <!-- Timetable ID -->

    <input type="hidden"
           name="id"
           value="<%= timetable.getId() %>">


    <!-- Class -->

    <label for="classId">
        Class
    </label>

    <select name="classId" id="classId" required>

        <option value="">
            Select Class
        </option>

        <%
            for (TimetableOption option : classes) {
        %>

            <option value="<%= option.getId() %>"
                <%= option.getId() == timetable.getClassId()
                        ? "selected" : "" %>>

                <%= option.getLabel() %>

            </option>

        <%
            }
        %>

    </select>


    <!-- Subject -->

    <label for="subjectId">
        Subject
    </label>

    <select name="subjectId" id="subjectId" required>

        <option value="">
            Select Subject
        </option>

        <%
            for (TimetableOption option : subjects) {
        %>

            <option value="<%= option.getId() %>"
                <%= option.getId() == timetable.getSubjectId()
                        ? "selected" : "" %>>

                <%= option.getLabel() %>

            </option>

        <%
            }
        %>

    </select>


    <!-- Faculty -->

    <label for="facultyId">
        Faculty
    </label>

    <select name="facultyId" id="facultyId" required>

        <option value="">
            Select Faculty
        </option>

        <%
            for (TimetableOption option : faculties) {
        %>

            <option value="<%= option.getId() %>"
                <%= option.getId() == timetable.getFacultyId()
                        ? "selected" : "" %>>

                <%= option.getLabel() %>

            </option>

        <%
            }
        %>

    </select>


    <!-- Period -->

    <label for="periodId">
        Period
    </label>

    <select name="periodId" id="periodId" required>

        <option value="">
            Select Period
        </option>

        <%
            for (TimetableOption option : periods) {
        %>

            <option value="<%= option.getId() %>"
                <%= option.getId() == timetable.getPeriodId()
                        ? "selected" : "" %>>

                <%= option.getLabel() %>

            </option>

        <%
            }
        %>

    </select>


    <!-- Room -->

    <label for="roomId">
        Room
    </label>

    <select name="roomId" id="roomId">

        <option value="">
            No Room
        </option>

        <%
            for (TimetableOption option : rooms) {
        %>

            <option value="<%= option.getId() %>"
                <%= timetable.getRoomId() != null &&
                    option.getId() == timetable.getRoomId()
                        ? "selected" : "" %>>

                <%= option.getLabel() %>

            </option>

        <%
            }
        %>

    </select>


    <!-- Academic Year -->

    <label for="academicYearId">
        Academic Year
    </label>

    <select name="academicYearId" id="academicYearId" required>

        <option value="">
            Select Academic Year
        </option>

        <%
            for (TimetableOption option : academicYears) {
        %>

            <option value="<%= option.getId() %>"
                <%= option.getId() == timetable.getAcademicYearId()
                        ? "selected" : "" %>>

                <%= option.getLabel() %>

            </option>

        <%
            }
        %>

    </select>


    <!-- Semester -->

    <label for="semesterId">
        Semester
    </label>

    <select name="semesterId" id="semesterId" required>

        <option value="">
            Select Semester
        </option>

        <%
            for (TimetableOption option : semesters) {
        %>

            <option value="<%= option.getId() %>"
                <%= option.getId() == timetable.getSemesterId()
                        ? "selected" : "" %>>

                <%= option.getLabel() %>

            </option>

        <%
            }
        %>

    </select>


    <!-- Day -->

    <label for="dayOfWeek">
        Day
    </label>

    <select name="dayOfWeek" id="dayOfWeek" required>

        <option value="">
            Select Day
        </option>

        <option value="MONDAY"
            <%= "MONDAY".equals(timetable.getDayOfWeek())
                    ? "selected" : "" %>>
            Monday
        </option>

        <option value="TUESDAY"
            <%= "TUESDAY".equals(timetable.getDayOfWeek())
                    ? "selected" : "" %>>
            Tuesday
        </option>

        <option value="WEDNESDAY"
            <%= "WEDNESDAY".equals(timetable.getDayOfWeek())
                    ? "selected" : "" %>>
            Wednesday
        </option>

        <option value="THURSDAY"
            <%= "THURSDAY".equals(timetable.getDayOfWeek())
                    ? "selected" : "" %>>
            Thursday
        </option>

        <option value="FRIDAY"
            <%= "FRIDAY".equals(timetable.getDayOfWeek())
                    ? "selected" : "" %>>
            Friday
        </option>

        <option value="SATURDAY"
            <%= "SATURDAY".equals(timetable.getDayOfWeek())
                    ? "selected" : "" %>>
            Saturday
        </option>

        <option value="SUNDAY"
            <%= "SUNDAY".equals(timetable.getDayOfWeek())
                    ? "selected" : "" %>>
            Sunday
        </option>

    </select>


    <!-- Buttons -->

    <div class="buttons">

        <button type="submit">
            Update Timetable
        </button>

        <a class="cancel-button"
           href="<%= request.getContextPath() %>/admin/timetables">
            Cancel
        </a>

    </div>

</form>


</body>

</html>