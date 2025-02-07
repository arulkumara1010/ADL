package com.example.agecheck;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AgeCheckServlet") // URL Mapping
public class AgeCheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Fetching parameters from the form
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));

        // Display message based on age
        out.println("<html><body>");
        if (age < 18) {
            out.println("<h3>Hello " + name + ", you are not authorized to visit this site.</h3>");
        } else {
            out.println("<h3>Welcome " + name + " to this site!</h3>");
        }
        out.println("</body></html>");
    }
}
