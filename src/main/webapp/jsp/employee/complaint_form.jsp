<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>Submit Complaint</title>
  <style>
    .error-message {
      color: red;
      margin-bottom: 15px;
    }
    .success-message {
      color: green;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Submit New Complaint</h2>

  <%-- Add error message display --%>
  <% 
    String error = request.getParameter("error");
    if (error != null) {
      String message = "";
      switch(error) {
        case "session":
          message = "Your session has expired. Please login again.";
          break;
        case "empty":
          message = "Please fill in all required fields.";
          break;
        case "db":
          message = "Failed to save complaint. Please try again.";
          break;
        case "system":
          message = "System error occurred. Please try again later.";
          break;
        default:
          message = "An error occurred. Please try again.";
      }
  %>
    <p class="error-message"><%= message %></p>
  <% } %>

  <% if (request.getParameter("success") != null) { %>
    <p class="success-message">Complaint submitted successfully!</p>
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