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
</head>

<body>

<h1>Faculty Management</h1>

<a href="<%= request.getContextPath() %>/admin/faculties/create">
    Add Faculty
</a>

<br><br>

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