<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>CMS Login</title>

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