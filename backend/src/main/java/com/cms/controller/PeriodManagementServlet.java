package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Period;
import com.cms.service.PeriodService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/periods",
        "/admin/periods/create"
})
public class PeriodManagementServlet extends HttpServlet {

    private PeriodService periodService;

    @Override
    public void init() {
        periodService = new PeriodService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/periods".equals(path)) {

            List<Period> periods =
                    periodService.getAllActivePeriods();

            request.setAttribute("periods", periods);

            request.getRequestDispatcher("/periods.jsp")
                    .forward(request, response);

        } else if ("/admin/periods/create".equals(path)) {

            request.getRequestDispatcher("/create-period.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String path = request.getServletPath();

        if ("/admin/periods/create".equals(path)) {

            try {

                int periodNumber =
                        Integer.parseInt(
                                request.getParameter("periodNumber")
                        );

                String startTime =
                        request.getParameter("startTime");

                String endTime =
                        request.getParameter("endTime");


                Period period = new Period();

                period.setPeriodNumber(periodNumber);
                period.setStartTime(startTime);
                period.setEndTime(endTime);


                long generatedId =
                        periodService.createPeriod(period);


                if (generatedId > 0) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/periods"
                    );

                } else {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Unable to create period"
                    );
                }

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid period number"
                );

            } catch (Exception e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid period data"
                );
            }
        }
    }
}