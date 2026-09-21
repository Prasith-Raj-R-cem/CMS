package com.cms.testfiles;
import com.cms.model.Role;
import com.cms.service.UserService;

public class TestUserCreation {

    public static void main(String[] args) {

        UserService userService = new UserService();

        boolean facultyCreated =
                userService.createUser(
                        "faculty@campus.local",
                        "faculty123",
                        Role.FACULTY
                );

        System.out.println(
                "Faculty created: " + facultyCreated
        );

        boolean studentCreated =
                userService.createUser(
                        "student@campus.local",
                        "student123",
                        Role.STUDENT
                );

        System.out.println(
                "Student created: " + studentCreated
        );
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================