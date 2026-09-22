<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.FacultyAssignmentSummary" %>

<%
    List<FacultyAssignmentSummary> assignments =
            (List<FacultyAssignmentSummary>)
                    request.getAttribute("assignments");
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>My Assignments</title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                sans-serif;

            background: #f8fafc;

            color: #111827;
        }


        .page {

            padding: 32px;
        }


        .page-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 28px;
        }


        .page-title {

            margin: 0;

            font-size: 28px;

            font-weight: 700;

            color: #111827;
        }


        .page-subtitle {

            margin-top: 7px;

            color: #64748b;

            font-size: 14px;
        }


        .create-button {

            text-decoration: none;

            background: #4f46e5;

            color: white;

            padding: 11px 18px;

            border-radius: 10px;

            font-size: 14px;

            font-weight: 600;
        }


        .create-button:hover {

            background: #4338ca;
        }


        .assignment-container {

            display: flex;

            flex-direction: column;

            gap: 16px;
        }


        .assignment-card {

            background: white;

            border: 1px solid #e5e7eb;

            border-radius: 16px;

            padding: 22px 24px;

            box-shadow:
                0 4px 12px rgba(15, 23, 42, 0.04);
        }


        .assignment-top {

            display: flex;

            justify-content: space-between;

            align-items: flex-start;

            gap: 20px;
        }


        .assignment-title {

            font-size: 18px;

            font-weight: 700;

            color: #111827;

            margin-bottom: 8px;
        }


        .assignment-description {

            color: #64748b;

            font-size: 14px;

            line-height: 1.5;

            margin-bottom: 16px;
        }


        .meta-row {

            display: flex;

            flex-wrap: wrap;

            gap: 10px;

            color: #475569;

            font-size: 13px;
        }


        .meta-item {

            background: #f8fafc;

            border: 1px solid #e2e8f0;

            border-radius: 8px;

            padding: 7px 10px;
        }


        .meta-label {

            color: #94a3b8;

            margin-right: 4px;
        }


        .status {

            display: inline-flex;

            align-items: center;

            padding: 6px 10px;

            border-radius: 999px;

            font-size: 12px;

            font-weight: 700;

            background: #ecfdf5;

            color: #047857;
        }


        .assignment-bottom {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-top: 20px;

            padding-top: 16px;

            border-top: 1px solid #f1f5f9;
        }


        .dates {

            display: flex;

            gap: 25px;

            font-size: 13px;

            color: #64748b;
        }


        .deadline {

            color: #dc2626;

            font-weight: 600;
        }


        .actions {

            display: flex;

            gap: 8px;
        }


        .action-button {

            text-decoration: none;

            padding: 8px 13px;

            border-radius: 8px;

            font-size: 13px;

            font-weight: 600;

            border: 1px solid #e2e8f0;

            color: #475569;

            background: white;
        }


        .action-button:hover {

            background: #f8fafc;
        }


        .empty-state {

            background: white;

            border: 1px dashed #cbd5e1;

            border-radius: 16px;

            padding: 60px 20px;

            text-align: center;

            color: #64748b;
        }


        .empty-title {

            font-size: 18px;

            font-weight: 700;

            color: #334155;

            margin-bottom: 8px;
        }


        @media (max-width: 800px) {

            .page {

                padding: 20px;
            }


            .page-header {

                flex-direction: column;

                align-items: flex-start;

                gap: 16px;
            }


            .assignment-top {

                flex-direction: column;
            }


            .assignment-bottom {

                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }


            .dates {

                flex-direction: column;

                gap: 7px;
            }
        }

    </style>

</head>


<body>


<div class="page">


    <!-- =====================================================
         HEADER
    ====================================================== -->

    <div class="page-header">

        <div>

            <h1 class="page-title">
                My Assignments
            </h1>

            <div class="page-subtitle">
                View and manage assignments created for your classes.
            </div>

        </div>


        <a
            href="<%= request.getContextPath() %>/faculty/assignments/create"
            class="create-button">

            + Create Assignment

        </a>

    </div>



    <!-- =====================================================
         ASSIGNMENTS
    ====================================================== -->

    <div class="assignment-container">


<%
    if (assignments != null && !assignments.isEmpty()) {

        for (FacultyAssignmentSummary assignment : assignments) {
%>


        <div class="assignment-card">


            <!-- =================================================
                 TOP
            ================================================== -->

            <div class="assignment-top">


                <div>


                    <div class="assignment-title">

                        <%= assignment.getTitle() %>

                    </div>


<%
    if (assignment.getDescription() != null
            && !assignment.getDescription().isBlank()) {
%>

                    <div class="assignment-description">

                        <%= assignment.getDescription() %>

                    </div>

<%
    }
%>


                    <div class="meta-row">


                        <!-- CLASS -->

                        <div class="meta-item">

                            <span class="meta-label">
                                Class:
                            </span>

                            <%= assignment.getClassName() %>

<%
    if (assignment.getSection() != null
            && !assignment.getSection().isBlank()) {
%>

                            - <%= assignment.getSection() %>

<%
    }
%>

                        </div>


                        <!-- SUBJECT -->

                        <div class="meta-item">

                            <span class="meta-label">
                                Subject:
                            </span>

                            <%= assignment.getSubjectName() %>

<%
    if (assignment.getSubjectCode() != null
            && !assignment.getSubjectCode().isBlank()) {
%>

                            (<%= assignment.getSubjectCode() %>)

<%
    }
%>

                        </div>


                    </div>

                </div>



                <!-- STATUS -->

                <div class="status">

                    <%= assignment.getStatus() %>

                </div>


            </div>



            <!-- =================================================
                 BOTTOM
            ================================================== -->

            <div class="assignment-bottom">


                <div class="dates">


                    <!-- DEADLINE -->

                    <div class="deadline">

                        Deadline:

<%
    String deadline =
            assignment.getDeadline();

    if (deadline != null) {

        String[] parts =
                deadline.split("T");

        String date =
                parts.length > 0
                        ? parts[0]
                        : "";

        String time =
                parts.length > 1
                        ? parts[1]
                        : "";

%>

                        <%= date %>

                        <% if (!time.isBlank()) { %>

                            <%= time %>

                        <% } %>

<%
    } else {
%>

                        Not specified

<%
    }
%>

                    </div>


                    <!-- CREATED -->

                    <div>

                        Created:

<%
    String createdAt =
            assignment.getCreatedAt();

    if (createdAt != null) {

        String[] parts =
                createdAt.split("T");

        String createdDate =
                parts.length > 0
                        ? parts[0]
                        : "";

%>

                        <%= createdDate %>

<%
    } else {
%>

                        —

<%
    }
%>

                    </div>


                </div>



                <!-- ACTIONS -->

                <div class="actions">


                    <a
                        href="<%= request.getContextPath() %>/faculty/assignments/view?id=<%= assignment.getId() %>"
                        class="action-button">

                        View

                    </a>


                    <a
                        href="<%= request.getContextPath() %>/faculty/assignments/edit?id=<%= assignment.getId() %>"
                        class="action-button">

                        Edit

                    </a>


                    <a
                        href="<%= request.getContextPath() %>/faculty/assignments/delete?id=<%= assignment.getId() %>"
                        class="action-button">

                        Delete

                    </a>


                </div>


            </div>


        </div>


<%
        }

    } else {
%>


        <!-- =====================================================
             EMPTY STATE
        ====================================================== -->

        <div class="empty-state">

            <div class="empty-title">

                No assignments yet

            </div>

            <div>

                You haven't created any assignments for your classes.

            </div>

        </div>


<%
    }
%>


    </div>


</div>


</body>

</html>