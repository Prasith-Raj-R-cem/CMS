package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Department;
import com.cms.util.DatabaseConnection;

public class DepartmentRepository {

    public List<Department> findAllActiveDepartments() {

        List<Department> departments = new ArrayList<>();

        String sql = """
                SELECT id,
                       department_code,
                       department_name,
                       status
                FROM departments
                WHERE status = 'ACTIVE'
                ORDER BY department_name
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Department department = new Department();

                department.setId(
                        resultSet.getLong("id"));

                department.setDepartmentCode(
                        resultSet.getString("department_code"));

                department.setDepartmentName(
                        resultSet.getString("department_name"));

                department.setStatus(
                        resultSet.getString("status"));

                departments.add(department);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return departments;
    }

    public long createDepartment(Department department) {
        
            String sql = """
                    INSERT INTO departments
                    (department_code, department_name, status)
                    VALUES (?, ?, ?)
                    """;
        
            try (Connection connection =
                         DatabaseConnection.getConnection();
                 PreparedStatement statement =
                         connection.prepareStatement(
                                 sql,
                                 java.sql.Statement.RETURN_GENERATED_KEYS)) {
                                
                statement.setString(
                        1,
                        department.getDepartmentCode());
        
                statement.setString(
                        2,
                        department.getDepartmentName());
        
                statement.setString(
                        3,
                        department.getStatus());
        
                int rowsAffected =
                        statement.executeUpdate();
        
                if (rowsAffected != 1) {
                    return -1;
                }
        
                try (ResultSet resultSet =
                             statement.getGeneratedKeys()) {
                        
                    if (resultSet.next()) {
                        return resultSet.getLong(1);
                    }
                }
        
            } catch (Exception e) {
        
                e.printStackTrace();
            }
        
            return -1;
        }
}