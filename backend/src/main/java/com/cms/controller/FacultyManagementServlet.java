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
    "/admin/faculties/create",
    "/admin/faculties/edit",
    "/admin/faculties/status",
    "/admin/faculties/delete"
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

        else if ("/admin/faculties/edit".equals(path)) {

            String idParameter = request.getParameter("id");

            if (idParameter == null || idParameter.isBlank()) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Faculty ID is required"
                );
                return;
            }

            long facultyId;

            try {
                facultyId = Long.parseLong(idParameter);
            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid faculty ID"
                );
                return;
            }

            Faculty faculty =
                    facultyService.findFacultyById(facultyId);

            if (faculty == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Faculty not found"
                );
                return;
            }

            request.setAttribute("faculty", faculty);

            request.setAttribute(
                    "departments",
                    departmentRepository.findAllActiveDepartments()
            );

            request.getRequestDispatcher("/edit-faculty.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/faculties/delete".equals(path)) {

            String idParameter = request.getParameter("id");
        
            if (idParameter == null || idParameter.isBlank()) {
            
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Faculty ID is required"
                );
                return;
            }
        
            long facultyId;
        
            try {
                facultyId = Long.parseLong(idParameter);
            } catch (NumberFormatException e) {
            
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid faculty ID"
                );
                return;
            }
        
            boolean deleted = facultyService.deleteFaculty(facultyId);
        
            if (deleted) {
            
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/faculties"
                );
        
            } else {
            
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Unable to delete faculty"
                );
            }
        
            return;
        }

        if ("/admin/faculties/status".equals(path)) {

            String idParameter = request.getParameter("id");
            String status = request.getParameter("status");

            if (idParameter == null || idParameter.isBlank()
                    || status == null || status.isBlank()) {
                    
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Faculty ID and status are required"
                );
                return;
            }

            long facultyId;

            try {
                facultyId = Long.parseLong(idParameter);
            } catch (NumberFormatException e) {
            
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid faculty ID"
                );
                return;
            }

            boolean updated =
                    facultyService.updateFacultyStatus(
                            facultyId,
                            status
                    );

            if (updated) {
            
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/faculties"
                );

            } else {
            
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Unable to update faculty status"
                );
            }

            return;
        }

        if ("/admin/faculties/edit".equals(path)) {

            String idParameter = request.getParameter("id");
            String employeeId = request.getParameter("employeeId");
            String departmentIdParameter =
                    request.getParameter("departmentId");

            if (idParameter == null || idParameter.isBlank()
                    || employeeId == null || employeeId.isBlank()
                    || departmentIdParameter == null
                    || departmentIdParameter.isBlank()) {
                    
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "All fields are required"
                );

                return;
            }

            long facultyId;
            long departmentId;

            try {
            
                facultyId = Long.parseLong(idParameter);
                departmentId = Long.parseLong(departmentIdParameter);

            } catch (NumberFormatException e) {
            
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid ID"
                );

                return;
            }

            Faculty faculty = new Faculty();

            faculty.setId(facultyId);
            faculty.setEmployeeId(employeeId);
            faculty.setDepartmentId(departmentId);

            boolean updated =
                    facultyService.updateFaculty(faculty);

            if (updated) {
            
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/faculties"
                );

            } else {
            
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Unable to update faculty"
                );
            }

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