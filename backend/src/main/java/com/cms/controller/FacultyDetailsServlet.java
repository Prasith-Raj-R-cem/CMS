package com.cms.controller;

import java.io.IOException;

import com.cms.model.FacultyDetails;
import com.cms.service.FacultyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/faculties/view")
public class FacultyDetailsServlet extends HttpServlet {

    private final FacultyService facultyService =
            new FacultyService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        if (idParameter == null || idParameter.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Faculty ID is required"
            );

            return;
        }

        long facultyId;

        try {

            facultyId =
                    Long.parseLong(idParameter);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid faculty ID"
            );

            return;
        }

        FacultyDetails faculty =
                facultyService.findFacultyDetailsById(
                        facultyId
                );

        if (faculty == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Faculty not found"
            );

            return;
        }

        request.setAttribute(
                "faculty",
                faculty
        );

        request.getRequestDispatcher(
                "/faculty-details.jsp"
        ).forward(request, response);
    }
}