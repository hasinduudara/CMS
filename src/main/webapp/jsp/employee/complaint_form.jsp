<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>Submit Complaint</title>
</head>
<body>
<div class="container">
  <h2>Submit New Complaint</h2>

  <%-- Add error message display --%>
  <% if (request.getParameter("error") != null) { %>
  <p style="color: red;">Failed to submit complaint. Please try again.</p>
  <% } %>

  <form action="${pageContext.request.contextPath}/submitComplaint" method="post">
    <label for="title">Title:</label><br>
    <input type="text" name="title" id="title" required><br><br>

    <label for="description">Description:</label><br>
    <textarea name="description" id="description" rows="5" cols="50" required></textarea><br><br>

    <button type="submit">Submit Complaint</button>
  </form>

  <br>
  <a href="${pageContext.request.contextPath}/jsp/employee/dashboard.jsp">Back to Dashboard</a>
</div>
</body>
</html>