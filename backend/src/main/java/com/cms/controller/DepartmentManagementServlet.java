package com.cms.controller;

import com.cms.model.Department;
import com.cms.service.DepartmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin/departments",
        "/admin/departments/create"
})
public class DepartmentManagementServlet extends HttpServlet {

    private final DepartmentService departmentService =
            new DepartmentService();


    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {

            case "/admin/departments":
                showDepartments(request, response);
                break;

            case "/admin/departments/create":
                showCreateForm(request, response);
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

            case "/admin/departments/create":
                createDepartment(request, response);
                break;

            default:
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND);
        }
    }


    // =========================
    // SHOW DEPARTMENT LIST
    // =========================

    private void showDepartments(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Department> departments =
                departmentService.getAllActiveDepartments();

        request.setAttribute(
                "departments",
                departments);

        request.getRequestDispatcher(
                "/departments.jsp")
                .forward(request, response);
    }


    // =========================
    // SHOW CREATE FORM
    // =========================

    private void showCreateForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/create-department.jsp")
                .forward(request, response);
    }


    // =========================
    // CREATE DEPARTMENT
    // =========================

    private void createDepartment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String departmentCode =
                request.getParameter("departmentCode");

        String departmentName =
                request.getParameter("departmentName");

        Department department =
                new Department();

        department.setDepartmentCode(
                departmentCode);

        department.setDepartmentName(
                departmentName);

        long id =
                departmentService.createDepartment(
                        department);

        if (id > 0) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/departments");

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to create department");
        }
    }
}