<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Class" %>
<%@ page import="com.cms.model.Subject" %>
<%@ page import="com.cms.model.Faculty" %>

<%
    List<Class> classes =
            (List<Class>) request.getAttribute("classes");

    List<Subject> subjects =
            (List<Subject>) request.getAttribute("subjects");

    List<Faculty> faculties =
            (List<Faculty>) request.getAttribute("faculties");

    String success =
            request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Assignment | Campus CMS</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family:
                Inter,
                -apple-system,
                BlinkMacSystemFont,
                "Segoe UI",
                sans-serif;

            min-height: 100vh;

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #f5f3ff
                );

            color: #1e1b4b;
        }

        .page {
            min-height: 100vh;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 40px 20px;
        }

        .card {
            width: 100%;
            max-width: 850px;

            background: white;

            border-radius: 24px;

            padding: 38px;

            box-shadow:
                0 20px 60px rgba(79, 70, 229, 0.12);

            border: 1px solid #e5e7eb;
        }

        .header {
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 30px;
            font-weight: 750;

            color: #312e81;

            margin-bottom: 8px;
        }

        .header p {
            color: #6b7280;
            font-size: 15px;
        }

        .success {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #047857;

            padding: 13px 16px;

            border-radius: 12px;

            margin-bottom: 24px;

            font-size: 14px;
            font-weight: 600;
        }

        .form-grid {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 22px;
        }

        .full {
            grid-column: 1 / -1;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            font-size: 14px;

            font-weight: 650;

            color: #374151;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;

            left: 14px;
            top: 50%;

            transform: translateY(-50%);

            width: 19px;
            height: 19px;

            color: #6366f1;

            pointer-events: none;
        }

        input,
        select,
        textarea {

            width: 100%;

            border: 1px solid #d1d5db;

            border-radius: 12px;

            padding: 13px 14px 13px 45px;

            font-size: 14px;

            color: #111827;

            background: #fff;

            outline: none;

            transition:
                border-color .2s,
                box-shadow .2s;
        }

        select {
            cursor: pointer;
        }

        textarea {
            min-height: 130px;

            resize: vertical;

            padding-left: 45px;
        }

        input:focus,
        select:focus,
        textarea:focus {

            border-color: #6366f1;

            box-shadow:
                0 0 0 4px
                rgba(99, 102, 241, 0.10);
        }

        .buttons {

            display: flex;

            justify-content: flex-end;

            gap: 12px;

            margin-top: 30px;

            padding-top: 25px;

            border-top: 1px solid #e5e7eb;
        }

        .btn {

            border: none;

            border-radius: 12px;

            padding: 13px 22px;

            font-size: 14px;

            font-weight: 650;

            cursor: pointer;

            text-decoration: none;

            display: inline-flex;

            align-items: center;

            justify-content: center;

            transition:
                transform .2s,
                box-shadow .2s;
        }

        .btn:hover {
            transform: translateY(-1px);
        }

        .btn-primary {

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            box-shadow:
                0 8px 20px
                rgba(79, 70, 229, .22);
        }

        .btn-secondary {

            background: #f3f4f6;

            color: #374151;
        }

        @media (max-width: 700px) {

            .card {
                padding: 25px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full {
                grid-column: auto;
            }

            .buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<div class="page">

    <div class="card">

        <div class="header">

            <h1>Create Assignment</h1>

            <p>
                Publish a new assignment for a class and subject.
            </p>

        </div>


        <% if ("true".equals(success)) { %>

            <div class="success">
                Assignment created successfully.
            </div>

        <% } %>


        <form
                method="post"
                action="<%= request.getContextPath() %>/faculty/assignments/create">

            <div class="form-grid">


                <!-- Assignment Title -->

                <div class="form-group full">

                    <label for="title">
                        Assignment Title
                    </label>

                    <div class="input-wrapper">

                        <svg class="input-icon"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2">

                            <path d="M4 5h16M4 12h16M4 19h10"/>

                        </svg>

                        <input
                                type="text"
                                id="title"
                                name="title"
                                placeholder="Enter assignment title"
                                required>

                    </div>

                </div>


                <!-- Class -->

                <div class="form-group">

                    <label for="classId">
                        Class
                    </label>

                    <div class="input-wrapper">

                        <svg class="input-icon"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2">

                            <path d="M3 10l9-6 9 6"/>
                            <path d="M5 10v10h14V10"/>
                            <path d="M9 20v-6h6v6"/>

                        </svg>

                        <select
                                id="classId"
                                name="classId"
                                required>

                            <option value="">
                                Select Class
                            </option>

                            <% if (classes != null) {
                                for (Class classData : classes) { %>

                                <option
                                        value="<%= classData.getId() %>">

                                    <%= classData.getClassName() %>
                                    <% if (classData.getSection() != null &&
                                           !classData.getSection().isBlank()) { %>
                                        - Section <%= classData.getSection() %>
                                    <% } %>

                                </option>

                            <%  }
                            } %>

                        </select>

                    </div>

                </div>


                <!-- Subject -->

                <div class="form-group">

                    <label for="subjectId">
                        Subject
                    </label>

                    <div class="input-wrapper">

                        <svg class="input-icon"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2">

                            <path d="M4 4h16v16H4z"/>
                            <path d="M8 8h8M8 12h8M8 16h5"/>

                        </svg>

                        <select
                                id="subjectId"
                                name="subjectId"
                                required>

                            <option value="">
                                Select Subject
                            </option>

                            <% if (subjects != null) {
                                for (Subject subject : subjects) { %>

                                <option
                                        value="<%= subject.getId() %>">

                                    <%= subject.getSubjectCode() %>
                                    -
                                    <%= subject.getSubjectName() %>

                                </option>

                            <%  }
                            } %>

                        </select>

                    </div>

                </div>


                <!-- Faculty -->

                <div class="form-group full">

                    <label for="facultyId">
                        Faculty
                    </label>

                    <div class="input-wrapper">

                        <svg class="input-icon"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2">

                            <circle cx="12"
                                    cy="8"
                                    r="4"/>

                            <path d="M4 21c0-4 3.5-7 8-7s8 3 8 7"/>

                        </svg>

                        <select
                                id="facultyId"
                                name="facultyId"
                                required>

                            <option value="">
                                Select Faculty
                            </option>

                            <% if (faculties != null) {
                                for (Faculty faculty : faculties) { %>

                                <option
                                        value="<%= faculty.getId() %>">

                                    <%= faculty.getEmployeeId() %>

                                </option>

                            <%  }
                            } %>

                        </select>

                    </div>

                </div>


                <!-- Deadline -->

                <div class="form-group full">

                    <label for="deadline">
                        Submission Deadline
                    </label>

                    <div class="input-wrapper">

                        <svg class="input-icon"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2">

                            <circle cx="12"
                                    cy="12"
                                    r="9"/>

                            <path d="M12 7v5l3 2"/>

                        </svg>

                        <input
                                type="datetime-local"
                                id="deadline"
                                name="deadline"
                                required>

                    </div>

                </div>


                <!-- Description -->

                <div class="form-group full">

                    <label for="description">
                        Description
                    </label>

                    <div class="input-wrapper">

                        <svg class="input-icon"
                             style="top: 22px;"
                             viewBox="0 0 24 24"
                             fill="none"
                             stroke="currentColor"
                             stroke-width="2">

                            <path d="M4 5h16M4 10h16M4 15h10"/>

                        </svg>

                        <textarea
                                id="description"
                                name="description"
                                placeholder="Enter assignment instructions..."
                        ></textarea>

                    </div>

                </div>

            </div>


            <div class="buttons">

                <a
                        href="<%= request.getContextPath() %>/faculty/dashboard"
                        class="btn btn-secondary">

                    Cancel

                </a>

                <button
                        type="submit"
                        class="btn btn-primary">

                    Create Assignment

                </button>

            </div>

        </form>

    </div>

</div>

</body>

</html>