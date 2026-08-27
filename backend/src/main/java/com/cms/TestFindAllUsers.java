package com.cms;

import java.util.List;

import com.cms.model.User;
import com.cms.repository.UserRepository;

public class TestFindAllUsers {

    public static void main(String[] args) {

        UserRepository userRepository =
                new UserRepository();

        List<User> users =
                userRepository.findAllUsers();

        System.out.println("=== ALL USERS ===");

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

// This code section is for testing purpose only.fetching the users and data directly from repository.

//=================================================================================================================================