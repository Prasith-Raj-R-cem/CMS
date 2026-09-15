package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Student;
import com.cms.util.DatabaseConnection;

public class StudentRepository {

    // =========================================================
    // CREATE STUDENT
    // =========================================================
    public boolean createStudent(Student student) {

        String sql = """
                INSERT INTO students
                (
                    user_id,
                    register_no,
                    class_id,
                    first_name,
                    last_name,
                    date_of_birth,
                    gender,
                    phone,
                    department,
                    semester,
                    admission_year
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setLong(1, student.getUserId());
            statement.setString(2, student.getRegisterNo());
            statement.setLong(3, student.getClassId());
            statement.setString(4, student.getFirstName());
            statement.setString(5, student.getLastName());
            statement.setString(6, student.getDateOfBirth());
            statement.setString(7, student.getGender());
            statement.setString(8, student.getPhone());
            statement.setString(9, student.getDepartment());
            statement.setInt(10, student.getSemester());
            statement.setInt(11, student.getAdmissionYear());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // CREATE STUDENT USING EXISTING CONNECTION
    // Used when part of a transaction
    // =========================================================
    public boolean createStudent(Connection connection, Student student) {

        String sql = """
                INSERT INTO students
                (
                    user_id,
                    register_no,
                    class_id,
                    first_name,
                    last_name,
                    date_of_birth,
                    gender,
                    phone,
                    department,
                    semester,
                    admission_year
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setLong(1, student.getUserId());
            statement.setString(2, student.getRegisterNo());
            statement.setLong(3, student.getClassId());
            statement.setString(4, student.getFirstName());
            statement.setString(5, student.getLastName());
            statement.setString(6, student.getDateOfBirth());
            statement.setString(7, student.getGender());
            statement.setString(8, student.getPhone());
            statement.setString(9, student.getDepartment());
            statement.setInt(10, student.getSemester());
            statement.setInt(11, student.getAdmissionYear());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // FIND STUDENT BY ID
    // =========================================================
    public Student findById(long id) {

        String sql = """
                SELECT
                    id,
                    user_id,
                    register_no,
                    class_id,
                    first_name,
                    last_name,
                    date_of_birth,
                    gender,
                    phone,
                    department,
                    semester,
                    admission_year
                FROM students
                WHERE id = ?
                """;

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setLong(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    Student student = new Student();

                    student.setId(
                            resultSet.getLong("id")
                    );

                    student.setUserId(
                            resultSet.getLong("user_id")
                    );

                    student.setRegisterNo(
                            resultSet.getString("register_no")
                    );

                    student.setClassId(
                            resultSet.getLong("class_id")
                    );

                    student.setFirstName(
                            resultSet.getString("first_name")
                    );

                    student.setLastName(
                            resultSet.getString("last_name")
                    );

                    student.setDateOfBirth(
                            resultSet.getString("date_of_birth")
                    );

                    student.setGender(
                            resultSet.getString("gender")
                    );

                    student.setPhone(
                            resultSet.getString("phone")
                    );

                    student.setDepartment(
                            resultSet.getString("department")
                    );

                    student.setSemester(
                            resultSet.getInt("semester")
                    );

                    student.setAdmissionYear(
                            resultSet.getInt("admission_year")
                    );

                    return student;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================================================
    // FIND STUDENT BY USER ID
   // Used to identify the logged-in student's profile
  // =========================================================

        public Student findByUserId(long userId) {

                String sql = """
                        SELECT
                        id,
                        user_id,
                        register_no,
                        class_id,
                        first_name,
                        last_name,
                        date_of_birth,
                        gender,
                        phone,
                        department,
                        semester,
                        admission_year
                        FROM students
                        WHERE user_id = ?
                        """;

                try (
                        Connection connection =
                                DatabaseConnection.getConnection();

                        PreparedStatement statement =
                                connection.prepareStatement(sql)
                ) {

                statement.setLong(1, userId);

                try (ResultSet resultSet = statement.executeQuery()) {
                
                        if (resultSet.next()) {
                        
                        Student student = new Student();

                        student.setId(
                                resultSet.getLong("id")
                        );

                        student.setUserId(
                                resultSet.getLong("user_id")
                        );

                        student.setRegisterNo(
                                resultSet.getString("register_no")
                        );

                        student.setClassId(
                                resultSet.getLong("class_id")
                        );

                        student.setFirstName(
                                resultSet.getString("first_name")
                        );

                        student.setLastName(
                                resultSet.getString("last_name")
                        );

                        student.setDateOfBirth(
                                resultSet.getString("date_of_birth")
                        );

                        student.setGender(
                                resultSet.getString("gender")
                        );

                        student.setPhone(
                                resultSet.getString("phone")
                        );

                        student.setDepartment(
                                resultSet.getString("department")
                        );

                        student.setSemester(
                                resultSet.getInt("semester")
                        );

                        student.setAdmissionYear(
                                resultSet.getInt("admission_year")
                        );

                        return student;
                        }
                }

                } catch (Exception e) {

                e.printStackTrace();
                }

                return null;
        }


    // =========================================================
    // FIND ALL STUDENTS
    // =========================================================
    public List<Student> findAllStudents() {

        List<Student> students = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    user_id,
                    register_no,
                    class_id,
                    first_name,
                    last_name,
                    date_of_birth,
                    gender,
                    phone,
                    department,
                    semester,
                    admission_year
                FROM students
                ORDER BY id
                """;

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Student student = new Student();

                student.setId(
                        resultSet.getLong("id")
                );

                student.setUserId(
                        resultSet.getLong("user_id")
                );

                student.setRegisterNo(
                        resultSet.getString("register_no")
                );

                student.setClassId(
                        resultSet.getLong("class_id")
                );

                student.setFirstName(
                        resultSet.getString("first_name")
                );

                student.setLastName(
                        resultSet.getString("last_name")
                );

                student.setDateOfBirth(
                        resultSet.getString("date_of_birth")
                );

                student.setGender(
                        resultSet.getString("gender")
                );

                student.setPhone(
                        resultSet.getString("phone")
                );

                student.setDepartment(
                        resultSet.getString("department")
                );

                student.setSemester(
                        resultSet.getInt("semester")
                );

                student.setAdmissionYear(
                        resultSet.getInt("admission_year")
                );

                students.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }


    // =========================================================
    // UPDATE STUDENT
    // =========================================================
    public boolean updateStudent(Student student) {

        String sql = """
                UPDATE students
                SET register_no = ?,
                    class_id = ?,
                    first_name = ?,
                    last_name = ?,
                    date_of_birth = ?,
                    gender = ?,
                    phone = ?,
                    department = ?,
                    semester = ?,
                    admission_year = ?
                WHERE id = ?
                """;

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {

            statement.setString(1, student.getRegisterNo());
            statement.setLong(2, student.getClassId());
            statement.setString(3, student.getFirstName());
            statement.setString(4, student.getLastName());
            statement.setString(5, student.getDateOfBirth());
            statement.setString(6, student.getGender());
            statement.setString(7, student.getPhone());
            statement.setString(8, student.getDepartment());
            statement.setInt(9, student.getSemester());
            statement.setInt(10, student.getAdmissionYear());
            statement.setLong(11, student.getId());

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // DELETE STUDENT
    // =========================================================
    public boolean deleteStudent(Connection connection, long studentId) {

        String sql = """
                DELETE FROM students
                WHERE id = ?
                """;

        try (
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, studentId);

            int rowsAffected = statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}