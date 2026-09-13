package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.AcademicYear;
import com.cms.model.Semester;
import com.cms.repository.AcademicYearRepository;
import com.cms.service.SemesterService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/semesters",
        "/admin/semesters/create"
})
public class SemesterManagementServlet extends HttpServlet {

    private SemesterService semesterService;
    private AcademicYearRepository academicYearRepository;

    @Override
    public void init() {

        semesterService = new SemesterService();
        academicYearRepository = new AcademicYearRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/semesters".equals(path)) {

            List<Semester> semesters =
                    semesterService.getAllActiveSemesters();

            request.setAttribute("semesters", semesters);

            request.getRequestDispatcher("/semesters.jsp")
                    .forward(request, response);

        } else if ("/admin/semesters/create".equals(path)) {

            List<AcademicYear> academicYears =
                    academicYearRepository.findAllActiveAcademicYears();

            request.setAttribute("academicYears", academicYears);

            request.getRequestDispatcher("/create-semester.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String path = request.getServletPath();

        if ("/admin/semesters/create".equals(path)) {

            try {

                long academicYearId = Long.parseLong(
                        request.getParameter("academicYearId")
                );

                int semesterNumber = Integer.parseInt(
                        request.getParameter("semesterNumber")
                );

                String semesterName =
                        request.getParameter("semesterName");

                Semester semester = new Semester();

                semester.setAcademicYearId(academicYearId);
                semester.setSemesterNumber(semesterNumber);
                semester.setSemesterName(semesterName);

                long generatedId =
                        semesterService.createSemester(semester);

                if (generatedId > 0) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/semesters"
                    );

                } else {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Unable to create semester"
                    );
                }

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid academic year or semester number"
                );
            }
        }
    }
}