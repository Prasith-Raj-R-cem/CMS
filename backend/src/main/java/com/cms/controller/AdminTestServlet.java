package com.cms.controller;

import java.io.IOException;

import com.cms.model.Role;
import com.cms.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-test")
public class AdminTestServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        User user =
                (User) session.getAttribute("user");

        if (!Role.ADMIN.equals(user.getRole()))  {

            response.setStatus(
                    HttpServletResponse.SC_FORBIDDEN
            );

            response.setContentType("text/html");

            response.getWriter().println(
                    "<h1>403 - Access Denied</h1>"
            );

            response.getWriter().println(
                    "<p>You do not have permission to access this page.</p>"
            );

            return;
        }

        response.setContentType("text/html");

        response.getWriter().println(
                "<h1>Admin Area</h1>"
        );

        response.getWriter().println(
                "<p>Welcome, Admin "
                + user.getEmail()
                + "</p>"
        );

        response.getWriter().println(
                "<p>You have administrator access.</p>"
        );
    }
}