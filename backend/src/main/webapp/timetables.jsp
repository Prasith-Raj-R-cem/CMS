<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Timetable" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Timetable Management</title>
</head>

<body>

<h1>Timetable Management</h1>

<br>

<a href="<%= request.getContextPath() %>/admin/timetables/create">
    Add Timetable
</a>

<br><br>

<table border="1" cellpadding="8" cellspacing="0">

    <thead>
        <tr>
            <th>ID</th>
            <th>Class ID</th>
            <th>Subject ID</th>
            <th>Faculty ID</th>
            <th>Period ID</th>
            <th>Room ID</th>
            <th>Academic Year ID</th>
            <th>Semester ID</th>
            <th>Day</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
    </thead>

    <tbody>

    <%
        List<Timetable> timetables =
                (List<Timetable>) request.getAttribute("timetables");

        if (timetables != null && !timetables.isEmpty()) {

            for (Timetable timetable : timetables) {
    %>

        <tr>

            <td>
                <%= timetable.getId() %>
            </td>

            <td>
                <%= timetable.getClassId() %>
            </td>

            <td>
                <%= timetable.getSubjectId() %>
            </td>

            <td>
                <%= timetable.getFacultyId() %>
            </td>

            <td>
                <%= timetable.getPeriodId() %>
            </td>

            <td>
                <%
                    if (timetable.getRoomId() == null) {
                %>
                    No Room
                <%
                    } else {
                %>
                    <%= timetable.getRoomId() %>
                <%
                    }
                %>
            </td>

            <td>
                <%= timetable.getAcademicYearId() %>
            </td>

            <td>
                <%= timetable.getSemesterId() %>
            </td>

            <td>
                <%= timetable.getDayOfWeek() %>
            </td>

            <td>
                <%= timetable.getStatus() %>
            </td>

            <td>

                <a href="<%= request.getContextPath() %>/admin/timetables/edit?id=<%= timetable.getId() %>">
                    Edit
                </a>

                &nbsp; | &nbsp;

                <form method="post"
                      action="<%= request.getContextPath() %>/admin/timetables/delete"
                      style="display:inline;"
                      onsubmit="return confirm('Are you sure you want to delete this timetable?');">

                    <input type="hidden"
                           name="id"
                           value="<%= timetable.getId() %>">

                    <button type="submit">
                        Delete
                    </button>

                </form>

            </td>

        </tr>

    <%
            }

        } else {
    %>

        <tr>
            <td colspan="11">
                No timetable entries found.
            </td>
        </tr>

    <%
        }
    %>

    </tbody>

</table>

<br>

<a href="<%= request.getContextPath() %>/admin/dashboard">
    Back to Admin Dashboard
</a>

</body>
</html>