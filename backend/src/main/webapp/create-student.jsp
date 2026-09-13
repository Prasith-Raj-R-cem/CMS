<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Create Student</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 50px 20px;

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

            display: flex;
            flex-direction: column;
            align-items: center;

            color: #1f2937;
        }


        h1 {
            text-align: center;

            font-size: 28px;
            font-weight: 700;

            color: #1e293b;

            margin: 0 0 24px;
        }


        form {
            background-color: #ffffff;

            padding: 36px;

            border-radius: 14px;

            box-shadow:
                0 10px 30px
                rgba(15, 23, 42, 0.10);

            width: 100%;
            max-width: 480px;
        }


        h2 {
            font-size: 15px;
            font-weight: 700;

            color: #4f46e5;

            text-transform: uppercase;

            letter-spacing: 0.05em;

            margin: 0 0 20px;
        }


        hr {
            border: none;

            border-top:
                1px solid #eef0f5;

            margin: 24px 0;
        }


        label {
            display: block;

            font-size: 13px;
            font-weight: 600;

            color: #374151;

            margin-bottom: 6px;
        }


        input[type="email"],
        input[type="password"],
        input[type="text"],
        input[type="date"],
        input[type="number"],
        select {

            width: 100%;

            padding: 10px 12px;

            font-size: 14px;

            border:
                1px solid #d1d5db;

            border-radius: 8px;

            outline: none;

            font-family: inherit;

            background-color: #ffffff;

            color: #1f2937;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease;
        }


        input:focus,
        select:focus {

            border-color: #4f46e5;

            box-shadow:
                0 0 0 3px
                rgba(79, 70, 229, 0.15);
        }


        button[type="submit"] {

            width: 100%;

            background-color: #4f46e5;

            color: #ffffff;

            border: none;

            padding: 12px;

            border-radius: 8px;

            font-size: 15px;
            font-weight: 600;

            cursor: pointer;

            margin-top: 8px;

            transition:
                background-color 0.2s ease,
                transform 0.2s ease;
        }


        button[type="submit"]:hover {

            background-color: #4338ca;

            transform: translateY(-1px);
        }


        button[type="submit"]:active {

            transform: translateY(0);
        }


        body > a {

            display: block;

            width: 100%;
            max-width: 480px;

            text-align: center;

            margin: 16px auto 0;

            color: #64748b;

            font-weight: 600;

            font-size: 14px;

            text-decoration: none;

            transition: color 0.2s ease;
        }


        body > a:hover {

            color: #475569;

            text-decoration: underline;
        }

    </style>

</head>


<body>

    <h1>Create Student</h1>


    <form
        method="post"
        action="<%= request.getContextPath() %>/admin/students/create"
    >


        <!-- ================================================= -->
        <!-- ACCOUNT INFORMATION -->
        <!-- ================================================= -->

        <h2>Account Information</h2>


        <label for="email">
            Email:
        </label>

        <input
            type="email"
            id="email"
            name="email"
            required
        >


        <br><br>


        <label for="password">
            Password:
        </label>

        <input
            type="password"
            id="password"
            name="password"
            required
        >


        <hr>


        <!-- ================================================= -->
        <!-- STUDENT INFORMATION -->
        <!-- ================================================= -->

        <h2>Student Information</h2>


        <label for="registerNo">
            Register Number:
        </label>

        <input
            type="text"
            id="registerNo"
            name="registerNo"
            maxlength="30"
            required
        >


        <br><br>


        <label for="firstName">
            First Name:
        </label>

        <input
            type="text"
            id="firstName"
            name="firstName"
            maxlength="50"
            required
        >


        <br><br>


        <label for="lastName">
            Last Name:
        </label>

        <input
            type="text"
            id="lastName"
            name="lastName"
            maxlength="50"
        >


        <br><br>


        <label for="dateOfBirth">
            Date of Birth:
        </label>

        <input
            type="date"
            id="dateOfBirth"
            name="dateOfBirth"
        >


        <br><br>


        <label for="gender">
            Gender:
        </label>

        <select
            id="gender"
            name="gender"
        >

            <option value="">
                Select
            </option>

            <option value="Male">
                Male
            </option>

            <option value="Female">
                Female
            </option>

            <option value="Other">
                Other
            </option>

        </select>


        <br><br>


        <label for="phone">
            Phone:
        </label>

        <input
            type="text"
            id="phone"
            name="phone"
            maxlength="15"
        >


        <br><br>


        <!-- ================================================= -->
        <!-- CLASS -->
        <!-- ================================================= -->

        <label for="classId">
            Class:
        </label>

        <select
            id="classId"
            name="classId"
            required
        >

            <option value="">
                Select Class
            </option>

            <option value="1">
                CSE S3 - Computer Science - A
            </option>

            <option value="2">
                CSE S3 - Civil Engineering - A
            </option>

        </select>


        <br><br>


        <!-- ================================================= -->
        <!-- DEPARTMENT -->
        <!-- ================================================= -->

        <label for="department">
            Department:
        </label>

        <input
            type="text"
            id="department"
            name="department"
            required
        >


        <br><br>


        <!-- ================================================= -->
        <!-- SEMESTER -->
        <!-- ================================================= -->

        <label for="semester">
            Semester:
        </label>

        <select
            id="semester"
            name="semester"
            required
        >

            <option value="">
                Select
            </option>

            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>

        </select>


        <br><br>


        <!-- ================================================= -->
        <!-- ADMISSION YEAR -->
        <!-- ================================================= -->

        <label for="admissionYear">
            Admission Year:
        </label>

        <input
            type="number"
            id="admissionYear"
            name="admissionYear"
            min="2000"
            max="2100"
            required
        >


        <br><br>


        <!-- ================================================= -->
        <!-- SUBMIT -->
        <!-- ================================================= -->

        <button type="submit">
            Create Student
        </button>

    </form>


    <a href="<%= request.getContextPath() %>/admin/students">

        Back to Student Management

    </a>


</body>

</html>