package com.cms;

import java.util.List;

import com.cms.model.User;
import com.cms.service.UserService;

public class TestUserServiceUsers {

    public static void main(String[] args) {

        UserService userService =
                new UserService();

        List<User> users =
                userService.findAllUsers();

        System.out.println("=== USERS THROUGH SERVICE ===");

        for (User user : users) {

            System.out.println(
                    "ID: " + user.getId()
            );

            System.out.println(
                    "Email: " + user.getEmail()
            );

            System.out.println(
                    "Role: " + user.getRole()
            );

            System.out.println(
                    "Status: " + user.getStatus()
            );

            System.out.println("--------------------");
        }
    }
}


// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.fetching the users and data through sevice layer.

//=================================================================================================================================