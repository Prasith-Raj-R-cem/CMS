# Table Structure

## 1. Overview

This document defines the detailed logical structure of every core database table in the Campus Management System.

It follows:

```text
database-overview.md
        ↓
entities.md
        ↓
relationships.md
        ↓
er-diagram.md
        ↓
database-schema.md
        ↓
table-structure.md
```

This document defines:

- Table names
- Column names
- Data types
- Nullability
- Default values
- Primary keys
- Foreign keys
- Unique constraints
- Column purpose

Database constraints and advanced validation rules will be finalized separately in:

```text
constraints.md
```

Indexes will be finalized in:

```text
indexes.md
```

---

# 2. Common Conventions

## Primary Key

All main tables use:

```sql
BIGINT AUTO_INCREMENT
```

as the primary key.

Example:

```text
id BIGINT PK AUTO_INCREMENT
```

## Foreign Key

Foreign keys use:

```text
BIGINT
```

and follow:

```text
<entity>_id
```

Example:

```text
faculty_id
subject_id
class_id
```

## Timestamps

Where appropriate:

```text
created_at DATETIME
updated_at DATETIME
```

## Boolean Values

Use:

```text
BOOLEAN
```

for true/false settings.

---

# 3. users

## Purpose

Central authentication and account table.

## Structure

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Unique user ID |
| email | VARCHAR(255) | NO | — | UNIQUE | Login email |
| password_hash | VARCHAR(255) | NO | — | — | Securely hashed password |
| role | ENUM | NO | — | — | STUDENT, FACULTY, ADMIN |
| status | ENUM | NO | ACTIVE | — | Account status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

### Role Values

```text
STUDENT
FACULTY
ADMIN
```

### Status Values

```text
ACTIVE
INACTIVE
```

### Important Rule

There must be no public:

```text
Register as Admin
```

option.

The initial administrator is created through a secure bootstrap/seed process.

---

# 4. departments

## Purpose

Stores academic departments.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Department ID |
| department_code | VARCHAR(20) | NO | — | UNIQUE | Short department code |
| department_name | VARCHAR(150) | NO | — | UNIQUE | Department name |
| status | ENUM | NO | ACTIVE | — | Department status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

Example:

```text
CSE
Computer Science and Engineering
```

---

# 5. academic_years

## Purpose

Represents an academic year.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Academic year ID |
| year_name | VARCHAR(20) | NO | — | UNIQUE | Example: 2026-2027 |
| start_date | DATE | NO | — | — | Academic year start |
| end_date | DATE | NO | — | — | Academic year end |
| status | ENUM | NO | ACTIVE | — | Academic year status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

### Status

```text
ACTIVE
INACTIVE
COMPLETED
```

---

# 6. semesters

## Purpose

Represents a semester within an academic year.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Semester ID |
| academic_year_id | BIGINT | NO | — | FK | Academic year |
| semester_number | TINYINT | NO | — | — | Semester number |
| semester_name | VARCHAR(30) | NO | — | — | Example: S3 |
| status | ENUM | NO | ACTIVE | — | Semester status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

### Foreign Key

```text
academic_year_id → academic_years.id
```

---

# 7. classes

## Purpose

Represents a student academic group.

Example:

```text
S2 CSE
S3 CSE A
S3 CSE B
```

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Class ID |
| class_name | VARCHAR(50) | NO | — | — | Class name |
| department_id | BIGINT | NO | — | FK | Department |
| semester_id | BIGINT | NO | — | FK | Semester |
| academic_year_id | BIGINT | NO | — | FK | Academic year |
| section | VARCHAR(10) | YES | NULL | — | Section |
| status | ENUM | NO | ACTIVE | — | Class status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

---

# 8. students

## Purpose

Stores student-specific information.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Student ID |
| user_id | BIGINT | NO | — | FK, UNIQUE | User account |
| register_number | VARCHAR(50) | NO | — | UNIQUE | College register number |
| class_id | BIGINT | NO | — | FK | Current class |
| admission_year | YEAR | NO | — | — | Admission year |
| status | ENUM | NO | ACTIVE | — | Student status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

### Foreign Keys

```text
user_id → users.id
class_id → classes.id
```

### Important Rule

One user can have at most one student profile.

---

# 9. faculties

## Purpose

Stores faculty-specific information.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Faculty ID |
| user_id | BIGINT | NO | — | FK, UNIQUE | User account |
| employee_id | VARCHAR(50) | NO | — | UNIQUE | Faculty employee ID |
| department_id | BIGINT | NO | — | FK | Faculty department |
| status | ENUM | NO | ACTIVE | — | Faculty status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

### Foreign Keys

```text
user_id → users.id
department_id → departments.id
```

---

# 10. subjects

## Purpose

Stores academic subjects.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Subject ID |
| subject_code | VARCHAR(30) | NO | — | UNIQUE | Subject code |
| subject_name | VARCHAR(150) | NO | — | — | Subject name |
| department_id | BIGINT | NO | — | FK | Owning department |
| semester_id | BIGINT | NO | — | FK | Associated semester |
| credits | DECIMAL(3,1) | YES | NULL | — | Academic credits |
| subject_type | ENUM | NO | THEORY | — | THEORY, LAB, ELECTIVE, OTHER |
| status | ENUM | NO | ACTIVE | — | Subject status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update time |

---

# 11. faculty_subjects

## Purpose

Mapping table between faculty and subjects.

This supports:

```text
Faculty N : N Subject
```

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Mapping ID |
| faculty_id | BIGINT | NO | — | FK | Faculty |
| subject_id | BIGINT | NO | — | FK | Subject |
| academic_year_id | BIGINT | NO | — | FK | Academic year |
| semester_id | BIGINT | NO | — | FK | Semester |
| status | ENUM | NO | ACTIVE | — | Mapping status |

### Foreign Keys

```text
faculty_id → faculties.id
subject_id → subjects.id
academic_year_id → academic_years.id
semester_id → semesters.id
```

### Recommended Unique Combination

```text
faculty_id
+
subject_id
+
academic_year_id
+
semester_id
```

This prevents duplicate faculty-subject assignments for the same academic context.

---

# 12. class_subjects

## Purpose

Mapping table between classes and subjects.

Supports:

```text
Class N : N Subject
```

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Mapping ID |
| class_id | BIGINT | NO | — | FK | Class |
| subject_id | BIGINT | NO | — | FK | Subject |
| academic_year_id | BIGINT | NO | — | FK | Academic year |
| semester_id | BIGINT | NO | — | FK | Semester |
| status | ENUM | NO | ACTIVE | — | Mapping status |

### Recommended Unique Combination

```text
class_id
+
subject_id
+
academic_year_id
+
semester_id
```

---

# 13. periods

## Purpose

Stores reusable timetable periods.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Period ID |
| period_number | TINYINT | NO | — | — | Period number |
| start_time | TIME | NO | — | — | Period start |
| end_time | TIME | NO | — | — | Period end |
| status | ENUM | NO | ACTIVE | — | Period status |

Example:

```text
1 | 09:00 | 10:00
2 | 10:00 | 11:00
```

---

# 14. rooms

## Purpose

Stores classrooms and laboratories.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Room ID |
| room_number | VARCHAR(30) | NO | — | UNIQUE | Room identifier |
| building | VARCHAR(100) | YES | NULL | — | Building name |
| room_type | ENUM | NO | CLASSROOM | — | CLASSROOM, LAB, SEMINAR_HALL, OTHER |
| capacity | INT | YES | NULL | — | Maximum capacity |
| status | ENUM | NO | ACTIVE | — | Room status |

---

# 15. timetables

## Purpose

Stores the master/normal weekly timetable.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Timetable ID |
| class_id | BIGINT | NO | — | FK | Class |
| subject_id | BIGINT | NO | — | FK | Subject |
| faculty_id | BIGINT | NO | — | FK | Faculty |
| period_id | BIGINT | NO | — | FK | Period |
| room_id | BIGINT | YES | NULL | FK | Room |
| academic_year_id | BIGINT | NO | — | FK | Academic year |
| semester_id | BIGINT | NO | — | FK | Semester |
| day_of_week | ENUM | NO | — | — | MONDAY to SUNDAY |
| status | ENUM | NO | ACTIVE | — | Timetable status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update |

### Important Unique Rule

For a class, the following should not duplicate:

```text
class_id
+
academic_year_id
+
semester_id
+
day_of_week
+
period_id
```

This prevents two subjects from occupying the same class period.

Additional faculty and room conflict rules will be defined separately.

---

# 16. temporary_timetables

## Purpose

Stores approved temporary timetable changes.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Temporary timetable ID |
| request_id | BIGINT | NO | — | FK, UNIQUE | Source period request |
| original_timetable_id | BIGINT | NO | — | FK | Master timetable entry |
| class_id | BIGINT | NO | — | FK | Affected class |
| subject_id | BIGINT | NO | — | FK | Subject actually taught |
| faculty_id | BIGINT | NO | — | FK | Faculty actually teaching |
| period_id | BIGINT | NO | — | FK | Period |
| room_id | BIGINT | YES | NULL | FK | Room |
| date | DATE | NO | — | — | Actual affected date |
| change_type | ENUM | NO | — | — | SUBSTITUTE or BORROW |
| original_subject_id | BIGINT | NO | — | FK | Original subject |
| original_faculty_id | BIGINT | NO | — | FK | Original faculty |
| status | ENUM | NO | ACTIVE | — | Change status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update |

### Important Design

```text
original_* = master timetable values
normal fields = effective temporary values
```

---

# 17. assignments

## Purpose

Stores faculty-created assignments and submission deadlines.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Assignment ID |
| title | VARCHAR(255) | NO | — | — | Assignment title |
| description | TEXT | YES | NULL | — | Question/instructions text |
| class_id | BIGINT | NO | — | FK | Target class |
| subject_id | BIGINT | NO | — | FK | Subject |
| faculty_id | BIGINT | NO | — | FK | Creating faculty |
| deadline | DATETIME | NO | — | — | Submission deadline |
| status | ENUM | NO | ACTIVE | — | Assignment status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update |

### Supported Question Formats

The question can be:

```text
Text
```

or through:

```text
Assignment Attachment
```

---

# 18. assignment_attachments

## Purpose

Stores metadata for assignment files.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Attachment ID |
| assignment_id | BIGINT | NO | — | FK | Assignment |
| file_name | VARCHAR(255) | NO | — | — | Original filename |
| file_type | VARCHAR(100) | NO | — | — | MIME/file type |
| file_size | BIGINT | YES | NULL | — | File size in bytes |
| storage_reference | VARCHAR(500) | NO | — | — | Storage path/key |
| uploaded_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Upload time |

### Important

Do not store large files directly in the `assignments` table.

---

# 19. exams

## Purpose

Represents an examination event.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Exam ID |
| exam_name | VARCHAR(150) | NO | — | — | Exam name |
| exam_type | ENUM | NO | — | — | Exam type |
| academic_year_id | BIGINT | NO | — | FK | Academic year |
| semester_id | BIGINT | NO | — | FK | Semester |
| status | ENUM | NO | ACTIVE | — | Exam status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update |

### Example Exam Types

```text
INTERNAL
MODEL
UNIVERSITY
OTHER
```

---

# 20. exam_timetables

## Purpose

Stores the actual exam schedule.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Exam timetable ID |
| exam_id | BIGINT | NO | — | FK | Exam |
| class_id | BIGINT | NO | — | FK | Class |
| subject_id | BIGINT | NO | — | FK | Subject |
| room_id | BIGINT | YES | NULL | FK | Examination room |
| exam_date | DATE | NO | — | — | Exam date |
| start_time | TIME | NO | — | — | Start time |
| end_time | TIME | NO | — | — | End time |
| status | ENUM | NO | ACTIVE | — | Schedule status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update |

---

# 21. period_requests

## Purpose

Stores faculty requests for:

```text
SUBSTITUTE
BORROW
```

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Request ID |
| request_type | ENUM | NO | — | — | SUBSTITUTE or BORROW |
| requester_faculty_id | BIGINT | NO | — | FK | Faculty making request |
| receiver_faculty_id | BIGINT | NO | — | FK | Faculty receiving request |
| original_timetable_id | BIGINT | NO | — | FK | Original period |
| class_id | BIGINT | NO | — | FK | Affected class |
| period_id | BIGINT | NO | — | FK | Requested period |
| original_subject_id | BIGINT | NO | — | FK | Original subject |
| requested_subject_id | BIGINT | NO | — | FK | Subject requester wants to teach |
| date | DATE | NO | — | — | Requested date |
| request_note | TEXT | YES | NULL | — | Requester's note |
| reply_note | TEXT | YES | NULL | — | Receiver's optional reply |
| status | ENUM | NO | PENDING | — | Request status |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Request creation |
| responded_at | DATETIME | YES | NULL | — | Response time |

### Request Status

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

---

# 22. notifications

## Purpose

Stores user notifications and delivery information.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Notification ID |
| user_id | BIGINT | NO | — | FK | Receiving user |
| event_type | VARCHAR(100) | NO | — | — | Event that generated notification |
| channel | ENUM | NO | — | — | IN_APP, EMAIL, WHATSAPP |
| title | VARCHAR(255) | NO | — | — | Notification title |
| message | TEXT | NO | — | — | Notification body |
| status | ENUM | NO | PENDING | — | Delivery status |
| read_status | ENUM | NO | UNREAD | — | Read state |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| sent_at | DATETIME | YES | NULL | — | Sent time |
| delivered_at | DATETIME | YES | NULL | — | Delivery time |
| read_at | DATETIME | YES | NULL | — | Read time |
| retry_count | INT | NO | 0 | — | Number of retries |
| provider_message_id | VARCHAR(255) | YES | NULL | — | External provider message ID |
| error_code | VARCHAR(100) | YES | NULL | — | Provider/system error |

### Channels

```text
IN_APP
EMAIL
WHATSAPP
```

### Delivery Status

```text
PENDING
SENT
DELIVERED
FAILED
```

### Read Status

```text
UNREAD
READ
```

---

# 23. notification_preferences

## Purpose

Stores notification-channel preferences for each user.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Preference ID |
| user_id | BIGINT | NO | — | FK, UNIQUE | User |
| in_app_enabled | BOOLEAN | NO | TRUE | — | In-app notifications |
| email_enabled | BOOLEAN | NO | TRUE | — | Email notifications |
| whatsapp_enabled | BOOLEAN | NO | FALSE | — | WhatsApp notifications |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update |

WhatsApp should default to `FALSE` until the user has configured/consented to the channel according to the application's rules.

---

# 24. announcements

## Purpose

Stores administrator announcements.

| Column | Type | Null | Default | Key | Description |
|---|---|---:|---|---|---|
| id | BIGINT | NO | AUTO_INCREMENT | PK | Announcement ID |
| created_by | BIGINT | NO | — | FK | Admin user |
| title | VARCHAR(255) | NO | — | — | Announcement title |
| content | TEXT | NO | — | — | Announcement content |
| target_type | ENUM | NO | ALL_USERS | — | Audience type |
| target_reference | BIGINT | YES | NULL | — | Target entity reference |
| status | ENUM | NO | DRAFT | — | Announcement status |
| published_at | DATETIME | YES | NULL | — | Publication time |
| created_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Creation time |
| updated_at | DATETIME | NO | CURRENT_TIMESTAMP | — | Last update |

### Target Types

```text
ALL_USERS
ALL_STUDENTS
ALL_FACULTY
DEPARTMENT
CLASS
SEMESTER
```

### Important Note

`target_reference` is intentionally generic.

For:

```text
DEPARTMENT
CLASS
SEMESTER
```

the application/service layer determines which entity the reference belongs to.

This should not be treated as a normal SQL foreign key to multiple tables.

---

# 25. Foreign Key Summary

## users

```text
No parent FK
```

Root authentication table.

---

## departments

```text
No parent FK
```

---

## academic_years

```text
No parent FK
```

---

## semesters

```text
academic_year_id → academic_years.id
```

---

## classes

```text
department_id → departments.id
semester_id → semesters.id
academic_year_id → academic_years.id
```

---

## students

```text
user_id → users.id
class_id → classes.id
```

---

## faculties

```text
user_id → users.id
department_id → departments.id
```

---

## subjects

```text
department_id → departments.id
semester_id → semesters.id
```

---

## faculty_subjects

```text
faculty_id → faculties.id
subject_id → subjects.id
academic_year_id → academic_years.id
semester_id → semesters.id
```

---

## class_subjects

```text
class_id → classes.id
subject_id → subjects.id
academic_year_id → academic_years.id
semester_id → semesters.id
```

---

## timetables

```text
class_id → classes.id
subject_id → subjects.id
faculty_id → faculties.id
period_id → periods.id
room_id → rooms.id
academic_year_id → academic_years.id
semester_id → semesters.id
```

---

## temporary_timetables

```text
request_id → period_requests.id
original_timetable_id → timetables.id
class_id → classes.id
subject_id → subjects.id
faculty_id → faculties.id
period_id → periods.id
room_id → rooms.id
original_subject_id → subjects.id
original_faculty_id → faculties.id
```

---

## assignments

```text
class_id → classes.id
subject_id → subjects.id
faculty_id → faculties.id
```

---

## assignment_attachments

```text
assignment_id → assignments.id
```

---

## exams

```text
academic_year_id → academic_years.id
semester_id → semesters.id
```

---

## exam_timetables

```text
exam_id → exams.id
class_id → classes.id
subject_id → subjects.id
room_id → rooms.id
```

---

## period_requests

```text
requester_faculty_id → faculties.id
receiver_faculty_id → faculties.id
original_timetable_id → timetables.id
class_id → classes.id
period_id → periods.id
original_subject_id → subjects.id
requested_subject_id → subjects.id
```

---

## notifications

```text
user_id → users.id
```

---

## notification_preferences

```text
user_id → users.id
```

---

## announcements

```text
created_by → users.id
```

---

# 26. Primary Key Summary

Every core table uses:

```text
id BIGINT PRIMARY KEY AUTO_INCREMENT
```

except that no natural-key-only table is currently planned.

Mapping tables still use surrogate IDs:

```text
faculty_subjects.id
class_subjects.id
```

This keeps the Java Repository implementation consistent.

---

# 27. Unique Key Summary

Recommended unique constraints:

```text
users.email

departments.department_code
departments.department_name

academic_years.year_name

students.user_id
students.register_number

faculties.user_id
faculties.employee_id

subjects.subject_code

faculty_subjects
    faculty_id
    subject_id
    academic_year_id
    semester_id

class_subjects
    class_id
    subject_id
    academic_year_id
    semester_id

rooms.room_number

temporary_timetables.request_id

notification_preferences.user_id
```

The exact composite unique constraints will be finalized in `constraints.md`.

---

# 28. Nullability Principles

Use `NOT NULL` when the system cannot logically operate without the value.

Examples:

```text
users.email
users.password_hash
students.user_id
students.class_id
assignments.deadline
period_requests.requester_faculty_id
notifications.user_id
```

Use `NULL` when a value is genuinely optional.

Examples:

```text
assignment.description
assignment_attachments.file_size
rooms.building
timetables.room_id
period_requests.request_note
period_requests.reply_note
period_requests.responded_at
notifications.delivered_at
notifications.error_code
```

---

# 29. Why Some Fields Are Duplicated

Some tables intentionally store information that could potentially be derived through another relationship.

For example:

```text
timetables.academic_year_id
timetables.semester_id
```

Even though the class can also reference academic context.

The purpose is:

```text
Explicit academic context
+
Easier queries
+
Historical clarity
+
Repository simplicity
```

However, the Service Layer must ensure that these references remain consistent.

This will be addressed through constraints and validation.

---

# 30. Important Consistency Rules

The following should be validated before insertion/update:

### Class

```text
class.semester
must belong to
class.academic_year
```

### Faculty Subject

```text
faculty_subject.academic_year
and semester
must represent the assignment context.
```

### Class Subject

```text
class_subject.academic_year
and semester
must match the class context.
```

### Timetable

```text
timetable.class
timetable.subject
timetable.faculty
timetable.academic_year
timetable.semester
```

must represent a valid teaching assignment.

### Temporary Timetable

```text
temporary_timetable.request
```

must be accepted before an active temporary schedule is created.

These are primarily Service Layer rules in addition to database constraints.

---

# 31. Table Dependency Tree

```text
users
│
├── students
│      └── classes
│
├── faculties
│      ├── departments
│      └── faculty_subjects
│
├── notifications
├── notification_preferences
└── announcements


academic_years
│
└── semesters
     │
     ├── classes
     └── subjects


classes
│
├── students
├── class_subjects
├── timetables
├── assignments
├── exam_timetables
└── period_requests


subjects
│
├── class_subjects
├── faculty_subjects
├── timetables
├── assignments
├── exam_timetables
└── period_requests


timetables
│
├── period_requests
└── temporary_timetables


period_requests
│
└── temporary_timetables


assignments
│
└── assignment_attachments


exams
│
└── exam_timetables
```

---

# 32. Recommended Table Creation Order

For SQL implementation:

```text
01 users
02 departments
03 academic_years
04 semesters
05 classes
06 faculties
07 students
08 subjects
09 periods
10 rooms
11 faculty_subjects
12 class_subjects
13 timetables
14 assignments
15 assignment_attachments
16 exams
17 exam_timetables
18 period_requests
19 temporary_timetables
20 notification_preferences
21 notifications
22 announcements
```

The exact SQL creation order can be adjusted to account for all foreign-key dependencies.

---

# 33. Repository Layer Mapping

The table names map directly to Repository classes:

```text
users
    → UserRepository

students
    → StudentRepository

faculties
    → FacultyRepository

departments
    → DepartmentRepository

academic_years
    → AcademicYearRepository

semesters
    → SemesterRepository

classes
    → ClassRepository

subjects
    → SubjectRepository

faculty_subjects
    → FacultySubjectRepository

class_subjects
    → ClassSubjectRepository

periods
    → PeriodRepository

rooms
    → RoomRepository

timetables
    → TimetableRepository

temporary_timetables
    → TemporaryTimetableRepository

assignments
    → AssignmentRepository

assignment_attachments
    → AssignmentAttachmentRepository

exams
    → ExamRepository

exam_timetables
    → ExamTimetableRepository

period_requests
    → PeriodRequestRepository

notifications
    → NotificationRepository

notification_preferences
    → NotificationPreferenceRepository

announcements
    → AnnouncementRepository
```

This gives the backend a clear structure:

```text
Servlet
   ↓
Service
   ↓
Repository
   ↓
JDBC
   ↓
MySQL Table
```

---

# 34. Example Java Repository Mapping

For example:

```text
AssignmentServlet
       ↓
AssignmentService
       ↓
AssignmentRepository
       ↓
assignments
```

Period request:

```text
PeriodRequestServlet
       ↓
PeriodRequestService
       ↓
PeriodRequestRepository
       ↓
period_requests
```

Timetable:

```text
TimetableServlet
       ↓
TimetableService
       ↓
TimetableRepository
       ↓
timetables
```

This separation must be maintained.

JSP should not directly execute SQL.

---

# 35. Security-Sensitive Columns

The following fields require special handling:

```text
users.password_hash
notifications.provider_message_id
notifications.error_code
```

Especially:

```text
password_hash
```

must never contain a plaintext password.

The application should use a secure password hashing algorithm.

---

# 36. Admin Bootstrap Structure

The database does not expose a public admin registration mechanism.

Initial setup:

```text
Secure Bootstrap / Seed
        ↓
users
        ↓
role = ADMIN
```

After the first administrator exists:

```text
ADMIN
  ↓
Create/manage students
Create/manage faculty
Manage academic structure
Manage timetable
Manage exams
Manage announcements
```

Any endpoint that creates or modifies admin-level data must verify authorization in the Service Layer.

---

# 37. Future Extensions

The current schema intentionally leaves room for:

```text
student_submissions
attendance
marks
faculty_attendance
calendar_events
audit_logs
course_materials
chat_messages
clubs
events
hostel_management
fees
```

These should **not** be added to the MVP unless the project scope requires them.

The current schema focuses on:

```text
Assignments
Calendar
Timetable
Exam Timetable
Period Borrowing/Substitution
Notifications
Announcements
User Management
Academic Structure
```

---

# 38. Final Table List

```text
┌────┬──────────────────────────────┐
│ No │ Table                        │
├────┼──────────────────────────────┤
│ 01 │ users                        │
│ 02 │ departments                 │
│ 03 │ academic_years              │
│ 04 │ semesters                   │
│ 05 │ classes                     │
│ 06 │ students                    │
│ 07 │ faculties                   │
│ 08 │ subjects                    │
│ 09 │ faculty_subjects            │
│ 10 │ class_subjects              │
│ 11 │ periods                     │
│ 12 │ rooms                       │
│ 13 │ timetables                  │
│ 14 │ temporary_timetables        │
│ 15 │ assignments                 │
│ 16 │ assignment_attachments      │
│ 17 │ exams                       │
│ 18 │ exam_timetables             │
│ 19 │ period_requests             │
│ 20 │ notifications               │
│ 21 │ notification_preferences    │
│ 22 │ announcements               │
└────┴──────────────────────────────┘
```

---

# 39. Final Verification

Before moving to constraints:

```text
[✓] 22 core tables identified
[✓] Primary keys identified
[✓] Foreign keys identified
[✓] Many-to-many tables identified
[✓] Admin bootstrap policy included
[✓] Assignment attachments supported
[✓] Exam timetable supported
[✓] Master timetable supported
[✓] Temporary timetable supported
[✓] Substitute periods supported
[✓] Borrowed periods supported
[✓] Optional reply notes supported
[✓] In-app notifications supported
[✓] Email notifications supported
[✓] WhatsApp notifications supported
[✓] Notification preferences supported
[✓] Academic year/semester separation supported
[✓] Repository layer mapping included
[✓] JSP is separated from database access
```

---
