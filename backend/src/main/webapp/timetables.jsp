<!-- <!-- <%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Timetable" %> -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Timetable Management</title>
    

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
            margin-bottom: 8px;
        }

        body > a {
            display: inline-block;
            background-color: #4f46e5;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(79, 70, 229, 0.35);
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        body > a:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        table {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.08);
            border: none !important;
        }

        thead {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
        }

        th {
            color: #ffffff;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 10px !important;
            text-align: left;
            border: none !important;
        }

        tbody tr {
            border-bottom: 1px solid #eef0f5;
            transition: background-color 0.15s ease;
        }

        tbody tr:nth-child(even) {
            background-color: #f9fafc;
        }

        tbody tr:hover {
            background-color: #eef2ff;
        }

        td {
            padding: 12px 10px !important;
            font-size: 14px;
            color: #334155;
            border: none !important;
            vertical-align: middle;
        }

        td:last-child {
            white-space: nowrap;
        }

        tbody tr td[colspan] {
            text-align: center;
            padding: 24px !important;
            font-style: italic;
            color: #94a3b8;
        }

        td a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
        }

        td a:hover {
            text-decoration: underline;
        }

        form {
            margin: 0;
        }

        form button {
            background-color: #ef4444;
            color: #ffffff;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        form button:hover {
            background-color: #dc2626;
        }

        body > a[href*="dashboard"] {
            display: block;
            width: fit-content;
            margin: 24px auto 0;
            background-color: #64748b;
            box-shadow: 0 2px 6px rgba(100, 116, 139, 0.35);
        }

        body > a[href*="dashboard"]:hover {
            background-color: #475569;
        }
    </style>

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