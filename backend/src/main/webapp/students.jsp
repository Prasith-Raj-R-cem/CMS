<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Student" %>

<%
    List<Student> students =
            (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Management</title>
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
            display: inline-block !important;
            text-decoration: none !important;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            color: #ffffff !important;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        body > a:nth-of-type(1) {
            float: left;
            margin-left: 40px;
            background-color: #4f46e5;
            box-shadow: 0 2px 6px rgba(79, 70, 229, 0.35);
        }

        body > a:nth-of-type(1):hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        body > a:nth-of-type(2) {
            float: right;
            margin-right: 40px;
            background-color: #64748b;
            box-shadow: 0 2px 6px rgba(100, 116, 139, 0.35);
        }

        body > a:nth-of-type(2):hover {
            background-color: #475569;
            transform: translateY(-1px);
        }

        table {
            clear: both;
            width: 100%;
            max-width: 1100px;
            margin: 50px auto 0;
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
            display: inline-block;
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
        </style>
</head>

<body>

    <h1>Student Management</h1>
    <a href="<%= request.getContextPath() %>/admin/students/create">
        Add Student
    </a>


    <a href="<%= request.getContextPath() %>/admin/dashboard">
        Back to Dashboard
    </a>


    <table border="1" cellpadding="8" cellspacing="0">

        <thead>
            <tr>
                <th>ID</th>
                <th>Register No</th>
                <th>Name</th>
                <th>Department</th>
                <th>Semester</th>
                <th>Admission Year</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>

        <% for (Student student : students) { %>

            <tr>

                <td>
                    <%= student.getId() %>
                </td>

                <td>
                    <%= student.getRegisterNo() %>
                </td>

                <td>
                    <%= student.getFirstName() %>
                    <%= student.getLastName() %>
                </td>

                <td>
                    <%= student.getDepartment() %>
                </td>

                <td>
                    <%= student.getSemester() %>
                </td>

                <td>
                    <%= student.getAdmissionYear() %>
                </td>

                <td>
                    <a href="<%= request.getContextPath() %>/admin/students/view?id=<%= student.getId() %>">
                        View
                    </a>

                    |
                
                    <a href="<%= request.getContextPath() %>/admin/students/edit?id=<%= student.getId() %>">
                        Edit
                    </a>
                
                    |
                
                    <form method="post"
                          action="<%= request.getContextPath() %>/admin/students/delete"
                          style="display:inline;">
                
                        <input type="hidden"
                               name="id"
                               value="<%= student.getId() %>">
                
                        <button type="submit"
                                onclick="return confirm('Are you sure you want to delete this student?');">
                            Delete
                        </button>
                    
                    </form>
                </td>
            </tr>

        <% } %>

        </tbody>

    </table>

</body>
</html>