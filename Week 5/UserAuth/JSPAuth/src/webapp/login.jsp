<%@ page import="java.sql.*" %>
<%@ include file="dbconfig.jsp" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = getConnection();
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
    stmt.setString(1, username);
    stmt.setString(2, password);

    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        session.setAttribute("username", username);
        response.sendRedirect("welcome.jsp");
    } else {
        out.println("<h3>Invalid username or password. Try again!</h3>");
        out.println("<a href='index.jsp'>Back to Login</a>");
    }

    conn.close();
%>
