<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>User Login</h2>
<% if (request.getParameter("error") != null) { %>
<p style="color:red;">Invalid Username or Password</p>
<% } %>
<form action="login.jsp" method="post">
    <label>Username:</label>
    <input type="text" name="username" required><br>
    <label>Password:</label>
    <input type="password" name="password" required><br>
    <input type="submit" value="Login">
</form>
</body>
</html>
