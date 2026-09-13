package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Subject;
import com.cms.util.DatabaseConnection;

public class SubjectRepository {

    public long createSubject(Subject subject) {

        String sql = """
                INSERT INTO subjects
                (subject_code, subject_name, department_id, semester_id,
                 credits, subject_type, status)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, subject.getSubjectCode());
            statement.setString(2, subject.getSubjectName());
            statement.setLong(3, subject.getDepartmentId());
            statement.setLong(4, subject.getSemesterId());
            statement.setBigDecimal(5, subject.getCredits());
            statement.setString(6, subject.getSubjectType());
            statement.setString(7, subject.getStatus());

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


    public List<Subject> findAllActiveSubjects() {

        List<Subject> subjects = new ArrayList<>();

        String sql = """
                SELECT id,
                       subject_code,
                       subject_name,
                       department_id,
                       semester_id,
                       credits,
                       subject_type,
                       status
                FROM subjects
                WHERE status = 'ACTIVE'
                ORDER BY subject_code
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Subject subject = new Subject();

                subject.setId(
                        resultSet.getLong("id")
                );

                subject.setSubjectCode(
                        resultSet.getString("subject_code")
                );

                subject.setSubjectName(
                        resultSet.getString("subject_name")
                );

                subject.setDepartmentId(
                        resultSet.getLong("department_id")
                );

                subject.setSemesterId(
                        resultSet.getLong("semester_id")
                );

                subject.setCredits(
                        resultSet.getBigDecimal("credits")
                );

                subject.setSubjectType(
                        resultSet.getString("subject_type")
                );

                subject.setStatus(
                        resultSet.getString("status")
                );

                subjects.add(subject);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return subjects;
    }
}