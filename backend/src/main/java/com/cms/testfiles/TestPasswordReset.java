package com.cms.testfiles;

import com.cms.service.UserService;

public class TestPasswordReset {

    public static void main(String[] args) {

        UserService userService = new UserService();

        int userId = 2;

        boolean result =
                userService.resetPassword(
                        userId,
                        "NewPassword123"
                );

        System.out.println(
                "Password reset result: " + result
        );
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================