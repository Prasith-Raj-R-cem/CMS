package com.cms;

import com.cms.model.Student;
import com.cms.repository.StudentRepository;

public class TestStudentFind {

    public static void main(String[] args) {

        StudentRepository repository =
                new StudentRepository();

        Student student =
                repository.findById(2);

        if (student != null) {

            System.out.println(
                    "Student found: " +
                    student.getRegisterNo()
            );

            System.out.println(
                    "Name: " +
                    student.getFirstName() +
                    " " +
                    student.getLastName()
            );

            System.out.println(
                    "Department: " +
                    student.getDepartment()
            );

            System.out.println(
                    "Semester: " +
                    student.getSemester()
            );

        } else {

            System.out.println(
                    "Student not found"
            );
        }
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================