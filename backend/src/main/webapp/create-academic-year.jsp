<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Add Academic Year</title>

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
            margin-bottom: 30px;
        }

        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.08);
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-size: 14px;
            font-weight: 600;
            color: #334155;
        }

        input {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 14px;
            color: #334155;
        }

        input:focus {
            outline: none;
            border-color: #4f46e5;
        }

        .buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        button,
        .cancel-button {
            flex: 1;
            padding: 11px 20px;
            border: none;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }

        button {
            background-color: #4f46e5;
            color: #ffffff;
        }

        button:hover {
            background-color: #4338ca;
        }

        .cancel-button {
            background-color: #64748b;
            color: #ffffff;
        }

        .cancel-button:hover {
            background-color: #475569;
        }

    </style>

</head>

<body>

<h1>Add Academic Year</h1>


<form method="post"
      action="<%= request.getContextPath() %>/admin/academic-years/create">


    <!-- Academic Year -->

    <label for="yearName">
        Academic Year
    </label>

    <input type="text"
           id="yearName"
           name="yearName"
           placeholder="Example: 2027-28"
           maxlength="20"
           required>


    <!-- Start Date -->

    <label for="startDate">
        Start Date
    </label>

    <input type="date"
           id="startDate"
           name="startDate"
           required>


    <!-- End Date -->

    <label for="endDate">
        End Date
    </label>

    <input type="date"
           id="endDate"
           name="endDate"
           required>


    <div class="buttons">

        <button type="submit">
            Create Academic Year
        </button>

        <a class="cancel-button"
           href="<%= request.getContextPath() %>/admin/academic-years">

            Cancel

        </a>

    </div>

</form>


</body>

</html>