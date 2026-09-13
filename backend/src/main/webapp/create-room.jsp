<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Room</title>

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

        input,
        select {
            width: 100%;
            padding: 12px 13px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            font-size: 14px;
            outline: none;
            background: white;
        }

        input:focus,
        select:focus {
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

        .optional {
            font-size: 12px;
            color: #64748b;
            font-weight: normal;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Add Room</h1>

    <div class="form-card">

        <form method="post"
              action="<%= request.getContextPath() %>/admin/rooms/create">


            <!-- Room Number -->
            <div class="form-group">

                <label for="roomNumber">
                    Room Number
                </label>

                <input type="text"
                       id="roomNumber"
                       name="roomNumber"
                       maxlength="30"
                       placeholder="Example: 102"
                       required>

            </div>


            <!-- Building -->
            <div class="form-group">

                <label for="building">
                    Building
                    <span class="optional">(Optional)</span>
                </label>

                <input type="text"
                       id="building"
                       name="building"
                       maxlength="100"
                       placeholder="Example: Main Block">

            </div>


            <!-- Room Type -->
            <div class="form-group">

                <label for="roomType">
                    Room Type
                </label>

                <select id="roomType"
                        name="roomType"
                        required>

                    <option value="">
                        Select Room Type
                    </option>

                    <option value="CLASSROOM">
                        CLASSROOM
                    </option>

                    <option value="LAB">
                        LAB
                    </option>

                    <option value="SEMINAR_HALL">
                        SEMINAR HALL
                    </option>

                    <option value="OTHER">
                        OTHER
                    </option>

                </select>

            </div>


            <!-- Capacity -->
            <div class="form-group">

                <label for="capacity">
                    Capacity
                    <span class="optional">(Optional)</span>
                </label>

                <input type="number"
                       id="capacity"
                       name="capacity"
                       min="1"
                       max="9999"
                       placeholder="Example: 60">

            </div>


            <!-- Buttons -->
            <div class="button-container">

                <a href="<%= request.getContextPath() %>/admin/rooms"
                   class="btn btn-back">
                    Back
                </a>

                <button type="submit"
                        class="btn btn-submit">
                    Add Room
                </button>

            </div>

        </form>

    </div>

</div>

</body>
</html>