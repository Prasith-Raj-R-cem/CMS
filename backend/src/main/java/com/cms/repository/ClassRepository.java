package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Class;
import com.cms.util.DatabaseConnection;

public class ClassRepository {

    // Create class
    public long createClass(Class classData) {

        String sql = """
                INSERT INTO classes
                (class_name, department_id, semester_id, academic_year_id, section, status)
                VALUES (?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, classData.getClassName());
            statement.setLong(2, classData.getDepartmentId());
            statement.setLong(3, classData.getSemesterId());
            statement.setLong(4, classData.getAcademicYearId());
            statement.setString(5, classData.getSection());
            statement.setString(6, classData.getStatus());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected != 1) {
                return -1;
            }

            try (ResultSet resultSet = statement.getGeneratedKeys()) {

                if (resultSet.next()) {
                    return resultSet.getLong(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    // Find class by ID
    public Class findById(long id) {

        String sql = """
                SELECT
                    id,
                    class_name,
                    department_id,
                    semester_id,
                    academic_year_id,
                    section,
                    status
                FROM classes
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapClass(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // Find all classes
    public List<Class> findAllClasses() {

        List<Class> classes = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    class_name,
                    department_id,
                    semester_id,
                    academic_year_id,
                    section,
                    status
                FROM classes
                ORDER BY class_name, section
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                classes.add(mapClass(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return classes;
    }

    // Find all active classes for dropdown
    public List<Class> findAllActiveClasses() {
    
        List<Class> classes = new ArrayList<>();
    
        String sql = """
                SELECT
                    id,
                    class_name,
                    department_id,
                    semester_id,
                    academic_year_id,
                    section,
                    status
                FROM classes
                WHERE status = 'ACTIVE'
                ORDER BY class_name, section
                """;
    
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                classes.add(mapClass(resultSet));
            }
    
        } catch (Exception e) {
            e.printStackTrace();
        }
    
        return classes;
    }


    // Update class
    public boolean updateClass(Class classData) {

        String sql = """
                UPDATE classes
                SET class_name = ?,
                    department_id = ?,
                    semester_id = ?,
                    academic_year_id = ?,
                    section = ?,
                    status = ?
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, classData.getClassName());
            statement.setLong(2, classData.getDepartmentId());
            statement.setLong(3, classData.getSemesterId());
            statement.setLong(4, classData.getAcademicYearId());
            statement.setString(5, classData.getSection());
            statement.setString(6, classData.getStatus());
            statement.setLong(7, classData.getId());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // Delete class
    public boolean deleteClass(long id) {

        String sql = """
                DELETE FROM classes
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // Convert ResultSet → Class object
    private Class mapClass(ResultSet resultSet) throws Exception {

        Class classData = new Class();

        classData.setId(resultSet.getLong("id"));
        classData.setClassName(resultSet.getString("class_name"));
        classData.setDepartmentId(resultSet.getLong("department_id"));
        classData.setSemesterId(resultSet.getLong("semester_id"));
        classData.setAcademicYearId(resultSet.getLong("academic_year_id"));
        classData.setSection(resultSet.getString("section"));
        classData.setStatus(resultSet.getString("status"));

        return classData;
    }
}