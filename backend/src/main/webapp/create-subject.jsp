<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.cms.model.Department" %>
<%@ page import="com.cms.model.Semester" %>
<%@ page import="com.cms.model.Class" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Add Subject</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;

            padding: 0;

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

            color: #142b49;
        }


        /* =========================
           MAIN CONTAINER
           ========================= */

        .container {

            width: 90%;

            max-width: 700px;

            margin: 45px auto;
        }


        /* =========================
           PAGE TITLE
           ========================= */

        h1 {

            text-align: center;

            margin: 0 0 30px;

            font-size: 30px;

            font-weight: 700;

            color: #142b49;
        }


        /* =========================
           FORM CARD
           ========================= */

        .form-card {

            background: #ffffff;

            padding: 35px;

            border-radius: 12px;

            box-shadow:
                0 5px 15px rgba(0, 0, 0, 0.10);
        }


        /* =========================
           SECTION TITLE
           ========================= */

        .section-title {

            margin-top: 8px;

            margin-bottom: 20px;

            padding-bottom: 9px;

            border-bottom: 1px solid #e5e7eb;

            font-size: 16px;

            font-weight: 700;

            color: #142b49;
        }


        .section-title:not(:first-child) {

            margin-top: 28px;
        }


        /* =========================
           FORM GROUP
           ========================= */

        .form-group {

            margin-bottom: 22px;
        }


        /* =========================
           LABEL
           ========================= */

        label {

            display: block;

            margin-bottom: 8px;

            font-size: 14px;

            font-weight: 600;

            color: #142b49;
        }


        /* =========================
           INPUTS / SELECTS
           ========================= */

        input,
        select {

            width: 100%;

            height: 46px;

            padding: 0 13px;

            border: 1px solid #d1d5db;

            border-radius: 7px;

            font-size: 14px;

            outline: none;

            background: #ffffff;

            color: #142b49;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease;
        }


        input:focus,
        select:focus {

            border-color: #4f46e5;

            box-shadow:
                0 0 0 2px rgba(79, 70, 229, 0.10);
        }


        input::placeholder {

            color: #9ca3af;
        }


        /* =========================
           CLASS HELPER TEXT
           ========================= */

        .class-info {

            margin-top: 8px;

            margin-bottom: 0;

            font-size: 12px;

            line-height: 1.5;

            color: #64748b;
        }


        /* =========================
           BUTTON CONTAINER
           ========================= */

        .button-container {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-top: 32px;
        }


        /* =========================
           COMMON BUTTON
           ========================= */

        .btn {

            padding: 12px 22px;

            border: none;

            border-radius: 8px;

            text-decoration: none;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            box-shadow:
                0 3px 7px rgba(0, 0, 0, 0.12);

            transition:
                background-color 0.2s ease,
                transform 0.2s ease,
                box-shadow 0.2s ease;
        }


        /* =========================
           SUBMIT BUTTON
           ========================= */

        .btn-submit {

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #6366f1
                );

            color: #ffffff;
        }


        .btn-submit:hover {

            background:
                linear-gradient(
                    135deg,
                    #4338ca,
                    #4f46e5
                );

            transform: translateY(-1px);

            box-shadow:
                0 5px 10px rgba(79, 70, 229, 0.25);
        }


        /* =========================
           BACK BUTTON
           ========================= */

        .btn-back {

            background: #64748b;

            color: #ffffff;
        }


        .btn-back:hover {

            background: #475569;

            transform: translateY(-1px);

            box-shadow:
                0 5px 10px rgba(71, 85, 105, 0.20);
        }


        /* =========================
           MOBILE
           ========================= */

        @media (max-width: 600px) {

            body {

                padding: 20px 0;
            }


            .container {

                width: 94%;

                margin: 20px auto;
            }


            .form-card {

                padding: 24px;
            }


            h1 {

                font-size: 26px;
            }


            .button-container {

                gap: 12px;
            }


            .btn {

                flex: 1;

                text-align: center;
            }

        }

    </style>

</head>


<body>

<div class="container">


    <!-- =========================
         PAGE TITLE
         ========================= -->

    <h1>
        Add Subject
    </h1>


    <div class="form-card">


        <form
            method="post"
            action="<%= request.getContextPath() %>/admin/subjects/create"
        >


            <!-- =========================
                 SUBJECT INFORMATION
                 ========================= -->

            <div class="section-title">
                Subject Information
            </div>


            <!-- Subject Code -->

            <div class="form-group">

                <label for="subjectCode">
                    Subject Code
                </label>

                <input
                    type="text"
                    id="subjectCode"
                    name="subjectCode"
                    maxlength="30"
                    placeholder="Example: CS302"
                    required
                >

            </div>


            <!-- Subject Name -->

            <div class="form-group">

                <label for="subjectName">
                    Subject Name
                </label>

                <input
                    type="text"
                    id="subjectName"
                    name="subjectName"
                    maxlength="150"
                    placeholder="Example: Database Management Systems"
                    required
                >

            </div>


            <!-- Department -->

            <div class="form-group">

                <label for="departmentId">
                    Department
                </label>

                <select
                    id="departmentId"
                    name="departmentId"
                    required
                >

                    <option value="">
                        Select Department
                    </option>

                    <%
                        List<Department> departments =
                                (List<Department>)
                                        request.getAttribute("departments");

                        if (departments != null) {

                            for (Department department : departments) {
                    %>

                        <option
                            value="<%= department.getId() %>"
                        >

                            <%= department.getDepartmentCode() %>
                            -
                            <%= department.getDepartmentName() %>

                        </option>

                    <%
                            }

                        }
                    %>

                </select>

            </div>


            <!-- Semester -->

            <div class="form-group">

                <label for="semesterId">
                    Semester
                </label>

                <select
                    id="semesterId"
                    name="semesterId"
                    required
                >

                    <option value="">
                        Select Semester
                    </option>

                    <%
                        List<Semester> semesters =
                                (List<Semester>)
                                        request.getAttribute("semesters");

                        if (semesters != null) {

                            for (Semester semester : semesters) {
                    %>

                        <option
                            value="<%= semester.getId() %>"
                        >

                            <%= semester.getSemesterName() %>

                        </option>

                    <%
                            }

                        }
                    %>

                </select>

            </div>


            <!-- Credits -->

            <div class="form-group">

                <label for="credits">
                    Credits
                </label>

                <input
                    type="number"
                    id="credits"
                    name="credits"
                    min="0.5"
                    max="9.9"
                    step="0.1"
                    placeholder="Example: 4.0"
                    required
                >

            </div>


            <!-- Subject Type -->

            <div class="form-group">

                <label for="subjectType">
                    Subject Type
                </label>

                <select
                    id="subjectType"
                    name="subjectType"
                    required
                >

                    <option value="">
                        Select Subject Type
                    </option>

                    <option value="THEORY">
                        THEORY
                    </option>

                    <option value="LAB">
                        LAB
                    </option>

                    <option value="ELECTIVE">
                        ELECTIVE
                    </option>

                    <option value="OTHER">
                        OTHER
                    </option>

                </select>

            </div>


            <!-- =========================
                 CLASS INFORMATION
                 ========================= -->

            <div class="section-title">
                Class
            </div>


            <div class="form-group">

                <label for="classId">
                    Assign Class
                </label>

                <select
                    id="classId"
                    name="classId"
                >

                    <option value="">
                        Select Class
                    </option>

                    <%
                        List<Class> classes =
                                (List<Class>)
                                        request.getAttribute("classes");

                        if (classes != null) {

                            for (Class clazz : classes) {
                    %>

                        <option
                            value="<%= clazz.getId() %>"
                        >

                            <%= clazz.getClassName() %>

                            <%
                                if (clazz.getSection() != null &&
                                    !clazz.getSection().isBlank()) {
                            %>

                                - Section
                                <%= clazz.getSection() %>

                            <%
                                }
                            %>

                        </option>

                    <%
                            }

                        }
                    %>

                </select>


                <div class="class-info">
                    Select the class associated with this subject.
                </div>

            </div>


            <!-- =========================
                 BUTTONS
                 ========================= -->

            <div class="button-container">


                <a
                    href="<%= request.getContextPath() %>/admin/subjects"
                    class="btn btn-back"
                >
                    Back
                </a>


                <button
                    type="submit"
                    class="btn btn-submit"
                >
                    Add Subject
                </button>


            </div>


        </form>

    </div>

</div>

</body>

</html>