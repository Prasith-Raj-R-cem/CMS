package com.cms.controller;

import java.io.IOException;

import com.cms.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/students/delete")
public class DeleteStudentServlet extends HttpServlet {

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter = request.getParameter("id");

        if (idParameter == null || idParameter.isBlank()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Student ID is required"
            );
            return;
        }

        long studentId;

        try {
            studentId = Long.parseLong(idParameter);
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid student ID"
            );
            return;
        }

        boolean deleted =
                studentService.deleteStudent(studentId);

        if (deleted) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/students"
            );

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to delete student"
            );
        }
    }
}