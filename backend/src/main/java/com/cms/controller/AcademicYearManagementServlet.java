package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.AcademicYear;
import com.cms.service.AcademicYearService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/academic-years",
        "/admin/academic-years/create"
})
public class AcademicYearManagementServlet extends HttpServlet {

    private final AcademicYearService academicYearService =
            new AcademicYearService();


    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {

            case "/admin/academic-years":
                showAcademicYears(request, response);
                break;

            case "/admin/academic-years/create":
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

            case "/admin/academic-years/create":
                createAcademicYear(request, response);
                break;

            default:
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND);
        }
    }


    // =========================
    // SHOW ACADEMIC YEAR LIST
    // =========================

    private void showAcademicYears(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<AcademicYear> academicYears =
                academicYearService
                        .getAllActiveAcademicYears();

        request.setAttribute(
                "academicYears",
                academicYears);

        request.getRequestDispatcher(
                "/academic-years.jsp")
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
                "/create-academic-year.jsp")
                .forward(request, response);
    }


    // =========================
    // CREATE ACADEMIC YEAR
    // =========================

    private void createAcademicYear(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String yearName =
                request.getParameter("yearName");

        String startDate =
                request.getParameter("startDate");

        String endDate =
                request.getParameter("endDate");


        AcademicYear academicYear =
                new AcademicYear();

        academicYear.setYearName(yearName);
        academicYear.setStartDate(startDate);
        academicYear.setEndDate(endDate);


        long id =
                academicYearService
                        .createAcademicYear(academicYear);


        if (id > 0) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/academic-years");

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unable to create academic year");
        }
    }
}