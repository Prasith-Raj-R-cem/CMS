package com.cms.controller;

import java.io.IOException;

import com.cms.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        User user =
                (User) session.getAttribute("user");

        response.setContentType("text/html");

        response.getWriter().println(
                "<h1>Admin Dashboard</h1>"
        );

        response.getWriter().println(
                "<p>Welcome, "
                + user.getEmail()
                + "</p>"
        );

        response.getWriter().println(
                "<p>Role: "
                + user.getRole()
                + "</p>"
        );
    }
}