package com.cms.controller;

import java.io.IOException;

import com.cms.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect("login");

            return;
        }
        // user to retrive the user role saved in the cookies.
        User user =
                (User) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login");

            return;
        }

        response.setContentType("text/html");

        response.getWriter().println(
                "<h1>Campus Management System</h1>"
        );

        response.getWriter().println(
                "<h2>Dashboard</h2>"
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