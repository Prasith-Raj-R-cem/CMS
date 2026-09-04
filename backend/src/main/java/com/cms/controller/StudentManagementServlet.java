package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Student;
import com.cms.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/students")
public class StudentManagementServlet extends HttpServlet {

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        List<Student> students =
                studentService.getAllStudents();

        request.setAttribute(
                "students",
                students
        );

        request.getRequestDispatcher(
                "/students.jsp"
        ).forward(request, response);
    }
}