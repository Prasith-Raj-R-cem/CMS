package com.cms.controller;

import java.io.IOException;

import com.cms.model.LoginResult;
import com.cms.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        System.out.println("=== LOGIN DEBUG ===");
        System.out.println("Email received: [" + email + "]");
        System.out.println("===================");

        LoginResult result =
                userService.login(email, password);

        response.setContentType("text/html");

        if (result.isSuccess()) {

            response.getWriter().println(
                    "<h1>Login Successful</h1>"
            );

            response.getWriter().println(
                    "<p>Welcome, "
                    + result.getUser().getEmail()
                    + "</p>"
            );

            response.getWriter().println(
                    "<p>Role: "
                    + result.getUser().getRole()
                    + "</p>"
            );

        } else {

            response.getWriter().println(
                    "<h1>Login Failed</h1>"
            );

            response.getWriter().println(
                    "<p>"
                    + result.getMessage()
                    + "</p>"
            );
        }
    }
}