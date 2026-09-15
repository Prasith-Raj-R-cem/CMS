package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Assignment;
import com.cms.util.DatabaseConnection;
import com.cms.model.AssignmentSummary;


public class AssignmentRepository {


    // =====================================================
    // CREATE ASSIGNMENT
    // =====================================================

    public long createAssignment(Assignment assignment) {

        String sql = """
                INSERT INTO assignments
                (title, description, class_id, subject_id, faculty_id, deadline, status)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection connection = DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            statement.setString(1, assignment.getTitle());
            statement.setString(2, assignment.getDescription());
            statement.setLong(3, assignment.getClassId());
            statement.setLong(4, assignment.getSubjectId());
            statement.setLong(5, assignment.getFacultyId());

            statement.setTimestamp(
                    6,
                    Timestamp.valueOf(
                            java.time.LocalDateTime.parse(
                                    assignment.getDeadline()
                            )
                    )
            );

            statement.setString(7, assignment.getStatus());


            int rowsAffected = statement.executeUpdate();

            if (rowsAffected != 1) {
                return -1;
            }


            // Get generated assignment ID

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


    // =====================================================
    // FIND ASSIGNMENT BY ID
    // =====================================================

    public Assignment findById(long id) {

        String sql = """
                SELECT
                    id,
                    title,
                    description,
                    class_id,
                    subject_id,
                    faculty_id,
                    deadline,
                    status,
                    created_at,
                    updated_at
                FROM assignments
                WHERE id = ?
                """;


        try (
                Connection connection = DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, id);


            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    return mapAssignment(resultSet);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =====================================================
    // FIND ASSIGNMENTS BY CLASS
    // =====================================================

    public List<Assignment> findAssignmentsByClass(long classId) {

        List<Assignment> assignments = new ArrayList<>();


        String sql = """
                SELECT
                    id,
                    title,
                    description,
                    class_id,
                    subject_id,
                    faculty_id,
                    deadline,
                    status,
                    created_at,
                    updated_at
                FROM assignments
                WHERE class_id = ?
                  AND status = 'ACTIVE'
                ORDER BY deadline ASC
                """;


        try (
                Connection connection = DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, classId);


            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    assignments.add(
                            mapAssignment(resultSet)
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }


        return assignments;
    }

        // =====================================================
        // FIND UPCOMING ASSIGNMENT SUMMARIES BY CLASS
        // =====================================================

        public List<AssignmentSummary> findUpcomingAssignmentSummariesByClass(
                long classId) {

            List<AssignmentSummary> assignments =
                    new ArrayList<>();


            String sql = """
                    SELECT
                        a.id,
                        a.title,

                        s.subject_code,
                        s.subject_name,

                        c.class_name,
                        c.section,

                        a.deadline

                    FROM assignments a

                    INNER JOIN subjects s
                        ON a.subject_id = s.id

                    INNER JOIN classes c
                        ON a.class_id = c.id

                    WHERE a.class_id = ?
                      AND a.status = 'ACTIVE'
                      AND a.deadline >= NOW()

                    ORDER BY a.deadline ASC

                    LIMIT 5
                    """;


            try (
                    Connection connection =
                            DatabaseConnection.getConnection();

                    PreparedStatement statement =
                            connection.prepareStatement(sql)
            ) {

                statement.setLong(1, classId);


                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    while (resultSet.next()) {

                        AssignmentSummary summary =
                                new AssignmentSummary();


                        summary.setId(
                                resultSet.getLong("id")
                        );


                        summary.setTitle(
                                resultSet.getString("title")
                        );


                        summary.setSubjectCode(
                                resultSet.getString("subject_code")
                        );


                        summary.setSubjectName(
                                resultSet.getString("subject_name")
                        );


                        summary.setClassName(
                                resultSet.getString("class_name")
                        );


                        summary.setSection(
                                resultSet.getString("section")
                        );


                        Timestamp deadline =
                                resultSet.getTimestamp("deadline");


                        if (deadline != null) {

                            summary.setDeadline(
                                    deadline
                                            .toLocalDateTime()
                                            .toString()
                            );
                        }


                        assignments.add(summary);
                    }
                }

            } catch (Exception e) {

                e.printStackTrace();
            }


            return assignments;
        }

    // =====================================================
    // MAP RESULT SET → ASSIGNMENT
    // =====================================================

    private Assignment mapAssignment(ResultSet resultSet)
            throws Exception {

        Assignment assignment = new Assignment();


        assignment.setId(
                resultSet.getLong("id")
        );


        assignment.setTitle(
                resultSet.getString("title")
        );


        assignment.setDescription(
                resultSet.getString("description")
        );


        assignment.setClassId(
                resultSet.getLong("class_id")
        );


        assignment.setSubjectId(
                resultSet.getLong("subject_id")
        );


        assignment.setFacultyId(
                resultSet.getLong("faculty_id")
        );


        java.sql.Timestamp deadline =
                resultSet.getTimestamp("deadline");

        if (deadline != null) {

            assignment.setDeadline(
                    deadline.toLocalDateTime().toString()
            );
        }


        assignment.setStatus(
                resultSet.getString("status")
        );


        java.sql.Timestamp createdAt =
                resultSet.getTimestamp("created_at");

        if (createdAt != null) {

            assignment.setCreatedAt(
                    createdAt.toLocalDateTime().toString()
            );
        }


        java.sql.Timestamp updatedAt =
                resultSet.getTimestamp("updated_at");

        if (updatedAt != null) {

            assignment.setUpdatedAt(
                    updatedAt.toLocalDateTime().toString()
            );
        }


        return assignment;
    }
}