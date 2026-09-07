package com.cms.controller;

import java.io.IOException;

import com.cms.model.Student;
import com.cms.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/students/view")
public class StudentDetailsServlet extends HttpServlet {

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

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

        Student student =
                studentService.findStudentById(studentId);

        if (student == null) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Student not found"
            );
            return;
        }

        request.setAttribute("student", student);

        request.getRequestDispatcher(
                "/student-details.jsp"
        ).forward(request, response);
    }
}