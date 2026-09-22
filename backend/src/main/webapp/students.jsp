<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Student" %>

<%
    List<Student> students =
            (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Management</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 40px 24px;

            font-family:
                'Segoe UI',
                Roboto,
                Helvetica,
                Arial,
                sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #f4f6fb 0%,
                    #e9edf5 100%
                );

            color: #1f2937;
        }


        /* =========================
           PAGE TITLE
           ========================= */

        h1 {
            text-align: center;

            font-size: 28px;

            font-weight: 700;

            color: #1e293b;

            margin: 0 0 35px 0;
        }


        /* =========================
           TOP ACTIONS
           ========================= */

        .top-actions {

            width: 100%;

            max-width: 1000px;

            margin: 0 auto 26px auto;

            display: flex;

            justify-content: space-between;

            align-items: center;
        }


        /* =========================
           ADD STUDENT BUTTON
           ========================= */

        .add-student-btn {

            display: inline-block;

            background-color: #4f46e5;

            color: #ffffff;

            text-decoration: none;

            padding: 10px 20px;

            border-radius: 8px;

            font-weight: 600;

            font-size: 14px;

            box-shadow:
                0 2px 6px
                rgba(79, 70, 229, 0.35);

            transition:
                background-color 0.2s ease,
                transform 0.2s ease;
        }


        .add-student-btn:hover {

            background-color: #4338ca;

            transform: translateY(-1px);
        }


        /* =========================
           BACK BUTTON
           ========================= */

        .back-btn {

            display: inline-block;

            background-color: #64748b;

            color: #ffffff;

            text-decoration: none;

            padding: 10px 20px;

            border-radius: 8px;

            font-weight: 600;

            font-size: 14px;

            box-shadow:
                0 2px 6px
                rgba(100, 116, 139, 0.30);

            transition:
                background-color 0.2s ease,
                transform 0.2s ease;
        }


        .back-btn:hover {

            background-color: #475569;

            transform: translateY(-1px);
        }


        /* =========================
           TABLE
           ========================= */

        table {

            width: 100%;

            max-width: 1000px;

            margin: 0 auto;

            border-collapse: collapse;

            background-color: #ffffff;

            border-radius: 12px;

            overflow: hidden;

            box-shadow:
                0 4px 16px
                rgba(15, 23, 42, 0.08);
        }


        /* =========================
           TABLE HEADER
           ========================= */

        thead {

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #6366f1
                );
        }


        th {

            color: #ffffff;

            font-size: 13px;

            text-transform: uppercase;

            letter-spacing: 0.05em;

            padding: 14px 12px;

            text-align: left;

            white-space: nowrap;
        }


        /* =========================
           TABLE BODY
           ========================= */

        tbody tr {

            border-bottom: 1px solid #eef0f5;

            transition:
                background-color 0.15s ease;
        }


        tbody tr:last-child {

            border-bottom: none;
        }


        tbody tr:nth-child(even) {

            background-color: #f9fafc;
        }


        tbody tr:hover {

            background-color: #eef2ff;
        }


        /* =========================
           TABLE CELLS
           ========================= */

        td {

            padding: 12px;

            font-size: 14px;

            color: #334155;

            vertical-align: middle;
        }


        /* =========================
           ACTION COLUMN
           ========================= */

        .action-cell {

            white-space: nowrap;
        }


        /* =========================
           ACTION LINKS
           ========================= */

        .action-link {

            color: #4f46e5;

            text-decoration: none;

            font-weight: 600;

            font-size: 13px;

            margin-right: 14px;
        }


        .action-link:hover {

            text-decoration: underline;
        }


        /* =========================
           DELETE FORM
           ========================= */

        .delete-form {

            display: inline-block;

            margin: 0;
        }


        /* =========================
           DELETE BUTTON
           ========================= */

        .delete-btn {

            background-color: #ef4444;

            color: #ffffff;

            border: none;

            padding: 6px 14px;

            border-radius: 6px;

            font-size: 13px;

            font-weight: 600;

            cursor: pointer;

            transition:
                background-color 0.2s ease,
                transform 0.15s ease;
        }


        .delete-btn:hover {

            background-color: #dc2626;

            transform: translateY(-1px);
        }


        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 768px) {

            body {

                padding: 25px 12px;
            }


            h1 {

                font-size: 24px;

                margin-bottom: 25px;
            }


            .top-actions {

                flex-direction: column;

                align-items: stretch;

                gap: 12px;
            }


            .add-student-btn,
            .back-btn {

                text-align: center;
            }


            table {

                display: block;

                overflow-x: auto;

                white-space: nowrap;
            }


            th,
            td {

                padding: 10px;
            }

        }

    </style>

</head>


<body>


    <!-- =========================
         PAGE TITLE
         ========================= -->

    <h1>
        Student Management
    </h1>


    <!-- =========================
         TOP ACTION BUTTONS
         ========================= -->

    <div class="top-actions">


        <!-- ADD STUDENT -->

        <a
            class="add-student-btn"
            href="<%= request.getContextPath() %>/admin/students/create"
        >
            Add Student
        </a>


        <!-- BACK TO DASHBOARD -->

        <a
            class="back-btn"
            href="<%= request.getContextPath() %>/admin/dashboard"
        >
            Back to Admin Dashboard
        </a>


    </div>


    <!-- =========================
         STUDENT TABLE
         ========================= -->

    <table>


        <thead>

            <tr>

                <th>
                    ID
                </th>

                <th>
                    Register No
                </th>

                <th>
                    Name
                </th>

                <th>
                    Department
                </th>

                <th>
                    Semester
                </th>

                <th>
                    Admission Year
                </th>

                <th>
                    Action
                </th>

            </tr>

        </thead>


        <tbody>


        <%
            if (students != null) {

                for (Student student : students) {
        %>


            <tr>


                <!-- ID -->

                <td>
                    <%= student.getId() %>
                </td>


                <!-- REGISTER NUMBER -->

                <td>
                    <%= student.getRegisterNo() %>
                </td>


                <!-- NAME -->

                <td>

                    <%= student.getFirstName() %>
                    <%= student.getLastName() %>

                </td>


                <!-- DEPARTMENT -->

                <td>
                    <%= student.getDepartment() %>
                </td>


                <!-- SEMESTER -->

                <td>
                    <%= student.getSemester() %>
                </td>


                <!-- ADMISSION YEAR -->

                <td>
                    <%= student.getAdmissionYear() %>
                </td>


                <!-- ACTIONS -->

                <td class="action-cell">


                    <!-- VIEW -->

                    <a
                        class="action-link"
                        href="<%= request.getContextPath() %>/admin/students/view?id=<%= student.getId() %>"
                    >
                        View
                    </a>


                    <!-- EDIT -->

                    <a
                        class="action-link"
                        href="<%= request.getContextPath() %>/admin/students/edit?id=<%= student.getId() %>"
                    >
                        Edit
                    </a>


                    <!-- DELETE -->

                    <form
                        class="delete-form"
                        method="post"
                        action="<%= request.getContextPath() %>/admin/students/delete"
                    >

                        <input
                            type="hidden"
                            name="id"
                            value="<%= student.getId() %>"
                        >


                        <button
                            type="submit"
                            class="delete-btn"
                            onclick="return confirm('Are you sure you want to delete this student?');"
                        >
                            Delete
                        </button>

                    </form>


                </td>


            </tr>


        <%
                }

            }
        %>


        </tbody>

    </table>


</body>

</html>