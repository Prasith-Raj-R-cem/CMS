package com.cms.controller;

import java.io.IOException;

import com.cms.model.Student;
import com.cms.service.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/students/edit")
public class EditStudentServlet extends HttpServlet {

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter =
                request.getParameter("id");

        if (idParameter == null || idParameter.isBlank()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Student ID is required"
            );
            return;
        }

        long studentId;

        try {
            studentId = Long.parseLong(idParameter);
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid student ID"
            );
            return;
        }

        Student student =
                studentService.findStudentById(studentId);

        if (student == null) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Student not found"
            );
            return;
        }

        request.setAttribute("student", student);

        request.getRequestDispatcher(
                "/edit-student.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter = request.getParameter("id");

        if (idParameter == null || idParameter.isBlank()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Student ID is required"
            );
            return;
        }

        long studentId;

        try {
            studentId = Long.parseLong(idParameter);
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid student ID"
            );
            return;
        }

        String registerNo = request.getParameter("registerNo");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String department = request.getParameter("department");
        String semesterParameter = request.getParameter("semester");
        String admissionYearParameter = request.getParameter("admissionYear");

        int semester;
        int admissionYear;

        try {
            semester = Integer.parseInt(semesterParameter);
            admissionYear = Integer.parseInt(admissionYearParameter);
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid semester or admission year"
            );
            return;
        }

        Student student = new Student();

        student.setId(studentId);
        student.setRegisterNo(registerNo);
        student.setFirstName(firstName);
        student.setLastName(lastName);
        student.setDateOfBirth(dateOfBirth);
        student.setGender(gender);
        student.setPhone(phone);
        student.setDepartment(department);
        student.setSemester(semester);
        student.setAdmissionYear(admissionYear);

        boolean updated = studentService.updateStudent(student);

        if (updated) {
            response.sendRedirect(
                    request.getContextPath() + "/admin/students"
            );
        } else {
            request.setAttribute(
                    "errorMessage",
                    "Unable to update student. Register number may already exist."
            );
        
            Student existingStudent =
                    studentService.findStudentById(studentId);
        
            request.setAttribute("student", existingStudent);
        
            request.getRequestDispatcher("/edit-student.jsp")
                   .forward(request, response);
        }
    }
}