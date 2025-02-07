package com.example.datetime;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/datetime")
public class DateTime extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String currentDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

        out.println("<html><head><title>Current Date & Time</title></head><body>");
        out.println("<h2>Current Date and Time: " + currentDateTime + "</h2>");
        out.println("<br><a href='datetime'>Refresh</a>");
        out.println("</body></html>");
    }
}
