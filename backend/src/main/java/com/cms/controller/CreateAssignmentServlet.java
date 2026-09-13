package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Assignment;
import com.cms.model.Class;
import com.cms.model.Faculty;
import com.cms.model.Subject;
import com.cms.repository.ClassRepository;
import com.cms.repository.FacultyRepository;
import com.cms.repository.SubjectRepository;
import com.cms.service.AssignmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/faculty/assignments/create")
public class CreateAssignmentServlet extends HttpServlet {

    private AssignmentService assignmentService;
    private ClassRepository classRepository;
    private SubjectRepository subjectRepository;
    private FacultyRepository facultyRepository;

    @Override
    public void init() {

        assignmentService = new AssignmentService();
        classRepository = new ClassRepository();
        subjectRepository = new SubjectRepository();
        facultyRepository = new FacultyRepository();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Load active classes
        List<Class> classes =
                classRepository.findAllActiveClasses();

        // Load active subjects
        List<Subject> subjects =
                subjectRepository.findAllActiveSubjects();

        // Load active faculties
        List<Faculty> faculties =
                facultyRepository.findAllActiveFaculties();

        // Send data to JSP
        request.setAttribute("classes", classes);
        request.setAttribute("subjects", subjects);
        request.setAttribute("faculties", faculties);

        request.getRequestDispatcher(
                "/create-assignment.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title =
                request.getParameter("title");

        String description =
                request.getParameter("description");

        String classIdValue =
                request.getParameter("classId");

        String subjectIdValue =
                request.getParameter("subjectId");

        String facultyIdValue =
                request.getParameter("facultyId");

        String deadline =
                request.getParameter("deadline");

        long classId;
        long subjectId;
        long facultyId;

        try {

            classId = Long.parseLong(classIdValue);
            subjectId = Long.parseLong(subjectIdValue);
            facultyId = Long.parseLong(facultyIdValue);

        } catch (Exception e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid class, subject or faculty selection."
            );

            return;
        }

        Assignment assignment = new Assignment();

        assignment.setTitle(title);
        assignment.setDescription(description);
        assignment.setClassId(classId);
        assignment.setSubjectId(subjectId);
        assignment.setFacultyId(facultyId);
        assignment.setDeadline(deadline);

        long assignmentId =
                assignmentService.createAssignment(
                        assignment
                );

        if (assignmentId > 0) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/faculty/assignments/create?success=true"
            );

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to create assignment. Check the entered values."
            );
        }
    }
}