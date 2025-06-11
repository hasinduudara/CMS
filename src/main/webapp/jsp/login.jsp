<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/11/2025
  Time: 9:03 PM
  To change this template use File | Settings | File Templates.
--%>

<%@page session="false" %>

<html>
<head>
    <title>Login Page</title>
</head>
<body>
<div class="container">
    <h2>Login Page</h2>
    <form action="../login" method="post">
        <label>Username:</label>
        <br>
        <input type="text" name="username" required>
        <br><br>
        <label>Password:</label>
        <br>
        <input type="password" name="password" required>
        <br><br>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>
