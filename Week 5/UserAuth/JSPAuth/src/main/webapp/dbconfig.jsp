<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/user_auth";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
    } catch (Exception e) {
        out.println("Database Connection Failed: " + e.getMessage());
    }
%>
