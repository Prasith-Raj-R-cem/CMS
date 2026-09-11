<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>CMS Login</title>
     <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, #4f46e5 0%, #6366f1 50%, #818cf8 100%);
            padding: 20px;
        }

        h1 {
            color: #ffffff;
            font-size: 26px;
            font-weight: 700;
            text-align: center;
            margin: 0 0 4px;
            text-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #e0e7ff;
            font-size: 15px;
            font-weight: 400;
            text-align: center;
            margin: 0 0 28px;
        }

        form {
            background-color: #ffffff;
            padding: 36px 32px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.25);
            width: 100%;
            max-width: 360px;
        }

        form div {
            margin-bottom: 6px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 6px;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            outline: none;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        form br {
            display: block;
            content: "";
            margin-top: 8px;
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
            margin-top: 10px;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        button[type="submit"]:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }
    </style>

</head>


</head>

<body>

    <h1>Campus Management System</h1>

    <h2>Login</h2>

    <form action="login" method="post">

        <div>
            <label for="email">Email:</label>

            <input
                type="email"
                id="email"
                name="email"
                required
            >
        </div>

        <br>

        <div>
            <label for="password">Password:</label>

            <input
                type="password"
                id="password"
                name="password"
                required
            >
        </div>

        <br>

        <button type="submit">
            Login
        </button>

    </form>

</body>

</html>