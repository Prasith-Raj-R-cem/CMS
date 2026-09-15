package com.cms.controller;

import java.io.IOException;

import com.cms.model.Student;
import com.cms.model.User;
import com.cms.service.AssignmentService;
import com.cms.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/calendar")
public class CalendarServlet extends HttpServlet {

    private final StudentService studentService =
            new StudentService();

    private final AssignmentService assignmentService =
            new AssignmentService();


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // GET SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }


        // =====================================================
        // GET LOGGED-IN USER
        // =====================================================

        User user =
                (User) session.getAttribute("user");


        if (user == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }


        // =====================================================
        // GET STUDENT
        // =====================================================

        Student student =
                studentService.findStudentByUserId(
                        user.getId()
                );


        if (student == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Student profile not found"
            );

            return;
        }


        // =====================================================
        // GET ASSIGNMENTS FOR STUDENT'S CLASS
        // =====================================================

        request.setAttribute(
                "assignments",
                assignmentService
                        .getUpcomingAssignmentSummaries(
                                student.getClassId()
                        )
        );


        // =====================================================
        // SEND STUDENT TO JSP
        // =====================================================

        request.setAttribute(
                "student",
                student
        );


        request.getRequestDispatcher(
                "/calendar.jsp"
        ).forward(
                request,
                response
        );

    }

}