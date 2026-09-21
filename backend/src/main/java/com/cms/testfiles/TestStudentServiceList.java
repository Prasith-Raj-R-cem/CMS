package com.cms.testfiles;

import java.util.List;

import com.cms.model.Student;
import com.cms.service.StudentService;

public class TestStudentServiceList {

    public static void main(String[] args) {

        StudentService studentService =
                new StudentService();

        List<Student> students =
                studentService.getAllStudents();

        System.out.println(
                "Total students: " + students.size()
        );

        for (Student student : students) {

            System.out.println(
                    student.getId()
                    + " | "
                    + student.getRegisterNo()
                    + " | "
                    + student.getFirstName()
                    + " "
                    + student.getLastName()
            );
        }
    }
}


// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================