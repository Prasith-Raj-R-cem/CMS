package com.cms;

import com.cms.model.Role;
import com.cms.model.User;
import com.cms.repository.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

public class TestCreateAdmin {

    public static void main(String[] args) {

        String email = "admin@campus.local";
        String password = "admin123";

        // Generate BCrypt hash
        String passwordHash = BCrypt.hashpw(
                password,
                BCrypt.gensalt(10)
        );

        // Create User object
        User admin = new User();

        admin.setEmail(email);
        admin.setPasswordHash(passwordHash);
        admin.setRole(Role.ADMIN);
        admin.setStatus("ACTIVE");

        // Save admin to database
        UserRepository userRepository = new UserRepository();

        try {

            userRepository.saveUser(admin);

            System.out.println("=================================");
            System.out.println("ADMIN CREATED SUCCESSFULLY");
            System.out.println("=================================");
            System.out.println("Email    : " + email);
            System.out.println("Password : " + password);
            System.out.println("Role     : ADMIN");
            System.out.println("Status   : ACTIVE");
            System.out.println();
            System.out.println("BCrypt Hash:");
            System.out.println(passwordHash);
            System.out.println("=================================");

        } catch (Exception e) {

            System.out.println("=================================");
            System.out.println("FAILED TO CREATE ADMIN");
            System.out.println("=================================");

            e.printStackTrace();
        }
    }
}
