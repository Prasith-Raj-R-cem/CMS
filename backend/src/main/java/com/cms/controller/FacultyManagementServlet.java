package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Faculty;
import com.cms.repository.DepartmentRepository;
import com.cms.service.FacultyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/faculties",
        "/admin/faculties/create"
})
public class FacultyManagementServlet extends HttpServlet {

    private final FacultyService facultyService =
            new FacultyService();

    private final DepartmentRepository departmentRepository =
        new DepartmentRepository();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/faculties".equals(path)) {

            List<Faculty> faculties =
                    facultyService.getAllFaculties();

            request.setAttribute("faculties", faculties);

            request.getRequestDispatcher("/faculties.jsp")
                   .forward(request, response);

        } else if ("/admin/faculties/create".equals(path)) {

            request.setAttribute(
                    "departments",
                    departmentRepository.findAllActiveDepartments()
            );

            request.getRequestDispatcher("/create-faculty.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if (!"/admin/faculties/create".equals(path)) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Invalid request"
            );
            return;
        }

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String employeeId = request.getParameter("employeeId");
        String departmentIdParameter =
                request.getParameter("departmentId");

        if (email == null || email.isBlank()
                || password == null || password.isBlank()
                || employeeId == null || employeeId.isBlank()
                || departmentIdParameter == null
                || departmentIdParameter.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "All fields are required"
            );
            return;
        }

        long departmentId;

        try {
            departmentId =
                    Long.parseLong(departmentIdParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid department ID"
            );
            return;
        }

        Faculty faculty = new Faculty();

        faculty.setEmployeeId(employeeId);
        faculty.setDepartmentId(departmentId);

        boolean created =
                facultyService.createFaculty(
                        email,
                        password,
                        faculty
                );

        if (created) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/faculties"
            );

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to create faculty"
            );
        }
    }
}