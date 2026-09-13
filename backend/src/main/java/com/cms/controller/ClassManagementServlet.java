package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Class;
import com.cms.model.TimetableOption;
import com.cms.repository.DepartmentRepository;
import com.cms.repository.TimetableLookupRepository;
import com.cms.service.ClassService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/classes",
        "/admin/classes/create",
        "/admin/classes/edit",
        "/admin/classes/status",
        "/admin/classes/delete"
})
public class ClassManagementServlet extends HttpServlet {

    private final ClassService classService = new ClassService();
    private final DepartmentRepository departmentRepository =
            new DepartmentRepository();
    private final TimetableLookupRepository timetableLookupRepository =
            new TimetableLookupRepository();


    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {

            case "/admin/classes":
                showClasses(request, response);
                break;

            case "/admin/classes/create":
                showCreateForm(request, response);
                break;

            case "/admin/classes/edit":
                showEditForm(request, response);
                break;

            default:
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {

            case "/admin/classes/create":
                createClass(request, response);
                break;

            case "/admin/classes/edit":
                updateClass(request, response);
                break;

            case "/admin/classes/status":
                updateStatus(request, response);
                break;

            case "/admin/classes/delete":
                deleteClass(request, response);
                break;

            default:
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND);
        }
    }


    // =========================
    // SHOW CLASS LIST
    // =========================

    private void showClasses(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        List<Class> classes =
                classService.getAllClasses();

        request.setAttribute("classes", classes);

        request.getRequestDispatcher("/classes.jsp")
                .forward(request, response);
    }


    // =========================
    // SHOW CREATE FORM
    // =========================

    private void showCreateForm(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {

        loadDropdownData(request);

        request.getRequestDispatcher("/create-class.jsp")
                .forward(request, response);
    }


    // =========================
    // SHOW EDIT FORM
    // =========================

    private void showEditForm(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        long id = parseLong(
                request.getParameter("id"));

        if (id <= 0) {
            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/classes");

            return;
        }

        Class classData =
                classService.findClassById(id);

        if (classData == null) {
            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/classes");

            return;
        }

        request.setAttribute(
                "classData",
                classData);

        loadDropdownData(request);

        request.getRequestDispatcher("/edit-class.jsp")
                .forward(request, response);
    }


    // =========================
    // CREATE CLASS
    // =========================

    private void createClass(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {

        Class classData =
                buildClassFromRequest(request);

        long id =
                classService.createClass(classData);

        if (id > 0) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/classes");

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to create class");
        }
    }


    // =========================
    // UPDATE CLASS
    // =========================

    private void updateClass(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {

        long id = parseLong(
                request.getParameter("id"));

        if (id <= 0) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid class ID");

            return;
        }

        Class classData =
                buildClassFromRequest(request);

        classData.setId(id);

        boolean updated =
                classService.updateClass(classData);

        if (updated) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/classes");

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to update class");
        }
    }


    // =========================
    // UPDATE STATUS
    // =========================

    private void updateStatus(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {

        long id = parseLong(
                request.getParameter("id"));

        String status =
                request.getParameter("status");

        boolean updated =
                classService.updateClassStatus(
                        id,
                        status);

        response.sendRedirect(
                request.getContextPath() +
                "/admin/classes");
    }


    // =========================
    // DELETE CLASS
    // =========================

    private void deleteClass(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {

        long id = parseLong(
                request.getParameter("id"));

        boolean deleted =
                classService.deleteClass(id);

        response.sendRedirect(
                request.getContextPath() +
                "/admin/classes");
    }


    // =========================
    // BUILD CLASS FROM REQUEST
    // =========================

    private Class buildClassFromRequest(
            HttpServletRequest request) {

        Class classData = new Class();

        classData.setClassName(
                request.getParameter("className"));

        classData.setDepartmentId(
                parseLong(
                        request.getParameter("departmentId")));

        classData.setSemesterId(
                parseLong(
                        request.getParameter("semesterId")));

        classData.setAcademicYearId(
                parseLong(
                        request.getParameter("academicYearId")));

        classData.setSection(
                request.getParameter("section"));

        classData.setStatus("ACTIVE");

        return classData;
    }


    // =========================
    // LOAD DROPDOWNS
    // =========================

    private void loadDropdownData(
            HttpServletRequest request) {

        List<TimetableOption> departments =
                departmentRepository.findAllActiveDepartments()
                        .stream()
                        .map(department ->
                                new TimetableOption(
                                        department.getId(),
                                        department.getDepartmentCode()
                                                + " - "
                                                + department.getDepartmentName()))
                        .toList();

        List<TimetableOption> academicYears =
                timetableLookupRepository
                        .getActiveAcademicYears();

        List<TimetableOption> semesters =
                timetableLookupRepository
                        .getActiveSemesters();

        request.setAttribute(
                "departments",
                departments);

        request.setAttribute(
                "academicYears",
                academicYears);

        request.setAttribute(
                "semesters",
                semesters);
    }


    // =========================
    // PARSE LONG
    // =========================

    private long parseLong(String value) {

        if (value == null ||
            value.isBlank()) {

            return -1;
        }

        try {

            return Long.parseLong(value);

        } catch (NumberFormatException e) {

            return -1;
        }
    }
}