package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Student;
import com.cms.util.DatabaseConnection;

public class StudentRepository {

    public boolean createStudent(Student student) {

        String sql = """
                INSERT INTO students
                (
                    user_id,
                    register_no,
                    first_name,
                    last_name,
                    date_of_birth,
                    gender,
                    phone,
                    department,
                    semester,
                    admission_year
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection =
                        DatabaseConnection.getConnection();
             PreparedStatement statement =
                        connection.prepareStatement(sql)) {

            statement.setLong(1, student.getUserId());
            statement.setString(2, student.getRegisterNo());
            statement.setString(3, student.getFirstName());
            statement.setString(4, student.getLastName());
            statement.setString(5, student.getDateOfBirth());
            statement.setString(6, student.getGender());
            statement.setString(7, student.getPhone());
            statement.setString(8, student.getDepartment());
            statement.setInt(9, student.getSemester());
            statement.setInt(10, student.getAdmissionYear());

            int rowsAffected =
                    statement.executeUpdate();

            return rowsAffected == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createStudent(Connection connection, Student student) {

            String sql = """
                    INSERT INTO students
                    (user_id, register_no, first_name, last_name,
                     date_of_birth, gender, phone, department,
                     semester, admission_year)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """;
        
            try (PreparedStatement statement =
                         connection.prepareStatement(sql)) {
                        
                statement.setLong(1, student.getUserId());
                statement.setString(2, student.getRegisterNo());
                statement.setString(3, student.getFirstName());
                statement.setString(4, student.getLastName());
                statement.setString(5, student.getDateOfBirth());
                statement.setString(6, student.getGender());
                statement.setString(7, student.getPhone());
                statement.setString(8, student.getDepartment());
                statement.setInt(9, student.getSemester());
                statement.setInt(10, student.getAdmissionYear());
        
                int rowsAffected = statement.executeUpdate();
        
                return rowsAffected == 1;
        
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }

    public Student findById(long id) {

        String sql = """
                SELECT
                    id,
                    user_id,
                    register_no,
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

        try (Connection connection =
                        DatabaseConnection.getConnection();
             PreparedStatement statement =
                        connection.prepareStatement(sql)) {

            statement.setLong(1, id);

            try (var resultSet =
                         statement.executeQuery()) {

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

    public List<Student> findAllStudents() {

        List<Student> students = new ArrayList<>();

        String sql = """
                SELECT
                    id,
                    user_id,
                    register_no,
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

        try (Connection connection =
                        DatabaseConnection.getConnection();
             PreparedStatement statement =
                        connection.prepareStatement(sql);
             ResultSet resultSet =
                        statement.executeQuery()) {

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


    public boolean updateStudent(Student student) {

            String sql = """
                    UPDATE students
                    SET register_no = ?,
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
        
            try (Connection connection =
                         DatabaseConnection.getConnection();
                 PreparedStatement statement =
                         connection.prepareStatement(sql)) {
                        
                statement.setString(1, student.getRegisterNo());
                statement.setString(2, student.getFirstName());
                statement.setString(3, student.getLastName());
                statement.setString(4, student.getDateOfBirth());
                statement.setString(5, student.getGender());
                statement.setString(6, student.getPhone());
                statement.setString(7, student.getDepartment());
                statement.setInt(8, student.getSemester());
                statement.setInt(9, student.getAdmissionYear());
                statement.setLong(10, student.getId());
        
                int rowsAffected = statement.executeUpdate();
        
                return rowsAffected == 1;
        
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
}