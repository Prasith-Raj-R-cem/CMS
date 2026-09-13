package com.cms;

import com.cms.model.Student;
import com.cms.repository.StudentRepository;

public class TestStudentClass {

    public static void main(String[] args) {

        StudentRepository repository = new StudentRepository();

        Student student = repository.findById(2);

        if (student != null) {

            System.out.println("Student found successfully!");
            System.out.println("ID: " + student.getId());
            System.out.println("Register No: " + student.getRegisterNo());
            System.out.println("Name: "
                    + student.getFirstName()
                    + " "
                    + student.getLastName());

            System.out.println("Class ID: " + student.getClassId());

        } else {

            System.out.println("Student not found!");
        }
    }
}