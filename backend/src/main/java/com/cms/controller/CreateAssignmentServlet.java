package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Assignment;
import com.cms.model.Class;
import com.cms.model.Role;
import com.cms.model.Subject;
import com.cms.model.User;
import com.cms.repository.ClassRepository;
import com.cms.repository.SubjectRepository;
import com.cms.service.AssignmentService;
import com.cms.service.FacultyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/faculty/assignments/create")
public class CreateAssignmentServlet extends HttpServlet {

    private AssignmentService assignmentService;

    private ClassRepository classRepository;

    private SubjectRepository subjectRepository;

    private FacultyService facultyService;


    @Override
    public void init() throws ServletException {

        assignmentService =
                new AssignmentService();

        classRepository =
                new ClassRepository();

        subjectRepository =
                new SubjectRepository();

        facultyService =
                new FacultyService();
    }


    // =====================================================
    // GET — SHOW CREATE ASSIGNMENT PAGE
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/login"
            );

            return;
        }


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


        if (user.getRole() != Role.FACULTY) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Faculty access required."
            );

            return;
        }


        // Load active classes
        List<Class> classes =
                classRepository.findAllActiveClasses();


        // Load active subjects
        List<Subject> subjects =
                subjectRepository.findAllActiveSubjects();


        request.setAttribute(
                "classes",
                classes
        );

        request.setAttribute(
                "subjects",
                subjects
        );


        request.getRequestDispatcher(
                "/create-assignment.jsp"
        ).forward(
                request,
                response
        );
    }


    // =====================================================
    // POST — CREATE ASSIGNMENT
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


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
        // 2. GET USER
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
        // 3. CHECK FACULTY ROLE
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
        // 6. READ FORM DATA
        // ============================================

        String title =
                request.getParameter("title");

        String description =
                request.getParameter("description");

        String classIdValue =
                request.getParameter("classId");

        String subjectIdValue =
                request.getParameter("subjectId");

        String deadline =
                request.getParameter("deadline");


        long classId;

        long subjectId;


        // ============================================
        // 7. PARSE CLASS + SUBJECT
        // ============================================

        try {

            classId =
                    Long.parseLong(classIdValue);

            subjectId =
                    Long.parseLong(subjectIdValue);

        } catch (Exception e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid class or subject selection."
            );

            return;
        }


        // ============================================
        // 8. CREATE ASSIGNMENT OBJECT
        // ============================================

        Assignment assignment =
                new Assignment();

        assignment.setTitle(title);

        assignment.setDescription(
                description
        );

        assignment.setClassId(
                classId
        );

        assignment.setSubjectId(
                subjectId
        );

        // IMPORTANT:
        // Faculty ID comes from the logged-in user.
        assignment.setFacultyId(
                facultyId
        );

        assignment.setDeadline(
                deadline
        );


        // ============================================
        // 9. SAVE ASSIGNMENT
        // ============================================

        long assignmentId =
                assignmentService.createAssignment(
                        assignment
                );


        // ============================================
        // 10. RESULT
        // ============================================

        if (assignmentId > 0) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/faculty/assignments"
            );

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to create assignment. Check the entered values."
            );
        }
    }
}