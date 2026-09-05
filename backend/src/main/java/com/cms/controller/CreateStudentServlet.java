package com.cms.controller;

import java.io.IOException;

import com.cms.model.Student;
import com.cms.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/students/create")
public class CreateStudentServlet extends HttpServlet {

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/create-student.jsp")
                .forward(request, response);
    }

   @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String registerNo = request.getParameter("registerNo");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String department = request.getParameter("department");

        int semester = Integer.parseInt(
                request.getParameter("semester")
        );

        int admissionYear = Integer.parseInt(
                request.getParameter("admissionYear")
        );

        Student student = new Student();

        student.setRegisterNo(registerNo);
        student.setFirstName(firstName);
        student.setLastName(lastName);
        student.setDateOfBirth(dateOfBirth);
        student.setGender(gender);
        student.setPhone(phone);
        student.setDepartment(department);
        student.setSemester(semester);
        student.setAdmissionYear(admissionYear);

        boolean created = studentService.createStudent(
                email,
                password,
                student
        );

        if (created) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/students"
            );

        } else {

            response.setContentType("text/html");

            response.getWriter().println(
                    "<h1>Student Creation Failed</h1>"
            );

            response.getWriter().println(
                    "<p>Unable to create student.</p>"
            );
        }
    }
}