<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.TimetableOption" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Timetable</title>
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