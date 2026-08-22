# Database Schema

## 1. Overview

This document converts the conceptual ER design into the planned logical MySQL schema for the Campus Management System.

The schema is designed for:

```text
Database      : MySQL
Backend       : Java
Database API  : JDBC
Architecture  : JSP → Servlet → Service → Repository → JDBC → MySQL
```

This document defines:

- Database tables
- Primary keys
- Foreign keys
- Main columns
- Data types
- Logical constraints
- Status fields
- Important schema decisions

Detailed column-by-column documentation will be maintained in:

```text
table-structure.md
```

Database constraints will be finalized in:

```text
constraints.md
```

Indexes will be finalized in:

```text
indexes.md
```

---

# 2. Database Naming Convention

Use `snake_case` for tables and columns.

Examples:

```text
users
academic_years
faculty_subjects
temporary_timetables
created_at
updated_at
```

Primary key convention:

```text
id
```

Foreign key convention:

```text
<referenced_entity>_id
```

Examples:

```text
user_id
class_id
faculty_id
subject_id
period_id
```

---

# 3. Data Type Strategy

Recommended MySQL types:

```text
BIGINT      → Primary and foreign keys
VARCHAR     → Short text
TEXT        → Long text
INT         → Numbers/counts
DECIMAL     → Credits or values requiring precision
DATE        → Calendar dates
TIME        → Period/exam times
DATETIME    → Timestamps
BOOLEAN     → True/false values
ENUM        → Small controlled status/type values
```

The exact lengths will be finalized in `table-structure.md`.

---

# 4. Schema Overview

The planned core tables are:

```text
01. users
02. students
03. faculties
04. departments
05. academic_years
06. semesters
07. classes
08. subjects
09. faculty_subjects
10. class_subjects
11. periods
12. rooms
13. timetables
14. temporary_timetables
15. assignments
16. assignment_attachments
17. exams
18. exam_timetables
19. period_requests
20. notifications
21. notification_preferences
22. announcements
```

---

# 5. Users Table

## Purpose

Central authentication and account table.

```text
users
├── id PK
├── email UNIQUE
├── password_hash
├── role
├── status
├── created_at
└── updated_at
```

Logical definition:

```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'FACULTY', 'ADMIN') NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') NOT NULL DEFAULT 'ACTIVE',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

> The final production SQL may use a trigger/application update for `updated_at` depending on the selected MySQL configuration.

---

# 6. Departments Table

```text
departments
├── id PK
├── department_code UNIQUE
├── department_name
├── status
├── created_at
└── updated_at
```

Relationship:

```text
departments
    ↓
faculties
classes
subjects
```

---

# 7. Academic Years Table

```text
academic_years
├── id PK
├── year_name UNIQUE
├── start_date
├── end_date
├── status
├── created_at
└── updated_at
```

Example:

```text
2026-2027
```

---

# 8. Semesters Table

```text
semesters
├── id PK
├── academic_year_id FK
├── semester_number
├── semester_name
├── status
├── created_at
└── updated_at
```

Relationship:

```text
academic_years 1 ─── N semesters
```

---

# 9. Classes Table

```text
classes
├── id PK
├── class_name
├── department_id FK
├── semester_id FK
├── academic_year_id FK
├── section
├── status
├── created_at
└── updated_at
```

Example:

```text
S2 CSE
S3 CSE A
S3 CSE B
```

---

# 10. Students Table

```text
students
├── id PK
├── user_id FK UNIQUE
├── register_number UNIQUE
├── class_id FK
├── admission_year
├── status
├── created_at
└── updated_at
```

Important:

```text
students.user_id → users.id
students.class_id → classes.id
```

---

# 11. Faculties Table

```text
faculties
├── id PK
├── user_id FK UNIQUE
├── employee_id UNIQUE
├── department_id FK
├── status
├── created_at
└── updated_at
```

Relationships:

```text
faculties.user_id → users.id
faculties.department_id → departments.id
```

---

# 12. Subjects Table

```text
subjects
├── id PK
├── subject_code UNIQUE
├── subject_name
├── department_id FK
├── semester_id FK
├── credits
├── subject_type
├── status
├── created_at
└── updated_at
```

---

# 13. Faculty Subjects Table

This is the faculty-subject mapping table.

```text
faculty_subjects
├── id PK
├── faculty_id FK
├── subject_id FK
├── academic_year_id FK
├── semester_id FK
└── status
```

Relationship:

```text
Faculty N ─── N Subject
```

This table is important for validating:

```text
Assignment creation
Timetable allocation
Borrow-period requests
```

---

# 14. Class Subjects Table

This is the class-subject mapping table.

```text
class_subjects
├── id PK
├── class_id FK
├── subject_id FK
├── academic_year_id FK
├── semester_id FK
└── status
```

Relationship:

```text
Class N ─── N Subject
```

This table determines which subjects a class is expected to study.

---

# 15. Periods Table

```text
periods
├── id PK
├── period_number
├── start_time
├── end_time
└── status
```

Example:

```text
1 → 09:00 - 10:00
2 → 10:00 - 11:00
3 → 11:00 - 12:00
```

Periods are reusable across timetable records.

---

# 16. Rooms Table

```text
rooms
├── id PK
├── room_number
├── building
├── room_type
├── capacity
└── status
```

Example:

```text
Room 201
Main Block
CLASSROOM
Capacity 60
```

---

# 17. Timetables Table

This is the **master timetable**.

```text
timetables
├── id PK
├── class_id FK
├── subject_id FK
├── faculty_id FK
├── period_id FK
├── room_id FK
├── academic_year_id FK
├── semester_id FK
├── day_of_week
├── status
├── created_at
└── updated_at
```

Important:

```text
This table represents the normal academic timetable.
```

Temporary changes must not overwrite it.

---

# 18. Temporary Timetables Table

This table stores approved temporary timetable changes.

```text
temporary_timetables
├── id PK
├── request_id FK UNIQUE
├── original_timetable_id FK
├── class_id FK
├── subject_id FK
├── faculty_id FK
├── period_id FK
├── room_id FK
├── date
├── change_type
├── original_subject_id FK
├── original_faculty_id FK
├── status
├── created_at
└── updated_at
```

Possible change types:

```text
SUBSTITUTE
BORROW
```

Important concept:

```text
MASTER TIMETABLE
       +
TEMPORARY TIMETABLE
       ↓
EFFECTIVE TIMETABLE
```

---

# 19. Assignments Table

```text
assignments
├── id PK
├── title
├── description
├── class_id FK
├── subject_id FK
├── faculty_id FK
├── deadline
├── status
├── created_at
└── updated_at
```

This supports:

```text
Assignment title
Question text
Deadline
Class
Subject
Faculty
```

---

# 20. Assignment Attachments Table

```text
assignment_attachments
├── id PK
├── assignment_id FK
├── file_name
├── file_type
├── file_size
├── storage_reference
└── uploaded_at
```

The database stores attachment metadata.

The actual file can be stored using an appropriate storage mechanism.

---

# 21. Exams Table

```text
exams
├── id PK
├── exam_name
├── exam_type
├── academic_year_id FK
├── semester_id FK
├── status
├── created_at
└── updated_at
```

Example:

```text
S3 Internal Examination
University Examination
Model Examination
```

---

# 22. Exam Timetables Table

```text
exam_timetables
├── id PK
├── exam_id FK
├── class_id FK
├── subject_id FK
├── room_id FK
├── exam_date
├── start_time
├── end_time
├── status
├── created_at
└── updated_at
```

This table represents the actual examination schedule.

---

# 23. Period Requests Table

This table supports both:

```text
SUBSTITUTE
BORROW
```

requests.

```text
period_requests
├── id PK
├── request_type
├── requester_faculty_id FK
├── receiver_faculty_id FK
├── original_timetable_id FK
├── class_id FK
├── period_id FK
├── original_subject_id FK
├── requested_subject_id FK
├── date
├── request_note
├── reply_note
├── status
├── created_at
└── responded_at
```

---

# 24. Substitute Request Schema Logic

For:

```text
request_type = SUBSTITUTE
```

Expected values:

```text
requester_faculty_id = Faculty A
receiver_faculty_id = Faculty B

original_subject_id = Data Structures
requested_subject_id = Data Structures
```

After acceptance:

```text
temporary_timetables.faculty_id = Faculty B
temporary_timetables.subject_id = Data Structures
```

---

# 25. Borrow Request Schema Logic

For:

```text
request_type = BORROW
```

Example:

```text
requester_faculty_id = Faculty B
receiver_faculty_id = Faculty A

original_subject_id = Data Structures
requested_subject_id = OOP
```

After acceptance:

```text
temporary_timetables.faculty_id = Faculty B
temporary_timetables.subject_id = OOP
```

The Service Layer must verify that Faculty B is authorized to teach OOP.

---

# 26. Notifications Table

```text
notifications
├── id PK
├── user_id FK
├── event_type
├── channel
├── title
├── message
├── status
├── read_status
├── created_at
├── sent_at
├── delivered_at
├── read_at
├── retry_count
├── provider_message_id
└── error_code
```

Channels:

```text
IN_APP
EMAIL
WHATSAPP
```

---

# 27. Notification Preferences Table

```text
notification_preferences
├── id PK
├── user_id FK UNIQUE
├── in_app_enabled
├── email_enabled
├── whatsapp_enabled
└── updated_at
```

Example:

```text
Student
├── In-App    = TRUE
├── Email     = TRUE
└── WhatsApp  = FALSE
```

---

# 28. Announcements Table

```text
announcements
├── id PK
├── created_by FK
├── title
├── content
├── target_type
├── target_reference
├── status
├── published_at
├── created_at
└── updated_at
```

`created_by` references:

```text
users.id
```

The application must verify that the creator is an administrator.

---

# 29. Foreign Key Structure

## Users

```text
students.user_id
    → users.id

faculties.user_id
    → users.id

notifications.user_id
    → users.id

notification_preferences.user_id
    → users.id

announcements.created_by
    → users.id
```

## Academic

```text
faculties.department_id
    → departments.id

classes.department_id
    → departments.id

classes.semester_id
    → semesters.id

classes.academic_year_id
    → academic_years.id

subjects.department_id
    → departments.id

subjects.semester_id
    → semesters.id

semesters.academic_year_id
    → academic_years.id
```

## Mapping

```text
faculty_subjects.faculty_id
    → faculties.id

faculty_subjects.subject_id
    → subjects.id

faculty_subjects.academic_year_id
    → academic_years.id

faculty_subjects.semester_id
    → semesters.id

class_subjects.class_id
    → classes.id

class_subjects.subject_id
    → subjects.id

class_subjects.academic_year_id
    → academic_years.id

class_subjects.semester_id
    → semesters.id
```

## Timetable

```text
timetables.class_id
    → classes.id

timetables.subject_id
    → subjects.id

timetables.faculty_id
    → faculties.id

timetables.period_id
    → periods.id

timetables.room_id
    → rooms.id

timetables.academic_year_id
    → academic_years.id

timetables.semester_id
    → semesters.id
```

## Temporary Timetable

```text
temporary_timetables.request_id
    → period_requests.id

temporary_timetables.original_timetable_id
    → timetables.id

temporary_timetables.class_id
    → classes.id

temporary_timetables.subject_id
    → subjects.id

temporary_timetables.faculty_id
    → faculties.id

temporary_timetables.period_id
    → periods.id

temporary_timetables.room_id
    → rooms.id

temporary_timetables.original_subject_id
    → subjects.id

temporary_timetables.original_faculty_id
    → faculties.id
```

## Assignments

```text
assignments.class_id
    → classes.id

assignments.subject_id
    → subjects.id

assignments.faculty_id
    → faculties.id

assignment_attachments.assignment_id
    → assignments.id
```

## Examinations

```text
exams.academic_year_id
    → academic_years.id

exams.semester_id
    → semesters.id

exam_timetables.exam_id
    → exams.id

exam_timetables.class_id
    → classes.id

exam_timetables.subject_id
    → subjects.id

exam_timetables.room_id
    → rooms.id
```

## Period Requests

```text
period_requests.requester_faculty_id
    → faculties.id

period_requests.receiver_faculty_id
    → faculties.id

period_requests.original_timetable_id
    → timetables.id

period_requests.class_id
    → classes.id

period_requests.period_id
    → periods.id

period_requests.original_subject_id
    → subjects.id

period_requests.requested_subject_id
    → subjects.id
```

---

# 30. Status Strategy

Status fields are used where records may need to be deactivated without destroying historical information.

Common status values:

```text
ACTIVE
INACTIVE
```

Request-specific status:

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

Notification status:

```text
PENDING
SENT
DELIVERED
FAILED
```

Temporary timetable status:

```text
ACTIVE
EXPIRED
CANCELLED
```

The exact ENUM values will be finalized in `constraints.md`.

---

# 31. Delete Strategy

Foreign keys should generally use restrictive deletion for important academic records.

Recommended default:

```text
ON DELETE RESTRICT
```

For dependent attachments:

```text
Assignment
    ↓
AssignmentAttachment
```

`ON DELETE CASCADE` may be appropriate if an assignment is permanently deleted.

However, because the project aims to preserve history, the preferred application strategy is often:

```text
Deactivate / Cancel
```

instead of physical deletion.

The exact rules will be defined in `constraints.md`.

---

# 32. Update Strategy

Most entities should support:

```text
created_at
updated_at
```

where records are editable.

For example:

```text
assignments
timetables
announcements
exam_timetables
```

System-generated records such as notification delivery records may have different timestamp requirements.

---

# 33. Academic Context Strategy

Academic context is important for avoiding data mixing between years.

Example:

```text
2025-2026 → S3 CSE
2026-2027 → S3 CSE
```

These are different academic class instances.

Therefore, important academic tables retain references to:

```text
academic_year_id
semester_id
```

where required.

---

# 34. Timetable Date Strategy

The master timetable represents recurring weekly scheduling.

Therefore it stores:

```text
day_of_week
```

rather than a specific calendar date.

Temporary timetable changes store:

```text
date
```

because the change applies to a specific date.

Example:

```text
Master:
Monday + Period 3

Temporary:
2026-09-21 + Period 3
```

---

# 35. Assignment Deadline Strategy

Assignments store:

```text
deadline DATETIME
```

This allows:

```text
Date
+
Time
```

to be represented together.

Example:

```text
2026-09-25 23:59:00
```

The calendar can directly use this value.

---

# 36. Exam Schedule Strategy

Exams use separate:

```text
exam_date
start_time
end_time
```

because an examination has a calendar date and a defined time window.

---

# 37. File Storage Strategy

Assignment attachments should not require storing large binary files directly in the normal assignment table.

Recommended database data:

```text
file_name
file_type
file_size
storage_reference
```

Possible future storage:

```text
Local Storage
Cloud Storage
Object Storage
```

The Repository stores metadata while a separate file-storage service handles the actual file.

---

# 38. Notification Provider Strategy

The database should remain independent of the external messaging provider.

For WhatsApp:

```text
Notification
      ↓
WhatsAppNotificationService
      ↓
WhatsApp Provider API
```

The database may store:

```text
provider_message_id
status
error_code
```

but not provider secrets.

---

# 39. Notification Event Strategy

Notifications should identify why they were generated.

Possible event types:

```text
ASSIGNMENT_CREATED
ASSIGNMENT_DEADLINE_REMINDER
EXAM_TIMETABLE_PUBLISHED
TIMETABLE_CHANGED
PERIOD_REQUEST_RECEIVED
PERIOD_REQUEST_ACCEPTED
PERIOD_REQUEST_REJECTED
ANNOUNCEMENT_PUBLISHED
```

Additional event types can be added later.

---

# 40. Generic Notification Source

A future-compatible notification can optionally store:

```text
source_type
source_id
```

Example:

```text
source_type = ASSIGNMENT
source_id = 101
```

or:

```text
source_type = PERIOD_REQUEST
source_id = 45
```

This is a logical design decision and should be implemented carefully because a generic `source_id` does not provide a traditional SQL foreign key.

For the initial mini-project, the implementation can keep notification generation event-based and add source references only if required by the UI.

---

# 41. Calendar Data Model

There is no required `calendar_events` table in the initial schema.

The calendar service can combine:

```text
TIMETABLES
TEMPORARY_TIMETABLES
ASSIGNMENTS
EXAM_TIMETABLES
PERIOD_REQUESTS
ANNOUNCEMENTS
```

into a common calendar response.

Example:

```text
CalendarService
      │
      ├── getTimetableEvents()
      ├── getAssignmentDeadlines()
      ├── getExamEvents()
      ├── getTemporaryChanges()
      └── getRelevantAnnouncements()
```

This avoids storing duplicate calendar information.

---

# 42. Future Calendar Extension

If later the application requires custom events such as:

```text
Club Meeting
Seminar
Workshop
College Event
Personal Reminder
```

a separate:

```text
calendar_events
```

table can be introduced.

It is not required for the initial MVP.

---

# 43. Business Rules Outside the Database

Not every rule should be implemented as a database constraint.

Examples:

```text
Faculty is authorized to teach requested subject
Faculty is available during requested period
Borrowed period belongs to appropriate class
Assignment creator teaches the selected subject
Request receiver is the faculty assigned to the original period
```

These are primarily Service Layer rules.

Architecture:

```text
Repository
    ↓
Database Integrity

Service
    ↓
Business Rules
```

Both are necessary.

---

# 44. Transactional Operations

The following operation should be treated as transactional:

```text
Accept Period Request
        ↓
Update period_requests.status
        ↓
Create temporary_timetables record
        ↓
Create notification records
        ↓
COMMIT
```

If the temporary timetable cannot be created:

```text
ROLLBACK
```

This prevents:

```text
Request = ACCEPTED
Temporary Change = Missing
```

---

# 45. Assignment Creation Transaction

Potential flow:

```text
Create Assignment
        ↓
Insert assignments
        ↓
Insert attachment metadata
        ↓
Create notification records
        ↓
COMMIT
```

If the attachment metadata is mandatory and insertion fails, the transaction can be rolled back.

File storage itself may require separate cleanup handling because external storage is not automatically part of the MySQL transaction.

---

# 46. Timetable Publication

For a timetable publication:

```text
Create / Update Master Timetable
        ↓
Validate conflicts
        ↓
Commit
        ↓
Generate notifications
```

Notifications can be generated after the core timetable transaction succeeds.

---

# 47. Recommended Database Schema Flow

```text
USER
 ↓
PROFILE
 ↓
ACADEMIC STRUCTURE
 ↓
SUBJECT ALLOCATION
 ↓
TIMETABLE
 ↓
ASSIGNMENT / EXAM / PERIOD MANAGEMENT
 ↓
NOTIFICATION
```

This reflects the actual application architecture.

---

# 48. Schema Dependency Order

When creating the database, tables should be created in dependency order.

Recommended:

```text
1.  users
2.  departments
3.  academic_years
4.  semesters
5.  classes
6.  faculties
7.  students
8.  subjects
9.  periods
10. rooms
11. faculty_subjects
12. class_subjects
13. timetables
14. assignments
15. assignment_attachments
16. exams
17. exam_timetables
18. period_requests
19. temporary_timetables
20. notification_preferences
21. notifications
22. announcements
```

This order may be adjusted when final foreign-key dependencies are implemented.

---

# 49. Initial Seed Data

Development should eventually include seed data such as:

```text
1 Admin
2-5 Faculty
Several Students
1-3 Departments
Academic Year
Semesters
Classes
Subjects
Periods
Rooms
Sample Timetable
Sample Assignment
Sample Exam
```

Seed data will be created after the schema is finalized.

---

# 50. Schema Verification Checklist

Before SQL implementation, verify:

```text
[ ] All entities from entities.md are represented
[ ] All relationships from relationships.md are represented
[ ] ER diagram matches this schema
[ ] Primary keys are defined
[ ] Foreign keys are defined
[ ] Many-to-many relationships use mapping tables
[ ] Timetable master data is protected
[ ] Temporary timetable is linked to period request
[ ] Substitute logic is supported
[ ] Borrow logic is supported
[ ] Assignment attachments are supported
[ ] Exam timetable is supported
[ ] Notification channels are supported
[ ] WhatsApp is represented as a channel
[ ] Notification preferences are supported
[ ] Academic year separation is supported
[ ] Calendar can be derived
[ ] Historical records can be preserved
[ ] Schema is suitable for JDBC Repository Layer
```

---

# 51. Repository Mapping

The logical schema maps naturally to Java Repository classes.

```text
users
    ↓
UserRepository

students
    ↓
StudentRepository

faculties
    ↓
FacultyRepository

departments
    ↓
DepartmentRepository

classes
    ↓
ClassRepository

subjects
    ↓
SubjectRepository

faculty_subjects
    ↓
FacultySubjectRepository

class_subjects
    ↓
ClassSubjectRepository

periods
    ↓
PeriodRepository

rooms
    ↓
RoomRepository

timetables
    ↓
TimetableRepository

temporary_timetables
    ↓
TemporaryTimetableRepository

assignments
    ↓
AssignmentRepository

assignment_attachments
    ↓
AssignmentAttachmentRepository

exams
    ↓
ExamRepository

exam_timetables
    ↓
ExamTimetableRepository

period_requests
    ↓
PeriodRequestRepository

notifications
    ↓
NotificationRepository

notification_preferences
    ↓
NotificationPreferenceRepository

announcements
    ↓
AnnouncementRepository
```

---

# 52. Final Logical Architecture

```text
                         JSP / HTML / CSS
                                │
                                ↓
                           SERVLETS
                                │
                                ↓
                           SERVICES
                                │
                                ↓
                         REPOSITORIES
                                │
                                ↓
                              JDBC
                                │
                                ↓
                         ┌─────────────┐
                         │    MYSQL    │
                         └──────┬──────┘
                                │
        ┌───────────────────────┼───────────────────────┐
        ↓                       ↓                       ↓
     IDENTITY               ACADEMIC                OPERATIONS
        │                    STRUCTURE                    │
        │                       │                        │
        ↓                       ↓                        ↓
     USERS                 CLASSES / SUBJECTS      ASSIGNMENTS
     STUDENTS              FACULTY / PERIODS       EXAMS
     FACULTY               TIMETABLE                PERIOD REQUESTS
                                                   NOTIFICATIONS
                                                   ANNOUNCEMENTS
```

---

# 53. Final Schema Principles

1. MySQL is the relational database.
2. `users` is the central authentication table.
3. Student and faculty profiles are separated from authentication data.
4. Departments organize faculty, classes, and subjects.
5. Academic years and semesters provide academic context.
6. Many-to-many relationships use mapping tables.
7. The master timetable is separate from temporary changes.
8. Temporary timetable records originate from accepted period requests.
9. Substitute requests preserve the original subject.
10. Borrow requests allow the requesting faculty's subject.
11. Assignment deadlines are stored as `DATETIME`.
12. Master timetable uses `day_of_week`.
13. Temporary timetable uses an actual `date`.
14. Exam timetable stores date and time separately.
15. Assignment files use metadata and storage references.
16. Notifications belong to users.
17. Notification preferences belong to users.
18. Email, in-app, and WhatsApp are notification channels.
19. External provider credentials are never stored in normal database tables.
20. Calendar data is derived initially instead of duplicated.
21. Important operations use transactions.
22. Business rules remain in the Service Layer.
23. Database integrity is enforced with primary keys, foreign keys, unique constraints, and other constraints.
24. The schema is designed for the Repository Layer and JDBC.
25. The schema can later support REST APIs, mobile applications, and desktop applications.

---

# 54. Next Document

The next document is:

```text
table-structure.md
```

It will provide the detailed definition of every table:

```text
Table
Column
Data Type
Nullable
Default
Primary Key
Foreign Key
Unique
Description
```

After that:

```text
constraints.md
```

will define the exact database constraints before the final SQL implementation.
