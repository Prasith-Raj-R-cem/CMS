package com.cms.testfiles;

import java.util.List;

import com.cms.model.Student;
import com.cms.repository.StudentRepository;

public class TestStudentList {

    public static void main(String[] args) {

        StudentRepository repository =
                new StudentRepository();

        List<Student> students =
                repository.findAllStudents();

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