package com.cms.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.cms.model.Class;
import com.cms.model.Department;
import com.cms.model.Semester;
import com.cms.model.Subject;
import com.cms.repository.DepartmentRepository;
import com.cms.service.ClassService;
import com.cms.service.SemesterService;
import com.cms.service.SubjectService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/subjects",
        "/admin/subjects/create"
})
public class SubjectManagementServlet extends HttpServlet {

    private SubjectService subjectService;
    private DepartmentRepository departmentRepository;
    private SemesterService semesterService;
    private ClassService classService;

    @Override
    public void init() {

        subjectService = new SubjectService();
        departmentRepository = new DepartmentRepository();
        semesterService = new SemesterService();
        classService = new ClassService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/subjects".equals(path)) {

            List<Subject> subjects =
                    subjectService.getAllActiveSubjects();

            request.setAttribute("subjects", subjects);

            request.getRequestDispatcher("/subjects.jsp")
                    .forward(request, response);

        } else if ("/admin/subjects/create".equals(path)) {

            loadDropdownData(request);

            request.getRequestDispatcher("/create-subject.jsp")
                    .forward(request, response);
        }
    }

    private void loadDropdownData(HttpServletRequest request) {

        // Load active departments
        List<Department> departments =
                departmentRepository.findAllActiveDepartments();

        // Load active semesters
        List<Semester> semesters =
                semesterService.getAllActiveSemesters();

        // Load active classes
        List<Class> classes =
                classService.getAllActiveClasses();

        request.setAttribute("departments", departments);
        request.setAttribute("semesters", semesters);
        request.setAttribute("classes", classes);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String path = request.getServletPath();

        if ("/admin/subjects/create".equals(path)) {

            try {

                String subjectCode =
                        request.getParameter("subjectCode");

                String subjectName =
                        request.getParameter("subjectName");

                long departmentId =
                        Long.parseLong(
                                request.getParameter("departmentId")
                        );

                long semesterId =
                        Long.parseLong(
                                request.getParameter("semesterId")
                        );

                BigDecimal credits =
                        new BigDecimal(
                                request.getParameter("credits")
                        );

                String subjectType =
                        request.getParameter("subjectType");


                Subject subject = new Subject();

                subject.setSubjectCode(subjectCode);
                subject.setSubjectName(subjectName);
                subject.setDepartmentId(departmentId);
                subject.setSemesterId(semesterId);
                subject.setCredits(credits);
                subject.setSubjectType(subjectType);


                long generatedId =
                        subjectService.createSubject(subject);


                if (generatedId > 0) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/subjects"
                    );

                } else {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Unable to create subject"
                    );
                }

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid numeric value"
                );

            } catch (Exception e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid subject data"
                );
            }
        }
    }
}