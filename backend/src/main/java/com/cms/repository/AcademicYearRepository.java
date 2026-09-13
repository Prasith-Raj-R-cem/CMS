package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.AcademicYear;
import com.cms.util.DatabaseConnection;

public class AcademicYearRepository {


    // Create Academic Year
    public long createAcademicYear(AcademicYear academicYear) {

        String sql = """
                INSERT INTO academic_years
                (year_name, start_date, end_date, status)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(
                    1,
                    academicYear.getYearName());

            statement.setDate(
                    2,
                    java.sql.Date.valueOf(
                            academicYear.getStartDate()));

            statement.setDate(
                    3,
                    java.sql.Date.valueOf(
                            academicYear.getEndDate()));

            statement.setString(
                    4,
                    academicYear.getStatus());

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


    // Get all active Academic Years
    public List<AcademicYear> findAllActiveAcademicYears() {

        List<AcademicYear> academicYears =
                new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    year_name,
                    start_date,
                    end_date,
                    status
                FROM academic_years
                WHERE status = 'ACTIVE'
                ORDER BY start_date DESC
                """;

        try (Connection connection =
                     DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                AcademicYear academicYear =
                        new AcademicYear();

                academicYear.setId(
                        resultSet.getLong("id"));

                academicYear.setYearName(
                        resultSet.getString("year_name"));

                academicYear.setStartDate(
                        resultSet.getDate("start_date")
                                .toString());

                academicYear.setEndDate(
                        resultSet.getDate("end_date")
                                .toString());

                academicYear.setStatus(
                        resultSet.getString("status"));

                academicYears.add(academicYear);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return academicYears;
    }
}