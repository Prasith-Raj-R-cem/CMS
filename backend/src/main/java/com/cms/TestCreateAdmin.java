package com.cms;

import com.cms.model.Role;
import com.cms.model.User;
import com.cms.repository.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

public class TestCreateAdmin {

    public static void main(String[] args) {

        String email = "admin@campus.local";
        String password = "admin123";

        // Generate BCrypt password hash
        String passwordHash = BCrypt.hashpw(
                password,
                BCrypt.gensalt(10)
        );

        // Create admin user
        User admin = new User();

        admin.setEmail(email);
        admin.setPasswordHash(passwordHash);
        admin.setRole(Role.ADMIN);
        admin.setStatus("ACTIVE");

        // Save user
        UserRepository userRepository = new UserRepository();

        long userId = userRepository.createUser(admin);

        if (userId > 0) {

            System.out.println("=================================");
            System.out.println("ADMIN CREATED SUCCESSFULLY");
            System.out.println("=================================");
            System.out.println("ID       : " + userId);
            System.out.println("Email    : " + email);
            System.out.println("Password : " + password);
            System.out.println("Role     : ADMIN");
            System.out.println("Status   : ACTIVE");
            System.out.println();
            System.out.println("BCrypt Hash:");
            System.out.println(passwordHash);
            System.out.println("=================================");

        } else {

            System.out.println("=================================");
            System.out.println("FAILED TO CREATE ADMIN");
            System.out.println("=================================");
        }
    }
}
