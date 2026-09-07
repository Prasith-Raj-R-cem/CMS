package com.cms.service;

import java.sql.Connection;
import java.util.List;  // jbcrypt lib for hashing password -> 60 char

import org.mindrot.jbcrypt.BCrypt;

import com.cms.model.LoginResult;
import com.cms.model.Role;
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

    public List<User> findAllUsers() {

        return userRepository.findAllUsers();
    }

    public User findUserById(int id) {

        return userRepository.findById(id);
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

    public boolean createUser(
        String email,
        String password,
        Role role
    ) {

        if (email == null || email.isBlank()) {
            return false;
        }

        if (password == null || password.isBlank()) {
            return false;
        }

        if (role == null) {
            return false;
        }

        if (userRepository.findByEmail(email) != null) {
            return false;
        }

        String passwordHash =
                BCrypt.hashpw(
                        password,
                        BCrypt.gensalt()
                );

        User user = new User();

        user.setEmail(email);
        user.setPasswordHash(passwordHash);
        user.setRole(role);
        user.setStatus("ACTIVE");

        long userId = userRepository.createUser(user);

        return userId != -1;
    }

    public long createUserAndGetId(
            String email,
            String password,
            Role role
    ) {

        if (email == null || email.isBlank()) {
            return -1;
        }

        if (password == null || password.isBlank()) {
            return -1;
        }

        if (role == null) {
            return -1;
        }

        if (userRepository.findByEmail(email) != null) {
            return -1;
        }

        String passwordHash =
                BCrypt.hashpw(
                        password,
                        BCrypt.gensalt()
                );

        User user = new User();

        user.setEmail(email);
        user.setPasswordHash(passwordHash);
        user.setRole(role);
        user.setStatus("ACTIVE");

        return userRepository.createUser(user);
    }

    public long createUserAndGetId(
            Connection connection,
            String email,
            String password,
            Role role
    ) {

        if (email == null || email.isBlank()) {
            return -1;
        }

        if (password == null || password.isBlank()) {
            return -1;
        }

        if (role == null) {
            return -1;
        }

        if (userRepository.findByEmail(email) != null) {
            return -1;
        }

        String passwordHash =
                BCrypt.hashpw(
                        password,
                        BCrypt.gensalt()
                );

        User user = new User();

        user.setEmail(email);
        user.setPasswordHash(passwordHash);
        user.setRole(role);
        user.setStatus("ACTIVE");

        return userRepository.createUser(
                connection,
                user
        );
    }

    public boolean updateUser(User user) {

        if (user == null) {
            return false;
        }
    
        if (user.getEmail() == null ||
            user.getEmail().isBlank()) {
            
            return false;
        }
    
        if (user.getRole() == null) {
            return false;
        }
    
        if (user.getStatus() == null ||
            user.getStatus().isBlank()) {
            
            return false;
        }
    
        User existingUser =
                userRepository.findById(user.getId());
    
        if (existingUser == null) {
            return false;
        }
    
        return userRepository.updateUser(user);
    }

    public boolean updateUserStatus(int id, String status) {

        if (status == null || status.isBlank()) {
            return false;
        }

        if (!"ACTIVE".equals(status) &&
            !"INACTIVE".equals(status)) {

            return false;
        }

        User user =
                userRepository.findById(id);

        if (user == null) {
            return false;
        }

        return userRepository.updateStatus(id, status);
    }

    public boolean updateUserStatus(
            Connection connection,
            long id,
            String status
    ) {
    
        if (status == null || status.isBlank()) {
            return false;
        }
    
        if (!"ACTIVE".equals(status)
                && !"INACTIVE".equals(status)) {
            return false;
        }
    
        if (id <= 0) {
            return false;
        }
    
        return userRepository.updateStatus(
                connection,
                id,
                status
        );
    }

    public boolean resetPassword(int id, String newPassword) {

        if (newPassword == null || newPassword.isBlank()) {
            return false;
        }

        User user = userRepository.findById(id);

        if (user == null) {
            return false;
        }

        String passwordHash =
                BCrypt.hashpw(
                        newPassword,
                        BCrypt.gensalt()
                );

        return userRepository.updatePassword(
                id,
                passwordHash
        );
    }
}