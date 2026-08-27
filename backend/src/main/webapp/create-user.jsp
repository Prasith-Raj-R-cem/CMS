<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Create User</title>

</head>

<body>

<h1>Create User</h1>

<form
    method="post"
    action="<%= request.getContextPath() %>/admin/users/create"
>

    <div>

        <label>Email:</label>

        <input
            type="email"
            name="email"
            required
        >

    </div>

    <br>

    <div>

        <label>Password:</label>

        <input
            type="password"
            name="password"
            required
        >

    </div>

    <br>

    <div>

        <label>Role:</label>

        <select name="role" required>

            <option value="ADMIN">
                ADMIN
            </option>

            <option value="FACULTY">
                FACULTY
            </option>

            <option value="STUDENT">
                STUDENT
            </option>

        </select>

    </div>

    <br>

    <button type="submit">
        Create User
    </button>

</form>

<br>

<a href="<%= request.getContextPath() %>/admin/users">
    Back to Users
</a>

</body>

</html>