package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Semester;
import com.cms.util.DatabaseConnection;

public class SemesterRepository {

    public long createSemester(Semester semester) {

        String sql = """
                INSERT INTO semesters
                (academic_year_id, semester_number, semester_name, status)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setLong(1, semester.getAcademicYearId());
            statement.setInt(2, semester.getSemesterNumber());
            statement.setString(3, semester.getSemesterName());
            statement.setString(4, semester.getStatus());

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


    public List<Semester> findAllActiveSemesters() {

        List<Semester> semesters = new ArrayList<>();

        String sql = """
                SELECT id,
                       academic_year_id,
                       semester_number,
                       semester_name,
                       status
                FROM semesters
                WHERE status = 'ACTIVE'
                ORDER BY academic_year_id DESC, semester_number
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Semester semester = new Semester();

                semester.setId(resultSet.getLong("id"));
                semester.setAcademicYearId(
                        resultSet.getLong("academic_year_id")
                );
                semester.setSemesterNumber(
                        resultSet.getInt("semester_number")
                );
                semester.setSemesterName(
                        resultSet.getString("semester_name")
                );
                semester.setStatus(
                        resultSet.getString("status")
                );

                semesters.add(semester);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return semesters;
    }
}