package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Timetable;
import com.cms.util.DatabaseConnection;

public class TimetableRepository {

    public long createTimetable(Timetable timetable) {

        String sql = """
                INSERT INTO timetables
                (
                    class_id,
                    subject_id,
                    faculty_id,
                    period_id,
                    room_id,
                    academic_year_id,
                    semester_id,
                    day_of_week,
                    status
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             java.sql.Statement.RETURN_GENERATED_KEYS)) {

            statement.setLong(1, timetable.getClassId());
            statement.setLong(2, timetable.getSubjectId());
            statement.setLong(3, timetable.getFacultyId());
            statement.setLong(4, timetable.getPeriodId());

            if (timetable.getRoomId() == null) {
                statement.setNull(
                        5,
                        java.sql.Types.BIGINT
                );
            } else {
                statement.setLong(
                        5,
                        timetable.getRoomId()
                );
            }

            statement.setLong(6, timetable.getAcademicYearId());
            statement.setLong(7, timetable.getSemesterId());
            statement.setString(8, timetable.getDayOfWeek());
            statement.setString(9, timetable.getStatus());

            int rowsAffected = statement.executeUpdate();

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

    public Timetable findById(long id) {

        String sql = """
                SELECT
                    id,
                    class_id,
                    subject_id,
                    faculty_id,
                    period_id,
                    room_id,
                    academic_year_id,
                    semester_id,
                    day_of_week,
                    status,
                    created_at,
                    updated_at
                FROM timetables
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapTimetable(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Timetable> findAllTimetables() {

        List<Timetable> timetables = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    class_id,
                    subject_id,
                    faculty_id,
                    period_id,
                    room_id,
                    academic_year_id,
                    semester_id,
                    day_of_week,
                    status,
                    created_at,
                    updated_at
                FROM timetables
                ORDER BY
                    day_of_week,
                    period_id
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {
                timetables.add(
                        mapTimetable(resultSet)
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return timetables;
    }

    public boolean updateTimetable(Timetable timetable) {

        String sql = """
                UPDATE timetables
                SET class_id = ?,
                    subject_id = ?,
                    faculty_id = ?,
                    period_id = ?,
                    room_id = ?,
                    academic_year_id = ?,
                    semester_id = ?,
                    day_of_week = ?
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, timetable.getClassId());
            statement.setLong(2, timetable.getSubjectId());
            statement.setLong(3, timetable.getFacultyId());
            statement.setLong(4, timetable.getPeriodId());

            if (timetable.getRoomId() == null) {
                statement.setNull(
                        5,
                        java.sql.Types.BIGINT
                );
            } else {
                statement.setLong(
                        5,
                        timetable.getRoomId()
                );
            }

            statement.setLong(6, timetable.getAcademicYearId());
            statement.setLong(7, timetable.getSemesterId());
            statement.setString(8, timetable.getDayOfWeek());
            statement.setLong(9, timetable.getId());

            int rowsAffected =
                    statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteTimetable(long id) {

        String sql = """
                DELETE FROM timetables
                WHERE id = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            int rowsAffected =
                    statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Timetable mapTimetable(ResultSet resultSet)
            throws Exception {

        Timetable timetable = new Timetable();

        timetable.setId(
                resultSet.getLong("id")
        );

        timetable.setClassId(
                resultSet.getLong("class_id")
        );

        timetable.setSubjectId(
                resultSet.getLong("subject_id")
        );

        timetable.setFacultyId(
                resultSet.getLong("faculty_id")
        );

        timetable.setPeriodId(
                resultSet.getLong("period_id")
        );

        long roomId =
                resultSet.getLong("room_id");

        if (resultSet.wasNull()) {
            timetable.setRoomId(null);
        } else {
            timetable.setRoomId(roomId);
        }

        timetable.setAcademicYearId(
                resultSet.getLong("academic_year_id")
        );

        timetable.setSemesterId(
                resultSet.getLong("semester_id")
        );

        timetable.setDayOfWeek(
                resultSet.getString("day_of_week")
        );

        timetable.setStatus(
                resultSet.getString("status")
        );

        timetable.setCreatedAt(
                resultSet.getString("created_at")
        );

        timetable.setUpdatedAt(
                resultSet.getString("updated_at")
        );

        return timetable;
    }
}