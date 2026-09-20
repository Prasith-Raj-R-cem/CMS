-- ============================================================
-- Campus Management System - Development Seed
-- ============================================================
-- Run schema.sql before this file.
--
-- This seed contains the current development MASTER data.
-- users, faculties and students are intentionally NOT seeded;
-- those records are created through the Java application.
--
-- Empty tables are intentionally left empty.
--
-- Timetable/assignment rows depend on faculty FAC001. They use
-- INSERT...SELECT so a fresh database will not fail if FAC001
-- has not yet been created.
-- database creation command
-- 
-- CREATE DATABASE IF NOT EXISTS campus_management
--     CHARACTER SET utf8mb4
--     COLLATE utf8mb4_unicode_ci;
-- ============================================================

USE campus_management;


-- ============================================================
-- 1. DEPARTMENTS
-- ============================================================

INSERT INTO departments
    (id, department_code, department_name, status)
VALUES
    (1, 'CSE', 'Computer Science', 'ACTIVE'),
    (3, 'CE',  'Civil Engineering', 'ACTIVE'),
    (4, 'ME',  'Mechanical Engineering', 'ACTIVE'),
    (6, 'ECE', 'Electronics and Communication Engineering', 'ACTIVE'),
    (7, 'EEE', 'Electrical and Electronics Engineering', 'ACTIVE');


-- ============================================================
-- 2. ACADEMIC YEARS
-- ============================================================

INSERT INTO academic_years
    (id, year_name, start_date, end_date, status)
VALUES
    (1, '2026-27',   '2026-06-01', '2027-05-31', 'ACTIVE'),
    (2, '2025-2026', '2025-02-12', '2026-12-24', 'ACTIVE');


-- ============================================================
-- 3. SEMESTERS
-- ============================================================

INSERT INTO semesters
    (id, academic_year_id, semester_number, semester_name, status)
VALUES
    (1, 1, 3, 'Semester 3', 'ACTIVE'),
    (2, 1, 4, 'S4', 'ACTIVE');


-- ============================================================
-- 4. PERIODS
-- ============================================================
-- NOTE: Period 2 currently has 10:30 -> 09:30 in the database.
-- It is preserved exactly here and is not silently corrected.

INSERT INTO periods
    (id, period_number, start_time, end_time, status)
VALUES
    (1, 1, '09:30:00', '10:30:00', 'ACTIVE'),
    (2, 2, '10:30:00', '09:30:00', 'ACTIVE'),
    (3, 3, '11:45:00', '12:45:00', 'ACTIVE'),
    (4, 4, '13:30:00', '14:30:00', 'ACTIVE');


-- ============================================================
-- 5. ROOMS
-- ============================================================

INSERT INTO rooms
    (id, room_number, building, room_type, capacity, status)
VALUES
    (1, '101', 'Main Block', 'CLASSROOM', 60, 'ACTIVE'),
    (2, '102', 'B block', 'CLASSROOM', 60, 'ACTIVE');


-- ============================================================
-- 6. SUBJECTS
-- ============================================================

INSERT INTO subjects
    (id, subject_code, subject_name, department_id, semester_id,
     credits, subject_type, status)
VALUES
    (1, 'CS301', 'Data Structures', 1, 1, 4.0, 'THEORY', 'ACTIVE'),
    (2, 'GMAT201', 'Mathematics for information Science', 1, 2, 4.0, 'THEORY', 'ACTIVE'),
    (3, 'PCBST304', 'OOP', 1, 1, 4.0, 'THEORY', 'ACTIVE');


-- ============================================================
-- 7. CLASSES
-- ============================================================

INSERT INTO classes
    (id, class_name, department_id, semester_id, academic_year_id,
     section, status)
VALUES
    (1, 'CSE S3', 1, 1, 1, 'A', 'ACTIVE'),
    (2, 'CSE S2', 3, 1, 1, 'A', 'ACTIVE');


-- ============================================================
-- 8. CLASS-SUBJECT MAPPINGS
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 9. FACULTY-SUBJECT MAPPINGS
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 10. TIMETABLES
-- ============================================================
-- Current database contains 2 rows.
-- Faculty is resolved using employee_id = FAC001 because faculty
-- accounts are intentionally not part of this seed.

INSERT INTO timetables
    (id, class_id, subject_id, faculty_id, period_id, room_id,
     academic_year_id, semester_id, day_of_week, status,
     created_at, updated_at)
SELECT
    1, 1, 1, f.id, 2, 1, 1, 1, 'MONDAY', 'ACTIVE',
    '2026-09-07 23:50:49', '2026-09-07 23:50:49'
FROM faculties f
WHERE f.employee_id = 'FAC001'
LIMIT 1;

INSERT INTO timetables
    (id, class_id, subject_id, faculty_id, period_id, room_id,
     academic_year_id, semester_id, day_of_week, status,
     created_at, updated_at)
SELECT
    2, 1, 1, f.id, 3, 1, 1, 1, 'WEDNESDAY', 'ACTIVE',
    '2026-09-11 16:18:09', '2026-09-11 16:18:09'
FROM faculties f
WHERE f.employee_id = 'FAC001'
LIMIT 1;


-- ============================================================
-- 11. TEMPORARY TIMETABLES
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 12. ASSIGNMENTS
-- ============================================================
-- Current database contains 3 rows.
-- Faculty is resolved using employee_id = FAC001.
--
-- NOTE: The first description was truncated in the supplied
-- screenshot, so it is intentionally NULL rather than inventing
-- text.

INSERT INTO assignments
    (id, title, description, class_id, subject_id, faculty_id,
     deadline, status, created_at, updated_at)
SELECT
    1,
    'Data Structures Assignment 01',
    NULL,
    1, 1, f.id,
    '2026-09-20 23:59:00',
    'ACTIVE',
    '2026-09-13 13:40:39',
    '2026-09-17 20:33:13'
FROM faculties f
WHERE f.employee_id = 'FAC001'
LIMIT 1;

INSERT INTO assignments
    (id, title, description, class_id, subject_id, faculty_id,
     deadline, status, created_at, updated_at)
SELECT
    2,
    'Test Assignment',
    'What is probability?',
    1, 2, f.id,
    '2026-09-25 12:30:00',
    'ACTIVE',
    '2026-09-15 17:24:48',
    '2026-09-15 17:24:48'
FROM faculties f
WHERE f.employee_id = 'FAC001'
LIMIT 1;

INSERT INTO assignments
    (id, title, description, class_id, subject_id, faculty_id,
     deadline, status, created_at, updated_at)
SELECT
    3,
    'Opp assignment',
    'Assignment for completion',
    1, 1, f.id,
    '2026-09-18 13:28:00',
    'ACTIVE',
    '2026-09-17 13:29:13',
    '2026-09-17 13:29:13'
FROM faculties f
WHERE f.employee_id = 'FAC001'
LIMIT 1;


-- ============================================================
-- 13. ASSIGNMENT ATTACHMENTS
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 14. EXAMS
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 15. EXAM TIMETABLES
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 16. ANNOUNCEMENTS
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 17. NOTIFICATIONS
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 18. NOTIFICATION PREFERENCES
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 19. PERIOD REQUESTS
-- ============================================================
-- Current database: 0 rows.
-- No seed rows.


-- ============================================================
-- 20. USERS
-- ============================================================
-- Current database: 14 rows.
-- Intentionally NOT seeded.
-- Users must be created through the Java/BCrypt application flow.


-- ============================================================
-- 21. FACULTIES
-- ============================================================
-- Current database: 5 rows.
-- Intentionally NOT seeded.
-- Faculty profiles are created through the Admin application.


-- ============================================================
-- 22. STUDENTS
-- ============================================================
-- Current database: 4 rows.
-- Intentionally NOT seeded.
-- Student profiles are created through the Admin application.


-- ============================================================
-- DEVELOPMENT VERIFICATION
-- ============================================================

SELECT 'academic_years' AS table_name, COUNT(*) AS total_rows FROM academic_years
UNION ALL SELECT 'announcements', COUNT(*) FROM announcements
UNION ALL SELECT 'assignment_attachments', COUNT(*) FROM assignment_attachments
UNION ALL SELECT 'assignments', COUNT(*) FROM assignments
UNION ALL SELECT 'class_subjects', COUNT(*) FROM class_subjects
UNION ALL SELECT 'classes', COUNT(*) FROM classes
UNION ALL SELECT 'departments', COUNT(*) FROM departments
UNION ALL SELECT 'exam_timetables', COUNT(*) FROM exam_timetables
UNION ALL SELECT 'exams', COUNT(*) FROM exams
UNION ALL SELECT 'faculties', COUNT(*) FROM faculties
UNION ALL SELECT 'faculty_subjects', COUNT(*) FROM faculty_subjects
UNION ALL SELECT 'notification_preferences', COUNT(*) FROM notification_preferences
UNION ALL SELECT 'notifications', COUNT(*) FROM notifications
UNION ALL SELECT 'period_requests', COUNT(*) FROM period_requests
UNION ALL SELECT 'periods', COUNT(*) FROM periods
UNION ALL SELECT 'rooms', COUNT(*) FROM rooms
UNION ALL SELECT 'semesters', COUNT(*) FROM semesters
UNION ALL SELECT 'students', COUNT(*) FROM students
UNION ALL SELECT 'subjects', COUNT(*) FROM subjects
UNION ALL SELECT 'temporary_timetables', COUNT(*) FROM temporary_timetables
UNION ALL SELECT 'timetables', COUNT(*) FROM timetables
UNION ALL SELECT 'users', COUNT(*) FROM users;

-- ============================================================
-- END OF SEED
-- ============================================================
