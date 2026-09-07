package com.cms.service;

import java.sql.Connection;
import java.util.List;

import com.cms.model.Faculty;
import com.cms.model.FacultyDetails;
import com.cms.model.Role;
import com.cms.repository.FacultyRepository;
import com.cms.repository.UserRepository;
import com.cms.util.DatabaseConnection;

public class FacultyService {

    private final FacultyRepository facultyRepository;
    private final UserRepository userRepository;
    private final UserService userService;

    public FacultyService() {
        this.facultyRepository = new FacultyRepository();
        this.userRepository = new UserRepository();
        this.userService = new UserService();
    }

    public boolean createFaculty(
            String email,
            String password,
            Faculty faculty
    ) {

        if (email == null || email.isBlank()) {
            return false;
        }

        if (password == null || password.isBlank()) {
            return false;
        }

        if (faculty == null) {
            return false;
        }

        if (faculty.getEmployeeId() == null
                || faculty.getEmployeeId().isBlank()) {
            return false;
        }

        if (faculty.getDepartmentId() <= 0) {
            return false;
        }

        try (Connection connection =
                     DatabaseConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {

                // Step 1: Create user account
                long userId = userService.createUserAndGetId(
                        connection,
                        email,
                        password,
                        Role.FACULTY
                );

                if (userId == -1) {
                    connection.rollback();
                    return false;
                }

                // Step 2: Connect faculty to user
                faculty.setUserId(userId);

                faculty.setStatus("ACTIVE");

                // Step 3: Create faculty record
                boolean facultyCreated =
                        facultyRepository.createFaculty(
                                connection,
                                faculty
                        );

                if (!facultyCreated) {
                    connection.rollback();
                    return false;
                }

                // Step 4: Everything succeeded
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

    public Faculty findFacultyById(long id) {

        if (id <= 0) {
            return null;
        }

        return facultyRepository.findById(id);
    }

    public List<Faculty> getAllFaculties() {

        return facultyRepository.findAllFaculties();
    }

    public FacultyDetails findFacultyDetailsById(long id) {

        if (id <= 0) {
            return null;
        }

        return facultyRepository.findDetailsById(id);
    }


    public boolean updateFaculty(Faculty faculty) {

        if (faculty == null) {
            return false;
        }

        if (faculty.getId() <= 0) {
            return false;
        }

        if (faculty.getEmployeeId() == null
                || faculty.getEmployeeId().isBlank()) {
            return false;
        }

        if (faculty.getDepartmentId() <= 0) {
            return false;
        }

        Faculty existingFaculty =
                facultyRepository.findById(faculty.getId());

        if (existingFaculty == null) {
            return false;
        }

        return facultyRepository.updateFaculty(faculty);
    }

    public boolean updateFacultyStatus(long facultyId, String status) {

        if (facultyId <= 0) {
            return false;
        }

        if (status == null
                || (!"ACTIVE".equals(status)
                && !"INACTIVE".equals(status))) {
            return false;
        }

        Faculty faculty =
                facultyRepository.findById(facultyId);

        if (faculty == null) {
            return false;
        }

        long userId = faculty.getUserId();

        try (Connection connection =
                     DatabaseConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {

                boolean facultyUpdated =
                        facultyRepository.updateStatus(
                                connection,
                                facultyId,
                                status
                        );

                if (!facultyUpdated) {
                    connection.rollback();
                    return false;
                }

                boolean userUpdated =
                    userService.updateUserStatus(
                            connection,
                            userId,
                            status
                    );

                if (!userUpdated) {
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

    public boolean updateUserStatus(
            Connection connection,
            long id,
            String status
    ) {
    
        if (status == null || status.isBlank()) {
            return false;
        }
    
        if (!"ACTIVE".equals(status)
                && !"INACTIVE".equals(status)) {
            return false;
        }
    
        if (id <= 0) {
            return false;
        }
    
        return userRepository.updateStatus(
                connection,
                id,
                status
        );
    }
}