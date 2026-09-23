package com.cms.controller;

import java.io.IOException;

import com.cms.model.Assignment;
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

@WebServlet("/student/assignments/view")
public class StudentAssignmentDetailsServlet extends HttpServlet {

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
        // GET ASSIGNMENT ID
        // =====================================================

        String idParameter =
                request.getParameter("id");

        if (idParameter == null ||
                idParameter.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Assignment ID is required"
            );

            return;
        }


        long assignmentId;

        try {

            assignmentId =
                    Long.parseLong(idParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid assignment ID"
            );

            return;
        }


        // =====================================================
        // GET STUDENT CLASS ID
        // =====================================================

        long classId =
                student.getClassId();


        if (classId <= 0) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Student class not found"
            );

            return;
        }


        // =====================================================
        // FIND ASSIGNMENT
        //
        // IMPORTANT:
        // Assignment must belong to student's class
        // =====================================================

        Assignment assignment =
                assignmentService.findAssignmentForStudent(
                        assignmentId,
                        classId
                );


        if (assignment == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Assignment not found"
            );

            return;
        }


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "student",
                student
        );

        request.setAttribute(
                "assignment",
                assignment
        );


        // =====================================================
        // OPEN ASSIGNMENT DETAILS PAGE
        // =====================================================

        request.getRequestDispatcher(
                "/student-assignment-details.jsp"
        ).forward(
                request,
                response
        );
    }
}