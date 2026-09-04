package com.cms.controller;

import java.io.IOException;

import com.cms.model.Role;
import com.cms.model.User;
import com.cms.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users/edit")
public class EditUserServlet extends HttpServlet {

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

        String idParameter =
                request.getParameter("id");

        int id;

        try {
            id = Integer.parseInt(idParameter);

        } catch (Exception e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID"
            );

            return;
        }

        User user =
                userService.findUserById(id);

        if (user == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "User not found"
            );

            return;
        }

        request.setAttribute("user", user);

        request.getRequestDispatcher(
                "/edit-user.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        int id;

        try {
            id = Integer.parseInt(idParameter);

        } catch (Exception e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid user ID"
            );

            return;
        }

        String email =
                request.getParameter("email");

        String roleParameter =
                request.getParameter("role");

        String status =
                request.getParameter("status");

        Role role;

        try {

            role = Role.valueOf(roleParameter);

        } catch (Exception e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid role"
            );

            return;
        }

        User user = new User();

        user.setId(id);
        user.setEmail(email);
        user.setRole(role);
        user.setStatus(status);

        boolean updated =
                userService.updateUser(user);

        if (updated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users"
            );

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to update user"
            );
        }
    }
}