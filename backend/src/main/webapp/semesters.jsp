<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Semester" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Semester Management</title>

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
            max-width: 1200px;
            margin: 40px auto;
        }

        /* Page Title */
        h1 {
            text-align: center;
            margin: 0 0 28px 0;
            font-size: 30px;
            font-weight: 700;
            color: #142b49;
        }

        /* Top Buttons */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 0 0;
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

        /* Add Semester Button */
        .btn-add {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: white;
        }

        .btn-add:hover {
            transform: translateY(-1px);
            box-shadow: 0 5px 10px rgba(79, 70, 229, 0.25);
        }

        /* Back Button */
        .btn-back {
            background: #64748b;
            color: white;
        }

        .btn-back:hover {
            background: #475569;
            transform: translateY(-1px);
        }

        /* Table Card */
        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.10);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        /* Table Header */
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
        }

        /* Table Body */
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

        /* Status */
        .status {
            font-size: 14px;
            font-weight: 500;
        }

        /* Empty Message */
        .empty {
            text-align: center;
            padding: 30px;
            color: #64748b;
        }

        /* Responsive */
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

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 700px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <!-- Page Title -->
    <h1>Semester Management</h1>

    <!-- Buttons -->
    <div class="top-bar">

        <a href="<%= request.getContextPath() %>/admin/semesters/create"
           class="btn btn-add">
            Add Semester
        </a>

        <a href="<%= request.getContextPath() %>/admin/dashboard"
           class="btn btn-back">
            Back to Admin Dashboard
        </a>

    </div>


    <!-- Semester Table -->
    <div class="table-container">

        <table>

            <thead>

            <tr>
                <th>ID</th>
                <th>Academic Year ID</th>
                <th>Semester No.</th>
                <th>Semester Name</th>
                <th>Status</th>
            </tr>

            </thead>


            <tbody>

            <%
                List<Semester> semesters =
                        (List<Semester>) request.getAttribute("semesters");

                if (semesters != null && !semesters.isEmpty()) {

                    for (Semester semester : semesters) {
            %>

            <tr>

                <td>
                    <%= semester.getId() %>
                </td>

                <td>
                    <%= semester.getAcademicYearId() %>
                </td>

                <td>
                    <%= semester.getSemesterNumber() %>
                </td>

                <td>
                    <%= semester.getSemesterName() %>
                </td>

                <td class="status">
                    <%= semester.getStatus() %>
                </td>

            </tr>

            <%
                    }

                } else {
            %>

            <tr>

                <td colspan="5" class="empty">
                    No active semesters found.
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