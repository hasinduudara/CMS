<%@page session="true" %>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("jsp/dashboard.jsp");
    } else {
        response.sendRedirect("jsp/login.jsp");
    }
%>