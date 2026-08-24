package com.cms;

import com.cms.model.User;
import com.cms.service.UserService;

public class TestUserService {

    public static void main(String[] args) {

        UserService userService =
                new UserService();

        User user =
                userService.findUserByEmail(
                        "admin@campus.local"
                );

        if (user != null) {

            System.out.println(
                    "User retrieved through Service Layer!"
            );

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

        } else {

            System.out.println(
                    "User not found."
            );
        }
    }
}