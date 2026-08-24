package com.cms.service;

import org.mindrot.jbcrypt.BCrypt;

import com.cms.model.LoginResult;
import com.cms.model.User;
import com.cms.repository.UserRepository;

public class UserService{
    private final UserRepository userRepository;

    public UserService(){
        this.userRepository = new UserRepository();
    }

    public User findUserByEmail(String email){
        return userRepository.findByEmail(email);
    }

    public LoginResult login(
            String email,
            String password
    ) {

        User user = userRepository.findByEmail(email);

        if (user == null) {

            return new LoginResult(
                    false,
                    "Invalid email or password",
                    null
            );
        }

        if (!"ACTIVE".equals(user.getStatus())) {

            return new LoginResult(
                    false,
                    "Account is not active",
                    null
            );
        }

        boolean passwordMatches =
                BCrypt.checkpw(
                        password,
                        user.getPasswordHash()
                );

        if (!passwordMatches) {

            return new LoginResult(
                    false,
                    "Invalid email or password",
                    null
            );
        }

        return new LoginResult(
                true,
                "Login successful",
                user
        );
    }
}