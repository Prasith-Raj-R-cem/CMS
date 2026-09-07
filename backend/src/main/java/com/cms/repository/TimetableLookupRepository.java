package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.TimetableOption;
import com.cms.util.DatabaseConnection;

public class TimetableLookupRepository {

    public List<TimetableOption> getActiveClasses() {

        List<TimetableOption> options = new ArrayList<>();

        String sql = """
                SELECT
                    c.id,
                    CONCAT(
                        c.class_name,
                        CASE
                            WHEN c.section IS NOT NULL
                            THEN CONCAT(' - ', c.section)
                            ELSE ''
                        END
                    ) AS label
                FROM classes c
                WHERE c.status = 'ACTIVE'
                ORDER BY c.class_name, c.section
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                options.add(
                        new TimetableOption(
                                resultSet.getLong("id"),
                                resultSet.getString("label")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return options;
    }

    public List<TimetableOption> getActiveSubjects() {

        List<TimetableOption> options = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    CONCAT(
                        subject_code,
                        ' - ',
                        subject_name
                    ) AS label
                FROM subjects
                WHERE status = 'ACTIVE'
                ORDER BY subject_code
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                options.add(
                        new TimetableOption(
                                resultSet.getLong("id"),
                                resultSet.getString("label")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return options;
    }

    public List<TimetableOption> getActiveFaculties() {

        List<TimetableOption> options = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    employee_id AS label
                FROM faculties
                WHERE status = 'ACTIVE'
                ORDER BY employee_id
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                options.add(
                        new TimetableOption(
                                resultSet.getLong("id"),
                                resultSet.getString("label")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return options;
    }

    public List<TimetableOption> getActivePeriods() {

        List<TimetableOption> options = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    CONCAT(
                        'P',
                        period_number,
                        ' - ',
                        TIME_FORMAT(start_time, '%H:%i'),
                        ' to ',
                        TIME_FORMAT(end_time, '%H:%i')
                    ) AS label
                FROM periods
                WHERE status = 'ACTIVE'
                ORDER BY period_number
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                options.add(
                        new TimetableOption(
                                resultSet.getLong("id"),
                                resultSet.getString("label")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return options;
    }

    public List<TimetableOption> getActiveRooms() {

        List<TimetableOption> options = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    CONCAT(
                        room_number,
                        CASE
                            WHEN building IS NOT NULL
                            THEN CONCAT(' - ', building)
                            ELSE ''
                        END
                    ) AS label
                FROM rooms
                WHERE status = 'ACTIVE'
                ORDER BY room_number
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                options.add(
                        new TimetableOption(
                                resultSet.getLong("id"),
                                resultSet.getString("label")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return options;
    }

    public List<TimetableOption> getActiveAcademicYears() {

        List<TimetableOption> options = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    year_name AS label
                FROM academic_years
                WHERE status = 'ACTIVE'
                ORDER BY start_date DESC
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                options.add(
                        new TimetableOption(
                                resultSet.getLong("id"),
                                resultSet.getString("label")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return options;
    }

    public List<TimetableOption> getActiveSemesters() {

        List<TimetableOption> options = new ArrayList<>();

        String sql = """
                SELECT
                    s.id,
                    CONCAT(
                        s.semester_name,
                        ' - ',
                        ay.year_name
                    ) AS label
                FROM semesters s
                JOIN academic_years ay
                    ON s.academic_year_id = ay.id
                WHERE s.status = 'ACTIVE'
                  AND ay.status = 'ACTIVE'
                ORDER BY
                    ay.start_date DESC,
                    s.semester_number
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                options.add(
                        new TimetableOption(
                                resultSet.getLong("id"),
                                resultSet.getString("label")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return options;
    }
}