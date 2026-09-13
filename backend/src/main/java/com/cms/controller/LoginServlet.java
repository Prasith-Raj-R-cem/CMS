package com.cms.controller;

import java.io.IOException;

import com.cms.model.LoginResult;
import com.cms.model.Role;
import com.cms.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
        System.out.println(
                "Email received: [" + email + "]"
        );
        System.out.println("===================");


        LoginResult result =
                userService.login(
                        email,
                        password
                );


        response.setContentType("text/html");


        // =====================================================
        // LOGIN SUCCESS
        // =====================================================

        if (result.isSuccess()) {

            // Create/retrieve the HTTP session
            HttpSession session =
                    request.getSession();

            // Store logged-in user in session
            session.setAttribute(
                    "user",
                    result.getUser()
            );


            // =================================================
            // ADMIN
            // =================================================

            if (result.getUser().getRole() == Role.ADMIN) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/dashboard"
                );


            // =================================================
            // FACULTY
            // =================================================

            } else if (
                    result.getUser().getRole() == Role.FACULTY
            ) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/faculty/dashboard"
                );


            // =================================================
            // STUDENT
            // =================================================

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/dashboard"
                );
            }


        // =====================================================
        // LOGIN FAILURE
        // =====================================================

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