package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Timetable;
import com.cms.repository.TimetableLookupRepository;
import com.cms.service.TimetableService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/timetables",
        "/admin/timetables/create",
        "/admin/timetables/edit",
        "/admin/timetables/delete"
})
public class TimetableManagementServlet extends HttpServlet {

    private final TimetableService timetableService =
            new TimetableService();

    private final TimetableLookupRepository lookupRepository =
            new TimetableLookupRepository();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        // View all timetables
        if ("/admin/timetables".equals(path)) {

            List<Timetable> timetables =
                    timetableService.getAllTimetables();

            request.setAttribute(
                    "timetables",
                    timetables
            );

            request.getRequestDispatcher(
                    "/timetables.jsp"
            ).forward(request, response);

            return;
        }

        // Show create timetable form
        if ("/admin/timetables/create".equals(path)) {

            loadDropdownData(request);

            request.getRequestDispatcher(
                    "/create-timetable.jsp"
            ).forward(request, response);

            return;
        }

        // Show edit timetable form
        if ("/admin/timetables/edit".equals(path)) {

            String idParameter =
                    request.getParameter("id");

            if (idParameter == null
                    || idParameter.isBlank()) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Timetable ID is required"
                );
                return;
            }

            long timetableId;

            try {

                timetableId =
                        Long.parseLong(idParameter);

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid timetable ID"
                );
                return;
            }

            Timetable timetable =
                    timetableService.findTimetableById(
                            timetableId
                    );

            if (timetable == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Timetable not found"
                );
                return;
            }

            loadDropdownData(request);

            request.setAttribute(
                    "timetable",
                    timetable
            );

            request.getRequestDispatcher(
                    "/edit-timetable.jsp"
            ).forward(request, response);

            return;
        }

        response.sendError(
                HttpServletResponse.SC_NOT_FOUND
        );
    }

    private void loadDropdownData(
            HttpServletRequest request) {

        request.setAttribute(
                "classes",
                lookupRepository.getActiveClasses()
        );

        request.setAttribute(
                "subjects",
                lookupRepository.getActiveSubjects()
        );

        request.setAttribute(
                "faculties",
                lookupRepository.getActiveFaculties()
        );

        request.setAttribute(
                "periods",
                lookupRepository.getActivePeriods()
        );

        request.setAttribute(
                "rooms",
                lookupRepository.getActiveRooms()
        );

        request.setAttribute(
                "academicYears",
                lookupRepository.getActiveAcademicYears()
        );

        request.setAttribute(
                "semesters",
                lookupRepository.getActiveSemesters()
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        // Delete timetable
        if ("/admin/timetables/delete".equals(path)) {

            String idParameter =
                    request.getParameter("id");

            if (idParameter == null
                    || idParameter.isBlank()) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Timetable ID is required"
                );
                return;
            }

            long timetableId;

            try {

                timetableId =
                        Long.parseLong(idParameter);

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid timetable ID"
                );
                return;
            }

            boolean deleted =
                    timetableService.deleteTimetable(
                            timetableId
                    );

            if (deleted) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/timetables"
                );

            } else {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Unable to delete timetable"
                );
            }

            return;
        }

        // Create timetable
        if ("/admin/timetables/create".equals(path)) {

            Timetable timetable =
                    buildTimetableFromRequest(request);

            long timetableId =
                    timetableService.createTimetable(
                            timetable
                    );

            if (timetableId != -1) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/timetables"
                );

            } else {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Unable to create timetable"
                );
            }

            return;
        }

        // Update timetable
        if ("/admin/timetables/edit".equals(path)) {

            String idParameter =
                    request.getParameter("id");

            if (idParameter == null
                    || idParameter.isBlank()) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Timetable ID is required"
                );
                return;
            }

            long timetableId;

            try {

                timetableId =
                        Long.parseLong(idParameter);

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid timetable ID"
                );
                return;
            }

            Timetable timetable =
                    buildTimetableFromRequest(request);

            timetable.setId(timetableId);

            boolean updated =
                    timetableService.updateTimetable(
                            timetable
                    );

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/timetables"
                );

            } else {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Unable to update timetable"
                );
            }

            return;
        }

        response.sendError(
                HttpServletResponse.SC_NOT_FOUND
        );
    }

    private Timetable buildTimetableFromRequest(
            HttpServletRequest request) {

        Timetable timetable = new Timetable();

        timetable.setClassId(
                parseLong(
                        request.getParameter("classId")
                )
        );

        timetable.setSubjectId(
                parseLong(
                        request.getParameter("subjectId")
                )
        );

        timetable.setFacultyId(
                parseLong(
                        request.getParameter("facultyId")
                )
        );

        timetable.setPeriodId(
                parseLong(
                        request.getParameter("periodId")
                )
        );

        String roomId =
                request.getParameter("roomId");

        if (roomId == null
                || roomId.isBlank()) {

            timetable.setRoomId(null);

        } else {

            timetable.setRoomId(
                    parseLong(roomId)
            );
        }

        timetable.setAcademicYearId(
                parseLong(
                        request.getParameter(
                                "academicYearId"
                        )
                )
        );

        timetable.setSemesterId(
                parseLong(
                        request.getParameter(
                                "semesterId"
                        )
                )
        );

        timetable.setDayOfWeek(
                request.getParameter(
                        "dayOfWeek"
                )
        );

        return timetable;
    }

    private long parseLong(String value) {

        if (value == null
                || value.isBlank()) {

            return 0;
        }

        try {

            return Long.parseLong(value);

        } catch (NumberFormatException e) {

            return 0;
        }
    }
}