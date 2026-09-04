package com.cms.service;

import java.util.List;

import com.cms.model.Role;
import com.cms.model.Student;
import com.cms.model.User;
import com.cms.repository.StudentRepository;
import com.cms.repository.UserRepository;

public class StudentService {

    private final StudentRepository studentRepository =
            new StudentRepository();

    private final UserRepository userRepository =
            new UserRepository();

    public boolean createStudent(Student student) {

        if (student == null) {
            return false;
        }

        if (student.getRegisterNo() == null ||
            student.getRegisterNo().isBlank()) {
            return false;
        }

        if (student.getFirstName() == null ||
            student.getFirstName().isBlank()) {
            return false;
        }

        if (student.getDepartment() == null ||
            student.getDepartment().isBlank()) {
            return false;
        }

        if (student.getSemester() < 1 ||
            student.getSemester() > 8) {
            return false;
        }

        if (student.getAdmissionYear() < 2000 ||
            student.getAdmissionYear() > 2100) {
            return false;
        }

        User user =
                userRepository.findById(
                        student.getUserId()
                );

        if (user == null) {
            return false;
        }

        if (!Role.STUDENT.equals(user.getRole())) {
            return false;
        }

        return studentRepository.createStudent(student);
    }

    public List<Student> getAllStudents() {

        return studentRepository.findAllStudents();
    }
}