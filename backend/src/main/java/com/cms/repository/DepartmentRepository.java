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
}