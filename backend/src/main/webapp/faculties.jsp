<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Faculty" %>

<%
    List<Faculty> faculties =
            (List<Faculty>) request.getAttribute("faculties");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Faculty Management</title>
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
            margin-bottom: 20px;
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
            max-width: 1200px;
            margin: 50px auto 0;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.08);
            border: none !important;
        }

        table tr:first-child {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
        }

        table tr:first-child th {
            color: #ffffff;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 10px !important;
            text-align: left;
            border: none !important;
        }

        table tr:not(:first-child) {
            border-bottom: 1px solid #eef0f5;
            transition: background-color 0.15s ease;
        }

        table tr:not(:first-child):nth-child(even) {
            background-color: #f9fafc;
        }

        table tr:not(:first-child):hover {
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

        td[colspan] {
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
            display: inline-block;
            margin: 0;
        }

        form button {
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            color: #ffffff;
            transition: background-color 0.2s ease;
        }

        form:has(input[value="INACTIVE"]) button {
            background-color: #f59e0b;
        }

        form:has(input[value="INACTIVE"]) button:hover {
            background-color: #d97706;
        }

        form:has(input[value="ACTIVE"]) button {
            background-color: #16a34a;
        }

        form:has(input[value="ACTIVE"]) button:hover {
            background-color: #15803d;
        }

        form[action*="delete"] button {
            background-color: #ef4444;
        }

        form[action*="delete"] button:hover {
            background-color: #dc2626;
        }
    </style>


</head>

<body>

<h1>Faculty Management</h1>

<a href="<%= request.getContextPath() %>/admin/faculties/create">
    Add Faculty
</a>



<a href="<%= request.getContextPath() %>/admin/dashboard">
    Back to Dashboard
</a>

<br><br>

<table border="1" cellpadding="8" cellspacing="0">

    <tr>
        <th>ID</th>
        <th>Employee ID</th>
        <th>User ID</th>
        <th>Department ID</th>
        <th>Status</th>
        <th>Created At</th>
        <th>Action</th>
    </tr>

<%
    if (faculties != null && !faculties.isEmpty()) {

        for (Faculty faculty : faculties) {
%>

    <tr>

        <td>
            <%= faculty.getId() %>
        </td>

        <td>
            <%= faculty.getEmployeeId() %>
        </td>

        <td>
            <%= faculty.getUserId() %>
        </td>

        <td>
            <%= faculty.getDepartmentId() %>
        </td>

        <td>
            <%= faculty.getStatus() %>
        </td>

        <td>
            <%= faculty.getCreatedAt() %>
        </td>

        <td>
            <a href="<%= request.getContextPath() %>/admin/faculties/view?id=<%= faculty.getId() %>">
                View
            </a>
            &nbsp; | &nbsp;
        
            <a href="<%= request.getContextPath() %>/admin/faculties/edit?id=<%= faculty.getId() %>">
                Edit
            </a>
            &nbsp; | &nbsp;
        
            <% if ("ACTIVE".equals(faculty.getStatus())) { %>
            
                <form method="post"
                      action="<%= request.getContextPath() %>/admin/faculties/status"
                      style="display:inline;">
            
                    <input type="hidden"
                           name="id"
                           value="<%= faculty.getId() %>">
            
                    <input type="hidden"
                           name="status"
                           value="INACTIVE">
            
                    <button type="submit">
                        Deactivate
                    </button>
                
                </form>
            
            <% } else { %>
            
                <form method="post"
                      action="<%= request.getContextPath() %>/admin/faculties/status"
                      style="display:inline;">
            
                    <input type="hidden"
                           name="id"
                           value="<%= faculty.getId() %>">
            
                    <input type="hidden"
                           name="status"
                           value="ACTIVE">
            
                    <button type="submit">
                        Activate
                    </button>
                
                </form>
            
            <% } %>

            &nbsp; | &nbsp;

            <form method="post"
                  action="<%= request.getContextPath() %>/admin/faculties/delete"
                  style="display:inline;"
                  onsubmit="return confirm('Are you sure you want to permanently delete this faculty?');">
                        
                <input type="hidden"
                       name="id"
                       value="<%= faculty.getId() %>">
                        
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
        <td colspan="7">
            No faculty records found.
        </td>
    </tr>

<%
    }
%>

</table>

</body>
</html>