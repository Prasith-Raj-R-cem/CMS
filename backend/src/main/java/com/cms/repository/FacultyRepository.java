package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Faculty;
import com.cms.model.FacultyDetails;
import com.cms.util.DatabaseConnection;

public class FacultyRepository {

    public boolean createFaculty(Faculty faculty) {

        String sql = """
                INSERT INTO faculties
                (user_id, employee_id, department_id, status)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, faculty.getUserId());
            statement.setString(2, faculty.getEmployeeId());
            statement.setLong(3, faculty.getDepartmentId());
            statement.setString(4, faculty.getStatus());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean createFaculty(
            Connection connection,
            Faculty faculty
    ) {
    
        String sql = """
                INSERT INTO faculties
                (user_id, employee_id, department_id, status)
                VALUES (?, ?, ?, ?)
                """;
    
        try (PreparedStatement statement =
                        connection.prepareStatement(sql)) {
                    
            statement.setLong(1, faculty.getUserId());
            statement.setString(2, faculty.getEmployeeId());
            statement.setLong(3, faculty.getDepartmentId());
            statement.setString(4, faculty.getStatus());
    
            int rowsAffected = statement.executeUpdate();
    
            return rowsAffected == 1;
    
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Faculty findById(long id) {

        String sql = """
                SELECT id,
                       user_id,
                       employee_id,
                       department_id,
                       status,
                       created_at,
                       updated_at
                FROM faculties
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    Faculty faculty = new Faculty();

                    faculty.setId(resultSet.getLong("id"));
                    faculty.setUserId(resultSet.getLong("user_id"));
                    faculty.setEmployeeId(
                            resultSet.getString("employee_id"));
                    faculty.setDepartmentId(
                            resultSet.getLong("department_id"));
                    faculty.setStatus(
                            resultSet.getString("status"));
                    faculty.setCreatedAt(
                            resultSet.getString("created_at"));
                    faculty.setUpdatedAt(
                            resultSet.getString("updated_at"));

                    return faculty;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Faculty> findAllFaculties() {

        List<Faculty> faculties = new ArrayList<>();

        String sql = """
                SELECT id,
                       user_id,
                       employee_id,
                       department_id,
                       status,
                       created_at,
                       updated_at
                FROM faculties
                ORDER BY id
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Faculty faculty = new Faculty();

                faculty.setId(resultSet.getLong("id"));
                faculty.setUserId(resultSet.getLong("user_id"));
                faculty.setEmployeeId(
                        resultSet.getString("employee_id"));
                faculty.setDepartmentId(
                        resultSet.getLong("department_id"));
                faculty.setStatus(
                        resultSet.getString("status"));
                faculty.setCreatedAt(
                        resultSet.getString("created_at"));
                faculty.setUpdatedAt(
                        resultSet.getString("updated_at"));

                faculties.add(faculty);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return faculties;
    }

    // Find all active faculties for dropdown
        public List<Faculty> findAllActiveFaculties() {
        
            List<Faculty> faculties = new ArrayList<>();
        
            String sql = """
                    SELECT id,
                           user_id,
                           employee_id,
                           department_id,
                           status,
                           created_at,
                           updated_at
                    FROM faculties
                    WHERE status = 'ACTIVE'
                    ORDER BY employee_id
                    """;
        
            try (Connection connection = DatabaseConnection.getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {
                
                while (resultSet.next()) {
                
                    Faculty faculty = new Faculty();
        
                    faculty.setId(resultSet.getLong("id"));
                    faculty.setUserId(resultSet.getLong("user_id"));
                    faculty.setEmployeeId(
                            resultSet.getString("employee_id"));
                    faculty.setDepartmentId(
                            resultSet.getLong("department_id"));
                    faculty.setStatus(
                            resultSet.getString("status"));
                    faculty.setCreatedAt(
                            resultSet.getString("created_at"));
                    faculty.setUpdatedAt(
                            resultSet.getString("updated_at"));
        
                    faculties.add(faculty);
                }
        
            } catch (Exception e) {
                e.printStackTrace();
            }
        
            return faculties;
        }

    public FacultyDetails findDetailsById(long id) {

        String sql = """
                SELECT
                    f.id,
                    f.user_id,
                    u.email,
                    f.employee_id,
                    f.department_id,
                    d.department_code,
                    d.department_name,
                    f.status,
                    f.created_at,
                    f.updated_at
                FROM faculties f
                JOIN users u
                    ON f.user_id = u.id
                JOIN departments d
                    ON f.department_id = d.id
                WHERE f.id = ?
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    FacultyDetails details =
                            new FacultyDetails();

                    details.setId(
                            resultSet.getLong("id"));

                    details.setUserId(
                            resultSet.getLong("user_id"));

                    details.setEmail(
                            resultSet.getString("email"));

                    details.setEmployeeId(
                            resultSet.getString("employee_id"));

                    details.setDepartmentId(
                            resultSet.getLong("department_id"));

                    details.setDepartmentCode(
                            resultSet.getString("department_code"));

                    details.setDepartmentName(
                            resultSet.getString("department_name"));

                    details.setStatus(
                            resultSet.getString("status"));

                    details.setCreatedAt(
                            resultSet.getString("created_at"));

                    details.setUpdatedAt(
                            resultSet.getString("updated_at"));

                    return details;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    public boolean updateFaculty(Faculty faculty) {

        String sql = """
                UPDATE faculties
                SET employee_id = ?,
                    department_id = ?,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, faculty.getEmployeeId());
            statement.setLong(2, faculty.getDepartmentId());
            statement.setLong(3, faculty.getId());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean updateStatus(Connection connection,
                            long facultyId,
                            String status) {

        String sql = """
                UPDATE faculties
                SET status = ?,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = ?
                """;

        try (PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setLong(2, facultyId);

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteFaculty(Connection connection, long facultyId) {

        String sql = """
                DELETE FROM faculties
                WHERE id = ?
                """;
    
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
        
            statement.setLong(1, facultyId);
    
            int rowsAffected = statement.executeUpdate();
    
            return rowsAffected == 1;
    
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}