<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Subject" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject Management</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fc;
            color: #142b49;
        }

        .container {
            width: 92%;
            max-width: 1250px;
            margin: 40px auto;
        }

        h1 {
            text-align: center;
            margin: 0 0 28px 0;
            font-size: 30px;
            font-weight: 700;
            color: #142b49;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s ease;
            box-shadow: 0 3px 7px rgba(0, 0, 0, 0.12);
        }

        .btn-add {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: white;
        }

        .btn-add:hover {
            transform: translateY(-1px);
            box-shadow: 0 5px 10px rgba(79, 70, 229, 0.25);
        }

        .btn-back {
            background: #64748b;
            color: white;
        }

        .btn-back:hover {
            background: #475569;
            transform: translateY(-1px);
        }

        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.10);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 950px;
        }

        thead {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: white;
        }

        th {
            padding: 15px 12px;
            text-align: left;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            white-space: nowrap;
        }

        td {
            padding: 14px 12px;
            font-size: 14px;
            border-bottom: 1px solid #e5e7eb;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8faff;
        }

        .status {
            font-weight: 600;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #64748b;
        }

        @media (max-width: 768px) {

            .container {
                width: 95%;
            }

            .top-bar {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }

            .btn {
                text-align: center;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Subject Management</h1>

    <div class="top-bar">

        <a href="<%= request.getContextPath() %>/admin/subjects/create"
           class="btn btn-add">
            Add Subject
        </a>

        <a href="<%= request.getContextPath() %>/admin/dashboard"
           class="btn btn-back">
            Back to Admin Dashboard
        </a>

    </div>


    <div class="table-container">

        <table>

            <thead>
            <tr>
                <th>ID</th>
                <th>Subject Code</th>
                <th>Subject Name</th>
                <th>Department ID</th>
                <th>Semester ID</th>
                <th>Credits</th>
                <th>Subject Type</th>
                <th>Status</th>
            </tr>
            </thead>


            <tbody>

            <%
                List<Subject> subjects =
                        (List<Subject>) request.getAttribute("subjects");

                if (subjects != null && !subjects.isEmpty()) {

                    for (Subject subject : subjects) {
            %>

            <tr>

                <td>
                    <%= subject.getId() %>
                </td>

                <td>
                    <%= subject.getSubjectCode() %>
                </td>

                <td>
                    <%= subject.getSubjectName() %>
                </td>

                <td>
                    <%= subject.getDepartmentId() %>
                </td>

                <td>
                    <%= subject.getSemesterId() %>
                </td>

                <td>
                    <%= subject.getCredits() %>
                </td>

                <td>
                    <%= subject.getSubjectType() %>
                </td>

                <td class="status">
                    <%= subject.getStatus() %>
                </td>

            </tr>

            <%
                    }

                } else {
            %>

            <tr>
                <td colspan="8" class="empty">
                    No active subjects found.
                </td>
            </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>