package com.cms.service;

import java.sql.Connection;
import java.util.List;

import com.cms.model.Role;
import com.cms.model.Student;
import com.cms.model.User;
import com.cms.repository.StudentRepository;
import com.cms.repository.UserRepository;
import com.cms.util.DatabaseConnection;

public class StudentService {

    private final StudentRepository studentRepository =
            new StudentRepository();

    private final UserRepository userRepository =
            new UserRepository();
    
    private final UserService userService =
            new UserService();

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

    public Student findStudentById(long id) {

        if (id <= 0) {
            return null;
        }

        return studentRepository.findById(id);
    }


    public boolean updateStudent(Student student) {

        if (student == null) {
            return false;
        }

        if (student.getId() <= 0) {
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

        Student existingStudent =
                studentRepository.findById(student.getId());

        if (existingStudent == null) {
            return false;
        }

        return studentRepository.updateStudent(student);
    }

    //  the transaction-aware method.

    public boolean createStudent(
            String email,
            String password,
            Student student
    ) {
    
        if (email == null || email.isBlank()) {
            return false;
        }
    
        if (password == null || password.isBlank()) {
            return false;
        }
    
        if (student == null) {
            return false;
        }
    
        try (Connection connection =
                     DatabaseConnection.getConnection()) {
                    
            connection.setAutoCommit(false);
    
            try {
            
                long userId =
                        userService.createUserAndGetId(
                                connection,
                                email,
                                password,
                                Role.STUDENT
                        );
    
                if (userId == -1) {
                    connection.rollback();
                    return false;
                }
    
                student.setUserId(userId);
    
                boolean studentCreated =
                        studentRepository.createStudent(
                                connection,
                                student
                        );
    
                if (!studentCreated) {
                    connection.rollback();
                    return false;
                }
    
                connection.commit();
    
                return true;
    
            } catch (Exception e) {
            
                connection.rollback();
    
                throw e;
            }
    
        } catch (Exception e) {
        
            e.printStackTrace();
    
            return false;
        }
    }

    public boolean deleteStudent(long studentId) {

        if (studentId <= 0) {
            return false;
        }
    
        Student student = studentRepository.findById(studentId);
    
        if (student == null) {
            return false;
        }
    
        long userId = student.getUserId();
    
        try (Connection connection = DatabaseConnection.getConnection()) {
        
            connection.setAutoCommit(false);
    
            try {
            
                // Step 1: Delete student
                boolean studentDeleted =
                        studentRepository.deleteStudent(connection, studentId);
    
                if (!studentDeleted) {
                    connection.rollback();
                    return false;
                }
    
                // Step 2: Delete corresponding user
                boolean userDeleted =
                        userRepository.deleteUser(connection, userId);
    
                if (!userDeleted) {
                    connection.rollback();
                    return false;
                }
    
                // Step 3: Both succeeded
                connection.commit();
    
                return true;
    
            } catch (Exception e) {
            
                connection.rollback();
                throw e;
            }
    
        } catch (Exception e) {
        
            e.printStackTrace();
            return false;
        }
    }
}