package com.cms.controller;

import java.io.IOException;

import com.cms.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {
            int id = Integer.parseInt(
                    request.getParameter("id")
            );

            String newPassword =
                    request.getParameter("newPassword");

            boolean reset =
                    userService.resetPassword(
                            id,
                            newPassword
                    );

            if (reset) {
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/users"
                );
            } else {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST
                );
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST
            );
        }
    }
}