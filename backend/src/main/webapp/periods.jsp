<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Period" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Period Management</title>

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
            max-width: 1100px;
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
            min-width: 700px;
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

    <h1>Period Management</h1>

    <div class="top-bar">

        <a href="<%= request.getContextPath() %>/admin/periods/create"
           class="btn btn-add">
            Add Period
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
                <th>Period No.</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Status</th>
            </tr>
            </thead>


            <tbody>

            <%
                List<Period> periods =
                        (List<Period>) request.getAttribute("periods");

                if (periods != null && !periods.isEmpty()) {

                    for (Period period : periods) {
            %>

            <tr>

                <td>
                    <%= period.getId() %>
                </td>

                <td>
                    <%= period.getPeriodNumber() %>
                </td>

                <td>
                    <%= period.getStartTime() %>
                </td>

                <td>
                    <%= period.getEndTime() %>
                </td>

                <td class="status">
                    <%= period.getStatus() %>
                </td>

            </tr>

            <%
                    }

                } else {
            %>

            <tr>
                <td colspan="5" class="empty">
                    No active periods found.
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