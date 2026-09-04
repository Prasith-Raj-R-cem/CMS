package com.cms;

import com.cms.model.Student;
import com.cms.service.StudentService;

public class TestStudentService {

    public static void main(String[] args) {

        StudentService studentService =
                new StudentService();

        Student student = new Student();

        student.setUserId(1);
        student.setRegisterNo("23CS104");
        student.setFirstName("Service");
        student.setLastName("Test");
        student.setDateOfBirth("2005-02-20");
        student.setGender("Male");
        student.setPhone("9876543211");
        student.setDepartment("Computer Science");
        student.setSemester(3);
        student.setAdmissionYear(2023);

        boolean result =
                studentService.createStudent(student);

        System.out.println(
                "Student service result: " + result
        );
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================