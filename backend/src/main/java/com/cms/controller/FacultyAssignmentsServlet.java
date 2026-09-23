package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.FacultyAssignmentSummary;
import com.cms.model.Role;
import com.cms.model.User;
import com.cms.service.AssignmentService;
import com.cms.service.FacultyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/faculty/assignments")
public class FacultyAssignmentsServlet extends HttpServlet {

    private AssignmentService assignmentService;
    private FacultyService facultyService;

    @Override
    public void init() throws ServletException {

        assignmentService =
                new AssignmentService();

        facultyService =
                new FacultyService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // ============================================
        // 1. GET SESSION
        // ============================================

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }


        // ============================================
        // 2. GET LOGGED-IN USER
        // ============================================

        Object userObject =
                session.getAttribute("user");

        if (!(userObject instanceof User)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }

        User user =
                (User) userObject;


        // ============================================
        // 3. CHECK ROLE
        // ============================================

        if (user.getRole() != Role.FACULTY) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Faculty access required."
            );

            return;
        }


        // ============================================
        // 4. GET USER ID
        // ============================================

        long userId =
                user.getId();

        if (userId <= 0) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Invalid user session."
            );

            return;
        }


        // ============================================
        // 5. FIND FACULTY ID
        // ============================================

        long facultyId =
                facultyService.findFacultyIdByUserId(
                        userId
                );

        if (facultyId <= 0) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Faculty profile not found."
            );

            return;
        }


        // ============================================
        // 6. STORE FACULTY ID IN SESSION
        // ============================================

        session.setAttribute(
                "facultyId",
                facultyId
        );


        // ============================================
        // 7. FETCH ASSIGNMENTS
        // ============================================

        List<FacultyAssignmentSummary> assignments =
                assignmentService.getAssignmentsByFaculty(
                        facultyId
                );


        // ============================================
        // 8. SEND DATA TO JSP
        // ============================================

        request.setAttribute(
                "assignments",
                assignments
        );


        // ============================================
        // 9. FORWARD TO JSP
        // ============================================

        request.getRequestDispatcher(
                "/faculty-assignments.jsp"
        ).forward(
                request,
                response
        );
    }
}