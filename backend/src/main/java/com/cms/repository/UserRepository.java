package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Role;
import com.cms.model.User;
import com.cms.util.DatabaseConnection;

public class UserRepository{
    // find the user through email
    public User findByEmail(String email){
        String sql = """
                SELECT id, email, password_hash, role, status
                FROM users
                WHERE email = ?
                """;

        try (Connection connection =
                        DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)){

                            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    User user = new User();

                    user.setId(resultSet.getInt("id"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPasswordHash(
                            resultSet.getString("password_hash")
                    );
                    user.setRole(
                        Role.valueOf(
                            resultSet.getString("role")
                        )
                    );
                    user.setStatus(resultSet.getString("status"));

                    return user;
                }
            }
            
        } catch (Exception e) {
              e.printStackTrace();
        }
        return null;
    }

    public boolean createUser(User user) {

        String sql = """
                INSERT INTO users
                (email, password_hash, role, status)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection =
                        DatabaseConnection.getConnection();

             PreparedStatement statement =
                        connection.prepareStatement(sql)) {

            statement.setString(1, user.getEmail());

            statement.setString(
                    2,
                    user.getPasswordHash()
            );

            statement.setString(
                    3,
                    user.getRole().name()
            );

            statement.setString(
                    4,
                    user.getStatus()
            );

            int rowsAffected =
                    statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    public List<User> findAllUsers() {

        List<User> users = new ArrayList<>();

        String sql = """
                SELECT id, email, password_hash, role, status
                FROM users
                ORDER BY id
                """;

        try (Connection connection =
                        DatabaseConnection.getConnection();

             PreparedStatement statement =
                        connection.prepareStatement(sql);

             ResultSet resultSet =
                        statement.executeQuery()) {

            while (resultSet.next()) {

                User user = new User();

                user.setId(resultSet.getInt("id"));

                user.setEmail(
                        resultSet.getString("email")
                );

                user.setPasswordHash(
                        resultSet.getString("password_hash")
                );

                user.setRole(
                        Role.valueOf(
                                resultSet.getString("role")
                        )
                );

                user.setStatus(
                        resultSet.getString("status")
                );

                users.add(user);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return users;
    }
}