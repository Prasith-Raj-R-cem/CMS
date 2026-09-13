<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Period</title>

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
            width: 90%;
            max-width: 700px;
            margin: 45px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 30px;
            color: #142b49;
        }

        .form-card {
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.10);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #142b49;
        }

        input {
            width: 100%;
            padding: 12px 13px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            font-size: 14px;
            outline: none;
            background: white;
        }

        input:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.10);
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 22px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 3px 7px rgba(0, 0, 0, 0.12);
        }

        .btn-submit {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: white;
        }

        .btn-submit:hover {
            transform: translateY(-1px);
        }

        .btn-back {
            background: #64748b;
            color: white;
        }

        .btn-back:hover {
            background: #475569;
        }

        .hint {
            margin-top: 6px;
            font-size: 12px;
            color: #64748b;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Add Period</h1>

    <div class="form-card">

        <form method="post"
              action="<%= request.getContextPath() %>/admin/periods/create">


            <!-- Period Number -->
            <div class="form-group">

                <label for="periodNumber">
                    Period Number
                </label>

                <input type="number"
                       id="periodNumber"
                       name="periodNumber"
                       min="1"
                       max="99"
                       placeholder="Example: 5"
                       required>

            </div>


            <!-- Start Time -->
            <div class="form-group">

                <label for="startTime">
                    Start Time
                </label>

                <input type="time"
                       id="startTime"
                       name="startTime"
                       step="1"
                       required>

            </div>


            <!-- End Time -->
            <div class="form-group">

                <label for="endTime">
                    End Time
                </label>

                <input type="time"
                       id="endTime"
                       name="endTime"
                       step="1"
                       required>

                <div class="hint">
                    End time must be later than start time.
                </div>

            </div>


            <!-- Buttons -->
            <div class="button-container">

                <a href="<%= request.getContextPath() %>/admin/periods"
                   class="btn btn-back">
                    Back
                </a>

                <button type="submit"
                        class="btn btn-submit">
                    Add Period
                </button>

            </div>

        </form>

    </div>

</div>

</body>
</html>