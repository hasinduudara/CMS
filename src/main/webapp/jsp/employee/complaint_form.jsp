<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/13/2025
  Time: 12:06 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>Submit Complaint</title>
</head>
<body>
<div class="container">
  <h2>Submit New Complaint</h2>

  <form action="../../submitComplaint" method="post">
    <label for="title">Title:</label><br>
    <input type="text" name="title" id="title" required><br><br>

    <label for="description">Description:</label><br>
    <textarea name="description" id="description" rows="5" cols="50" required></textarea><br><br>

    <button type="submit">Submit Complaint</button>
  </form>

  <br>
  <a href="<%= request.getContextPath() %>/jsp/employee/employeeDashboard.jsp">Back to Dashboard</a>
</div>
</body>
</html>

