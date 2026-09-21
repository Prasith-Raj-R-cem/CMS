package com.cms.testfiles;

import com.cms.model.LoginResult;
import com.cms.service.UserService;

public class TestLogin {

    public static void main(String[] args) {

        UserService userService =
                new UserService();

        LoginResult result =
                userService.login(
                        "admin@campus.local",
                        "admin123"
                );

        System.out.println(
                "Success: " + result.isSuccess()
        );

        System.out.println(
                "Message: " + result.getMessage()
        );

        if (result.isSuccess()) {

            System.out.println(
                    "Logged in user: "
                    + result.getUser().getEmail()
            );

            System.out.println(
                    "Role: "
                    + result.getUser().getRole()
            );
        }
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================