<%-- Created by IntelliJ IDEA. User: hasid Date: 6/12/2025 Time: 1:32 PM To
change this template use File | Settings | File Templates. --%> <%@ page
session="false" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Sign Up Page</title>
    <link rel="stylesheet" type="text/css" href="../css/signup.css" />
  </head>
  <body>
    <div class="container">
      <h2>Create New Account</h2>
      <form action="../signup" method="post">
        <label for="username">Username:</label><br />
        <input type="text" id="username" name="username" required /><br /><br />

        <label for="password">Password:</label><br />
        <input
          type="password"
          id="password"
          name="password"
          required
        /><br /><br />

        <label for="role">Select Role:</label><br />
        <select id="role" name="role" required>
          <option value="EMPLOYEE">Employee</option>
          <option value="ADMIN">Admin</option></select
        ><br /><br />

        <button type="submit">Register</button>
      </form>
      <br />
      <a href="../index.jsp">Already have an account? Login</a>
    </div>
  </body>
</html>
