package com.cms;

import com.cms.model.Student;
import com.cms.repository.StudentRepository;

public class TestStudentCreation {

    public static void main(String[] args) {

        StudentRepository repository =
                new StudentRepository();

        Student student = new Student();

        student.setUserId(3);
        student.setRegisterNo("23CS101");
        student.setFirstName("Test");
        student.setLastName("Student");
        student.setDateOfBirth("2005-01-15");
        student.setGender("Male");
        student.setPhone("9876543210");
        student.setDepartment("Computer Science");
        student.setSemester(3);
        student.setAdmissionYear(2023);

        boolean result =
                repository.createStudent(student);

        System.out.println(
                "Student creation result: " + result
        );
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================