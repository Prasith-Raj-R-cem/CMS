-- ============================================================
-- Campus Management System
-- 05-database-implementation/schema.sql
-- Database: MySQL 8+
--
-- Purpose:
--   Physical database schema derived from:
--   03-database-design/database-schema.md
--   03-database-design/table-structure.md
--   03-database-design/constraints.md
--   03-database-design/indexes.md
--
-- IMPORTANT:
--   This file creates the database structure.
--   Development/sample data belongs in seed.sql.
--   Do NOT store plaintext passwords here.
-- ============================================================


-- ============================================================
-- 1. DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS campus_management
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE campus_management;


-- ============================================================
-- 2. USERS
-- ============================================================

CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,

    role ENUM('STUDENT', 'FACULTY', 'ADMIN') NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_users_email
        UNIQUE (email)
) ENGINE=InnoDB;


-- ============================================================
-- 3. DEPARTMENTS
-- ============================================================

CREATE TABLE departments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    department_code VARCHAR(20) NOT NULL,
    department_name VARCHAR(150) NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_departments_code
        UNIQUE (department_code),

    CONSTRAINT uk_departments_name
        UNIQUE (department_name)
) ENGINE=InnoDB;


-- ============================================================
-- 4. ACADEMIC YEARS
-- ============================================================

CREATE TABLE academic_years (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    year_name VARCHAR(20) NOT NULL,

    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE', 'COMPLETED')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_academic_years_name
        UNIQUE (year_name),

    CONSTRAINT chk_academic_year_dates
        CHECK (start_date < end_date)
) ENGINE=InnoDB;


-- ============================================================
-- 5. SEMESTERS
-- ============================================================

CREATE TABLE semesters (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    academic_year_id BIGINT NOT NULL,

    semester_number TINYINT NOT NULL,
    semester_name VARCHAR(30) NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE', 'COMPLETED')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_semesters_year_number
        UNIQUE (academic_year_id, semester_number),

    CONSTRAINT chk_semester_number
        CHECK (semester_number BETWEEN 1 AND 8),

    CONSTRAINT fk_semesters_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_semesters_academic_year (academic_year_id)
) ENGINE=InnoDB;


-- ============================================================
-- 6. CLASSES
-- ============================================================

CREATE TABLE classes (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    class_name VARCHAR(50) NOT NULL,

    department_id BIGINT NOT NULL,
    semester_id BIGINT NOT NULL,
    academic_year_id BIGINT NOT NULL,

    section VARCHAR(10) NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_classes_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_classes_semester
        FOREIGN KEY (semester_id)
        REFERENCES semesters(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_classes_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_classes_department (department_id),
    INDEX idx_classes_semester (semester_id),
    INDEX idx_classes_academic_year (academic_year_id),
    INDEX idx_classes_academic_context
        (academic_year_id, semester_id, department_id)
) ENGINE=InnoDB;


-- ============================================================
-- 7. STUDENTS
-- ============================================================

CREATE TABLE students (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    user_id BIGINT NOT NULL,
    register_number VARCHAR(50) NOT NULL,

    class_id BIGINT NOT NULL,

    admission_year YEAR NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_students_user
        UNIQUE (user_id),

    CONSTRAINT uk_students_register
        UNIQUE (register_number),

    CONSTRAINT fk_students_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_students_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_students_class (class_id)
) ENGINE=InnoDB;


-- ============================================================
-- 8. FACULTIES
-- ============================================================

CREATE TABLE faculties (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    user_id BIGINT NOT NULL,
    employee_id VARCHAR(50) NOT NULL,

    department_id BIGINT NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_faculties_user
        UNIQUE (user_id),

    CONSTRAINT uk_faculties_employee
        UNIQUE (employee_id),

    CONSTRAINT fk_faculties_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_faculties_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_faculties_department (department_id)
) ENGINE=InnoDB;


-- ============================================================
-- 9. SUBJECTS
-- ============================================================

CREATE TABLE subjects (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    subject_code VARCHAR(30) NOT NULL,
    subject_name VARCHAR(150) NOT NULL,

    department_id BIGINT NOT NULL,
    semester_id BIGINT NOT NULL,

    credits DECIMAL(3,1) NULL,

    subject_type ENUM(
        'THEORY',
        'LAB',
        'ELECTIVE',
        'OTHER'
    ) NOT NULL DEFAULT 'THEORY',

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_subjects_code
        UNIQUE (subject_code),

    CONSTRAINT chk_subject_credits
        CHECK (credits IS NULL OR credits > 0),

    CONSTRAINT fk_subjects_department
        FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_subjects_semester
        FOREIGN KEY (semester_id)
        REFERENCES semesters(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_subjects_department (department_id),
    INDEX idx_subjects_semester (semester_id)
) ENGINE=InnoDB;


-- ============================================================
-- 10. PERIODS
-- ============================================================

CREATE TABLE periods (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    period_number TINYINT NOT NULL,

    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT uk_periods_number
        UNIQUE (period_number),

    CONSTRAINT chk_period_number
        CHECK (period_number > 0),

    CONSTRAINT chk_period_times
        CHECK (start_time < end_time)
) ENGINE=InnoDB;


-- ============================================================
-- 11. ROOMS
-- ============================================================

CREATE TABLE rooms (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    room_number VARCHAR(30) NOT NULL,

    building VARCHAR(100) NULL,

    room_type ENUM(
        'CLASSROOM',
        'LAB',
        'SEMINAR_HALL',
        'OTHER'
    ) NOT NULL DEFAULT 'CLASSROOM',

    capacity INT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT uk_rooms_number
        UNIQUE (room_number),

    CONSTRAINT chk_room_capacity
        CHECK (capacity IS NULL OR capacity > 0),

    INDEX idx_rooms_status (status)
) ENGINE=InnoDB;


-- ============================================================
-- 12. FACULTY-SUBJECT MAPPING
-- ============================================================

CREATE TABLE faculty_subjects (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    faculty_id BIGINT NOT NULL,
    subject_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,
    semester_id BIGINT NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT uk_faculty_subject_context
        UNIQUE (
            faculty_id,
            subject_id,
            academic_year_id,
            semester_id
        ),

    CONSTRAINT fk_faculty_subjects_faculty
        FOREIGN KEY (faculty_id)
        REFERENCES faculties(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_faculty_subjects_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_faculty_subjects_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_faculty_subjects_semester
        FOREIGN KEY (semester_id)
        REFERENCES semesters(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_faculty_subjects_subject (subject_id),

    INDEX idx_faculty_subjects_faculty_context
        (faculty_id, academic_year_id, semester_id)
) ENGINE=InnoDB;


-- ============================================================
-- 13. CLASS-SUBJECT MAPPING
-- ============================================================

CREATE TABLE class_subjects (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    class_id BIGINT NOT NULL,
    subject_id BIGINT NOT NULL,

    academic_year_id BIGINT NOT NULL,
    semester_id BIGINT NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT uk_class_subject_context
        UNIQUE (
            class_id,
            subject_id,
            academic_year_id,
            semester_id
        ),

    CONSTRAINT fk_class_subjects_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_class_subjects_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_class_subjects_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_class_subjects_semester
        FOREIGN KEY (semester_id)
        REFERENCES semesters(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_class_subjects_subject (subject_id),

    INDEX idx_class_subjects_class_context
        (class_id, academic_year_id, semester_id)
) ENGINE=InnoDB;


-- ============================================================
-- 14. MASTER TIMETABLE
-- ============================================================

CREATE TABLE timetables (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    class_id BIGINT NOT NULL,
    subject_id BIGINT NOT NULL,
    faculty_id BIGINT NOT NULL,

    period_id BIGINT NOT NULL,
    room_id BIGINT NULL,

    academic_year_id BIGINT NOT NULL,
    semester_id BIGINT NOT NULL,

    day_of_week ENUM(
        'MONDAY',
        'TUESDAY',
        'WEDNESDAY',
        'THURSDAY',
        'FRIDAY',
        'SATURDAY',
        'SUNDAY'
    ) NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_timetables_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_timetables_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_timetables_faculty
        FOREIGN KEY (faculty_id)
        REFERENCES faculties(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_timetables_period
        FOREIGN KEY (period_id)
        REFERENCES periods(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_timetables_room
        FOREIGN KEY (room_id)
        REFERENCES rooms(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_timetables_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_timetables_semester
        FOREIGN KEY (semester_id)
        REFERENCES semesters(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT uk_timetable_class_slot
        UNIQUE (
            class_id,
            academic_year_id,
            semester_id,
            day_of_week,
            period_id
        ),

    INDEX idx_timetables_class_schedule
        (class_id, academic_year_id, semester_id, day_of_week, period_id),

    INDEX idx_timetables_faculty_schedule
        (faculty_id, academic_year_id, semester_id, day_of_week, period_id),

    INDEX idx_timetables_room_schedule
        (room_id, academic_year_id, semester_id, day_of_week, period_id)
) ENGINE=InnoDB;


-- ============================================================
-- 15. ASSIGNMENTS
-- ============================================================

CREATE TABLE assignments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    title VARCHAR(255) NOT NULL,
    description TEXT NULL,

    class_id BIGINT NOT NULL,
    subject_id BIGINT NOT NULL,
    faculty_id BIGINT NOT NULL,

    deadline DATETIME NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_assignments_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_assignments_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_assignments_faculty
        FOREIGN KEY (faculty_id)
        REFERENCES faculties(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_assignments_class_deadline
        (class_id, deadline),

    INDEX idx_assignments_faculty_created
        (faculty_id, created_at),

    INDEX idx_assignments_subject
        (subject_id),

    INDEX idx_assignments_deadline
        (deadline)
) ENGINE=InnoDB;


-- ============================================================
-- 16. ASSIGNMENT ATTACHMENTS
-- ============================================================

CREATE TABLE assignment_attachments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    assignment_id BIGINT NOT NULL,

    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(100) NOT NULL,

    file_size BIGINT NULL,

    storage_reference VARCHAR(500) NOT NULL,

    uploaded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_assignment_attachments_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES assignments(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_assignment_file_size
        CHECK (file_size IS NULL OR file_size > 0),

    INDEX idx_assignment_attachments_assignment
        (assignment_id)
) ENGINE=InnoDB;


-- ============================================================
-- 17. EXAMS
-- ============================================================

CREATE TABLE exams (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    exam_name VARCHAR(150) NOT NULL,

    exam_type ENUM(
        'INTERNAL',
        'MODEL',
        'UNIVERSITY',
        'OTHER'
    ) NOT NULL,

    academic_year_id BIGINT NOT NULL,
    semester_id BIGINT NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE', 'COMPLETED')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_exams_academic_year
        FOREIGN KEY (academic_year_id)
        REFERENCES academic_years(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_exams_semester
        FOREIGN KEY (semester_id)
        REFERENCES semesters(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_exams_academic_context
        (academic_year_id, semester_id)
) ENGINE=InnoDB;


-- ============================================================
-- 18. EXAM TIMETABLES
-- ============================================================

CREATE TABLE exam_timetables (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    exam_id BIGINT NOT NULL,
    class_id BIGINT NOT NULL,
    subject_id BIGINT NOT NULL,

    room_id BIGINT NULL,

    exam_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    status ENUM('ACTIVE', 'INACTIVE')
        NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_exam_times
        CHECK (start_time < end_time),

    CONSTRAINT fk_exam_timetables_exam
        FOREIGN KEY (exam_id)
        REFERENCES exams(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_exam_timetables_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_exam_timetables_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_exam_timetables_room
        FOREIGN KEY (room_id)
        REFERENCES rooms(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_exam_timetables_class_date
        (class_id, exam_date, start_time),

    INDEX idx_exam_timetables_subject
        (subject_id),

    INDEX idx_exam_timetables_room_date
        (room_id, exam_date, start_time, end_time),

    INDEX idx_exam_timetables_exam
        (exam_id)
) ENGINE=InnoDB;


-- ============================================================
-- 19. PERIOD REQUESTS
-- ============================================================

CREATE TABLE period_requests (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    request_type ENUM(
        'SUBSTITUTE',
        'BORROW'
    ) NOT NULL,

    requester_faculty_id BIGINT NOT NULL,
    receiver_faculty_id BIGINT NOT NULL,

    original_timetable_id BIGINT NOT NULL,

    class_id BIGINT NOT NULL,
    period_id BIGINT NOT NULL,

    original_subject_id BIGINT NOT NULL,
    requested_subject_id BIGINT NOT NULL,

    date DATE NOT NULL,

    request_note TEXT NULL,
    reply_note TEXT NULL,

    status ENUM(
        'PENDING',
        'ACCEPTED',
        'REJECTED',
        'CANCELLED',
        'EXPIRED'
    ) NOT NULL DEFAULT 'PENDING',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    responded_at DATETIME NULL,

    CONSTRAINT chk_period_request_faculties
        CHECK (requester_faculty_id <> receiver_faculty_id),

    CONSTRAINT fk_period_requests_requester
        FOREIGN KEY (requester_faculty_id)
        REFERENCES faculties(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_period_requests_receiver
        FOREIGN KEY (receiver_faculty_id)
        REFERENCES faculties(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_period_requests_timetable
        FOREIGN KEY (original_timetable_id)
        REFERENCES timetables(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_period_requests_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_period_requests_period
        FOREIGN KEY (period_id)
        REFERENCES periods(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_period_requests_original_subject
        FOREIGN KEY (original_subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_period_requests_requested_subject
        FOREIGN KEY (requested_subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_period_requests_receiver_status
        (receiver_faculty_id, status, created_at),

    INDEX idx_period_requests_requester_status
        (requester_faculty_id, status, created_at),

    INDEX idx_period_requests_date
        (date),

    INDEX idx_period_requests_original_timetable
        (original_timetable_id),

    INDEX idx_period_requests_class_date_period
        (class_id, date, period_id)
) ENGINE=InnoDB;


-- ============================================================
-- 20. TEMPORARY TIMETABLES
-- ============================================================

CREATE TABLE temporary_timetables (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    request_id BIGINT NOT NULL,
    original_timetable_id BIGINT NOT NULL,

    class_id BIGINT NOT NULL,
    subject_id BIGINT NOT NULL,
    faculty_id BIGINT NOT NULL,

    period_id BIGINT NOT NULL,
    room_id BIGINT NULL,

    date DATE NOT NULL,

    change_type ENUM(
        'SUBSTITUTE',
        'BORROW'
    ) NOT NULL,

    original_subject_id BIGINT NOT NULL,
    original_faculty_id BIGINT NOT NULL,

    status ENUM(
        'ACTIVE',
        'EXPIRED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'ACTIVE',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_temp_timetable_request
        UNIQUE (request_id),

    CONSTRAINT fk_temp_timetable_request
        FOREIGN KEY (request_id)
        REFERENCES period_requests(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_original
        FOREIGN KEY (original_timetable_id)
        REFERENCES timetables(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_class
        FOREIGN KEY (class_id)
        REFERENCES classes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_faculty
        FOREIGN KEY (faculty_id)
        REFERENCES faculties(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_period
        FOREIGN KEY (period_id)
        REFERENCES periods(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_room
        FOREIGN KEY (room_id)
        REFERENCES rooms(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_original_subject
        FOREIGN KEY (original_subject_id)
        REFERENCES subjects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_temp_timetable_original_faculty
        FOREIGN KEY (original_faculty_id)
        REFERENCES faculties(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_temp_class_date_period
        (class_id, date, period_id),

    INDEX idx_temp_faculty_date_period
        (faculty_id, date, period_id),

    INDEX idx_temp_room_date_period
        (room_id, date, period_id),

    INDEX idx_temp_original_date
        (original_timetable_id, date)
) ENGINE=InnoDB;


-- ============================================================
-- 21. NOTIFICATION PREFERENCES
-- ============================================================

CREATE TABLE notification_preferences (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    user_id BIGINT NOT NULL,

    in_app_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    email_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    whatsapp_enabled BOOLEAN NOT NULL DEFAULT FALSE,

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_notification_preferences_user
        UNIQUE (user_id),

    CONSTRAINT fk_notification_preferences_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ============================================================
-- 22. NOTIFICATIONS
-- ============================================================

CREATE TABLE notifications (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    user_id BIGINT NOT NULL,

    event_type VARCHAR(100) NOT NULL,

    channel ENUM(
        'IN_APP',
        'EMAIL',
        'WHATSAPP'
    ) NOT NULL,

    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,

    status ENUM(
        'PENDING',
        'SENT',
        'DELIVERED',
        'FAILED'
    ) NOT NULL DEFAULT 'PENDING',

    read_status ENUM(
        'UNREAD',
        'READ'
    ) NOT NULL DEFAULT 'UNREAD',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    sent_at DATETIME NULL,
    delivered_at DATETIME NULL,
    read_at DATETIME NULL,

    retry_count INT NOT NULL DEFAULT 0,

    provider_message_id VARCHAR(255) NULL,
    error_code VARCHAR(100) NULL,

    CONSTRAINT chk_notification_retry_count
        CHECK (retry_count >= 0),

    CONSTRAINT fk_notifications_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_notifications_user_read_created
        (user_id, read_status, created_at),

    INDEX idx_notifications_user_channel
        (user_id, channel),

    INDEX idx_notifications_status_created
        (status, created_at),

    INDEX idx_notifications_provider_message
        (provider_message_id)
) ENGINE=InnoDB;


-- ============================================================
-- 23. ANNOUNCEMENTS
-- ============================================================

CREATE TABLE announcements (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,

    created_by BIGINT NOT NULL,

    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,

    target_type ENUM(
        'ALL_USERS',
        'ALL_STUDENTS',
        'ALL_FACULTY',
        'DEPARTMENT',
        'CLASS',
        'SEMESTER'
    ) NOT NULL DEFAULT 'ALL_USERS',

    target_reference BIGINT NULL,

    status ENUM(
        'DRAFT',
        'PUBLISHED',
        'ARCHIVED'
    ) NOT NULL DEFAULT 'DRAFT',

    published_at DATETIME NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_announcements_creator
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_announcements_status_published
        (status, published_at),

    INDEX idx_announcements_creator
        (created_by, created_at),

    INDEX idx_announcements_target
        (target_type, target_reference, status, published_at)
) ENGINE=InnoDB;


-- ============================================================
-- 24. SCHEMA COMPLETION
-- ============================================================

-- Verify tables with:
--
-- SHOW TABLES;
--
-- Verify structure with:
--
-- DESCRIBE users;
-- DESCRIBE students;
-- DESCRIBE faculties;
-- DESCRIBE classes;
-- DESCRIBE subjects;
-- DESCRIBE timetables;
-- DESCRIBE assignments;
-- DESCRIBE period_requests;
-- DESCRIBE temporary_timetables;
-- DESCRIBE notifications;
--
-- Foreign-key information can be inspected using:
--
-- SHOW CREATE TABLE timetables;
--
-- SHOW CREATE TABLE period_requests;
--
-- SHOW CREATE TABLE temporary_timetables;


-- ============================================================
-- END OF SCHEMA
-- ============================================================
