<%--<%@page session="true" %>--%>

<%--<%--%>
<%--    if (session.getAttribute("username") != null) {--%>
<%--        response.sendRedirect("jsp/dashboard.jsp");--%>
<%--    } else {--%>
<%--        response.sendRedirect("jsp/login.jsp");--%>
<%--    }--%>
<%--%>--%>

<%@page session="false" %>

<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>
<div class="container">
    <h2>Login Page</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">

    <label>Username:</label>
        <br>
        <input type="text" name="username" required>
        <br><br>
        <label>Password:</label>
        <br>
        <input type="password" name="password" required>
        <br><br>
        <button type="submit">Login</button>
        <a href="jsp/signup.jsp">
            Don't have an account? Sign Up
        </a>
    </form>
</div>
</body>
</html>