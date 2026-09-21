package com.cms.testfiles;

import org.mindrot.jbcrypt.BCrypt;

import com.cms.model.User;
import com.cms.repository.UserRepository;

public class TestUserRepository {

    public static void main(String[] args) {

        UserRepository userRepository =
                new UserRepository();

        User user =
                userRepository.findByEmail(
                        "admin@campus.local"
                );

        if (user == null) {

            System.out.println("User not found.");
            return;
        }

        System.out.println("User found!");
        System.out.println("Email: " + user.getEmail());
        System.out.println("Role: " + user.getRole());
        System.out.println("Status: " + user.getStatus());

        String hash = user.getPasswordHash();

        System.out.println(
                "Hash length: " + hash.length()
        );

        System.out.println(
                "Hash prefix: " + hash.substring(0, 7)
        );

        boolean matches =
                BCrypt.checkpw(
                        "admin123",
                        hash
                );

        System.out.println(
                "BCrypt through UserRepository: "
                + matches
        );
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.

//=================================================================================================================================