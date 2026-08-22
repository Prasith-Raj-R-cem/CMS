# Database Indexes

## 1. Overview

This document defines the database indexes for the Campus Management System.

The indexes are designed around the actual operations performed by:

```text
Login
Student Dashboard
Faculty Dashboard
Admin Dashboard
Calendar
Timetable
Assignments
Exam Timetable
Period Management
Notifications
Announcements
```

Indexes improve read performance by allowing MySQL to locate relevant rows without scanning an entire table.

However:

```text
More indexes
    ↓
Faster reads
    +
More storage
    +
Slower INSERT / UPDATE / DELETE
```

Therefore, indexes should only be added where they support real queries.

---

# 2. Indexing Principles

## 2.1 Primary Keys

Every primary key automatically has an index.

Example:

```sql
PRIMARY KEY (id)
```

No additional index is required for:

```text
users.id
students.id
faculties.id
classes.id
...
```

---

## 2.2 Unique Constraints

A `UNIQUE` constraint normally creates a unique index automatically.

Examples:

```text
users.email
students.register_number
faculties.employee_id
subjects.subject_code
rooms.room_number
```

Do not create a second normal index on the same column unless there is a specific reason.

---

## 2.3 Foreign Keys

Foreign-key columns are frequently used in joins and lookups.

Important FK columns should have indexes.

Some MySQL configurations may automatically create required indexes for foreign keys, but we should define the intended indexes explicitly in the schema design.

---

# 3. Index Naming Convention

Use:

```text
idx_<table>_<columns>
```

Examples:

```text
idx_students_class
idx_assignments_deadline
idx_timetables_class_day_period
```

For unique indexes:

```text
uk_<table>_<columns>
```

Example:

```text
uk_users_email
```

Primary keys remain:

```text
PRIMARY
```

---

# 4. users Indexes

## Existing Unique Indexes

```text
PRIMARY KEY (id)
UNIQUE (email)
```

Recommended names:

```text
PRIMARY
uk_users_email
```

### Login Query

Typical query:

```sql
SELECT *
FROM users
WHERE email = ?;
```

The email unique index makes login lookup efficient.

---

# 5. departments Indexes

```text
PRIMARY KEY (id)
UNIQUE (department_code)
UNIQUE (department_name)
```

Recommended:

```text
PRIMARY
uk_departments_code
uk_departments_name
```

Department code will commonly be used by admin operations.

---

# 6. academic_years Indexes

```text
PRIMARY KEY (id)
UNIQUE (year_name)
```

Recommended:

```text
PRIMARY
uk_academic_years_name
```

Useful query:

```sql
SELECT *
FROM academic_years
WHERE status = 'ACTIVE';
```

A status-only index is not required initially because status normally has low selectivity.

---

# 7. semesters Indexes

Important queries:

```text
Find semesters of an academic year
Find a specific semester in an academic year
```

Recommended:

```text
PRIMARY KEY (id)

INDEX idx_semesters_academic_year
UNIQUE uk_semesters_year_number
```

Composite unique:

```text
academic_year_id
+
semester_number
```

Example:

```sql
CREATE UNIQUE INDEX uk_semesters_year_number
ON semesters (academic_year_id, semester_number);
```

---

# 8. classes Indexes

Important queries:

```text
Find students in a class
Find timetable for a class
Find assignments for a class
Find exams for a class
Find classes in a department
```

Recommended:

```text
PRIMARY KEY (id)

INDEX idx_classes_department
INDEX idx_classes_semester
INDEX idx_classes_academic_year

INDEX idx_classes_academic_context
```

Recommended composite index:

```text
(academic_year_id, semester_id, department_id)
```

---

# 9. students Indexes

Existing:

```text
PRIMARY KEY (id)
UNIQUE (user_id)
UNIQUE (register_number)
```

Important dashboard query:

```sql
SELECT *
FROM students
WHERE class_id = ?;
```

Recommended:

```text
idx_students_class
```

Therefore:

```sql
CREATE INDEX idx_students_class
ON students (class_id);
```

This is one of the most important indexes for the student dashboard.

---

# 10. faculties Indexes

Existing:

```text
PRIMARY KEY (id)
UNIQUE (user_id)
UNIQUE (employee_id)
```

Important query:

```sql
SELECT *
FROM faculties
WHERE department_id = ?;
```

Recommended:

```text
idx_faculties_department
```

---

# 11. subjects Indexes

Existing:

```text
PRIMARY KEY (id)
UNIQUE (subject_code)
```

Recommended:

```text
idx_subjects_department
idx_subjects_semester
```

These support:

```text
Find department subjects
Find semester subjects
```

Potential composite index:

```text
idx_subjects_department_semester
```

Use it if the application frequently queries both values together.

---

# 12. faculty_subjects Indexes

This is an important mapping table.

Common queries:

```text
Which subjects can this faculty teach?
Which faculty teaches this subject?
Which faculty teaches this subject in this semester?
```

Recommended:

```text
PRIMARY KEY (id)

UNIQUE (
    faculty_id,
    subject_id,
    academic_year_id,
    semester_id
)

INDEX idx_faculty_subjects_subject
INDEX idx_faculty_subjects_faculty_context
```

Recommended:

```text
idx_faculty_subjects_subject
    (subject_id)

idx_faculty_subjects_faculty_context
    (faculty_id, academic_year_id, semester_id)
```

---

# 13. class_subjects Indexes

Common queries:

```text
Which subjects belong to this class?
Which classes study this subject?
```

Recommended:

```text
PRIMARY KEY (id)

UNIQUE (
    class_id,
    subject_id,
    academic_year_id,
    semester_id
)

INDEX idx_class_subjects_subject
INDEX idx_class_subjects_class_context
```

Recommended:

```text
idx_class_subjects_subject
    (subject_id)

idx_class_subjects_class_context
    (class_id, academic_year_id, semester_id)
```

---

# 14. periods Indexes

Periods are a small lookup table.

Recommended:

```text
PRIMARY KEY (id)
UNIQUE (period_number)
```

No additional indexes are necessary initially.

Because the table is small, excessive indexing provides little benefit.

---

# 15. rooms Indexes

Existing:

```text
PRIMARY KEY (id)
UNIQUE (room_number)
```

Recommended:

```text
idx_rooms_status
```

only if the application frequently asks:

```text
Find available active rooms
```

For the initial project, this index can be optional.

---

# 16. timetables Indexes

This is one of the most important tables in the system.

The application will frequently ask:

```text
Student timetable
Faculty timetable
Class timetable
Room schedule
Daily timetable
Weekly timetable
Timetable conflict
```

Recommended indexes:

```text
PRIMARY KEY (id)

idx_timetables_class_schedule

idx_timetables_faculty_schedule

idx_timetables_room_schedule

idx_timetables_academic_context
```

---

# 17. Class Timetable Index

Student timetable queries will commonly look like:

```sql
SELECT *
FROM timetables
WHERE class_id = ?
  AND academic_year_id = ?
  AND semester_id = ?
ORDER BY day_of_week, period_id;
```

Recommended:

```text
idx_timetables_class_schedule
```

Columns:

```text
(class_id, academic_year_id, semester_id, day_of_week, period_id)
```

This is a high-value composite index.

---

# 18. Faculty Timetable Index

Faculty dashboard query:

```sql
SELECT *
FROM timetables
WHERE faculty_id = ?
  AND academic_year_id = ?
  AND semester_id = ?
ORDER BY day_of_week, period_id;
```

Recommended:

```text
idx_timetables_faculty_schedule
```

Columns:

```text
(faculty_id, academic_year_id, semester_id, day_of_week, period_id)
```

This supports faculty calendar/timetable views.

---

# 19. Room Timetable Index

Room conflict query:

```sql
SELECT *
FROM timetables
WHERE room_id = ?
  AND academic_year_id = ?
  AND semester_id = ?
  AND day_of_week = ?
  AND period_id = ?;
```

Recommended:

```text
idx_timetables_room_schedule
```

Columns:

```text
(room_id, academic_year_id, semester_id, day_of_week, period_id)
```

---

# 20. Timetable Subject Index

Useful queries:

```text
Find timetable entries for a subject
Find all periods where a subject is taught
```

Recommended:

```text
idx_timetables_subject
```

Columns:

```text
(subject_id)
```

This is optional initially because class/faculty schedule indexes may cover most application queries.

---

# 21. Temporary Timetables Indexes

This table is important for effective daily schedules.

Common queries:

```text
Find temporary changes for a class on a date
Find temporary changes for faculty on a date
Find temporary room changes
Find whether a specific period has been changed
```

Recommended:

```text
PRIMARY KEY (id)

UNIQUE (request_id)

idx_temp_timetable_class_date_period

idx_temp_timetable_faculty_date_period

idx_temp_timetable_room_date_period

idx_temp_timetable_original_date
```

---

# 22. Temporary Class Schedule Index

Recommended:

```text
idx_temp_timetable_class_date_period
```

Columns:

```text
(class_id, date, period_id)
```

Typical query:

```sql
SELECT *
FROM temporary_timetables
WHERE class_id = ?
  AND date = ?
  AND period_id = ?
  AND status = 'ACTIVE';
```

---

# 23. Temporary Faculty Schedule Index

Recommended:

```text
idx_temp_timetable_faculty_date_period
```

Columns:

```text
(faculty_id, date, period_id)
```

Used for:

```text
Faculty conflict checking
Faculty calendar
Substitute validation
Borrow validation
```

---

# 24. Temporary Room Schedule Index

Recommended:

```text
idx_temp_timetable_room_date_period
```

Columns:

```text
(room_id, date, period_id)
```

Used for:

```text
Room conflict checking
```

Because:

```text
room_id
```

may be NULL, only actual room assignments will benefit from this lookup.

---

# 25. Temporary Original Timetable Index

Recommended:

```text
idx_temp_timetable_original_date
```

Columns:

```text
(original_timetable_id, date)
```

This helps determine whether a specific master timetable period has a temporary override on a particular date.

---

# 26. assignments Indexes

Assignments are heavily used by the student dashboard and calendar.

Common queries:

```text
Assignments for a class
Upcoming deadlines
Assignments by subject
Assignments created by faculty
Assignments between two dates
```

Recommended:

```text
PRIMARY KEY (id)

idx_assignments_class_deadline

idx_assignments_faculty

idx_assignments_subject

idx_assignments_deadline
```

---

# 27. Assignment Class + Deadline Index

One of the most important queries:

```sql
SELECT *
FROM assignments
WHERE class_id = ?
  AND status = 'ACTIVE'
ORDER BY deadline;
```

Recommended:

```text
idx_assignments_class_deadline
```

Columns:

```text
(class_id, deadline)
```

This supports the student assignment dashboard.

---

# 28. Assignment Deadline Index

Calendar query:

```sql
SELECT *
FROM assignments
WHERE deadline BETWEEN ? AND ?
  AND status = 'ACTIVE'
ORDER BY deadline;
```

Recommended:

```text
idx_assignments_deadline
```

Column:

```text
(deadline)
```

This is especially useful for calendar date-range queries.

---

# 29. Assignment Faculty Index

Faculty dashboard:

```sql
SELECT *
FROM assignments
WHERE faculty_id = ?
ORDER BY created_at DESC;
```

Recommended:

```text
idx_assignments_faculty
```

Columns:

```text
(faculty_id, created_at)
```

---

# 30. Assignment Subject Index

Useful:

```text
Find assignments for a subject
```

Recommended:

```text
idx_assignments_subject
```

Columns:

```text
(subject_id)
```

This may be omitted if query volume is low.

---

# 31. assignment_attachments Indexes

Common query:

```sql
SELECT *
FROM assignment_attachments
WHERE assignment_id = ?;
```

Recommended:

```text
idx_assignment_attachments_assignment
```

Columns:

```text
(assignment_id)
```

---

# 32. exams Indexes

Common queries:

```text
Find exams for an academic year
Find exams for a semester
Find active exams
```

Recommended:

```text
idx_exams_academic_context
```

Columns:

```text
(academic_year_id, semester_id)
```

---

# 33. exam_timetables Indexes

This table supports exam calendar queries.

Common operations:

```text
Student exam timetable
Class exam timetable
Room schedule
Exam date lookup
Subject exam lookup
```

Recommended:

```text
idx_exam_timetables_class_date

idx_exam_timetables_subject

idx_exam_timetables_room_date

idx_exam_timetables_exam
```

---

# 34. Exam Class + Date Index

Student/class exam timetable:

```sql
SELECT *
FROM exam_timetables
WHERE class_id = ?
  AND exam_date BETWEEN ? AND ?
ORDER BY exam_date, start_time;
```

Recommended:

```text
idx_exam_timetables_class_date
```

Columns:

```text
(class_id, exam_date, start_time)
```

---

# 35. Exam Room + Date Index

Conflict detection:

```sql
SELECT *
FROM exam_timetables
WHERE room_id = ?
  AND exam_date = ?;
```

Recommended:

```text
idx_exam_timetables_room_date
```

Columns:

```text
(room_id, exam_date, start_time, end_time)
```

The Service Layer then checks time-range overlap.

---

# 36. Exam Subject Index

Useful query:

```text
Find exam schedule for a subject
```

Recommended:

```text
idx_exam_timetables_subject
```

Column:

```text
(subject_id)
```

---

# 37. Exam Index

Recommended:

```text
idx_exam_timetables_exam
```

Column:

```text
(exam_id)
```

Useful for:

```text
Load all timetable entries belonging to an exam
```

---

# 38. period_requests Indexes

This table is heavily used by faculty.

Common operations:

```text
Requests received by faculty
Requests sent by faculty
Pending requests
Requests for a date
Requests connected to a timetable
```

Recommended:

```text
idx_period_requests_receiver_status

idx_period_requests_requester_status

idx_period_requests_date

idx_period_requests_original_timetable

idx_period_requests_class_date_period
```

---

# 39. Received Requests Index

Faculty dashboard:

```sql
SELECT *
FROM period_requests
WHERE receiver_faculty_id = ?
  AND status = 'PENDING'
ORDER BY created_at DESC;
```

Recommended:

```text
idx_period_requests_receiver_status
```

Columns:

```text
(receiver_faculty_id, status, created_at)
```

---

# 40. Sent Requests Index

Requester dashboard:

```sql
SELECT *
FROM period_requests
WHERE requester_faculty_id = ?
ORDER BY created_at DESC;
```

Recommended:

```text
idx_period_requests_requester_status
```

Columns:

```text
(requester_faculty_id, status, created_at)
```

---

# 41. Request Date Index

Useful for:

```text
Find requests for a specific date
Find expired requests
Administrative scheduling view
```

Recommended:

```text
idx_period_requests_date
```

Column:

```text
(date)
```

---

# 42. Request Timetable Index

Useful query:

```sql
SELECT *
FROM period_requests
WHERE original_timetable_id = ?;
```

Recommended:

```text
idx_period_requests_original_timetable
```

Column:

```text
(original_timetable_id)
```

---

# 43. Request Class + Date + Period Index

Useful for conflict checks:

```text
class_id
+
date
+
period_id
```

Recommended:

```text
idx_period_requests_class_date_period
```

Columns:

```text
(class_id, date, period_id)
```

---

# 44. notifications Indexes

Notifications are frequently queried.

Common operations:

```text
My notifications
Unread notifications
Recent notifications
Notifications by channel
Notification delivery retry
```

Recommended:

```text
idx_notifications_user_read_created

idx_notifications_user_channel

idx_notifications_status_created
```

---

# 45. User Notification Index

Main notification query:

```sql
SELECT *
FROM notifications
WHERE user_id = ?
ORDER BY created_at DESC;
```

Recommended:

```text
idx_notifications_user_read_created
```

Columns:

```text
(user_id, read_status, created_at)
```

This supports:

```text
All notifications
Unread notifications
Recent notifications
```

---

# 46. Notification Channel Index

Useful for provider processing:

```sql
SELECT *
FROM notifications
WHERE user_id = ?
  AND channel = ?;
```

Recommended:

```text
idx_notifications_user_channel
```

Columns:

```text
(user_id, channel)
```

This may be omitted initially if notification queries are primarily user/read based.

---

# 47. Notification Delivery Index

Background notification processing may query:

```sql
SELECT *
FROM notifications
WHERE status = 'PENDING'
ORDER BY created_at;
```

Recommended:

```text
idx_notifications_status_created
```

Columns:

```text
(status, created_at)
```

This is important if notifications are processed asynchronously.

---

# 48. Notification Provider ID

If the application frequently checks delivery callbacks by:

```text
provider_message_id
```

add:

```text
idx_notifications_provider_message
```

or a unique index if the provider guarantees uniqueness.

For example:

```text
provider_message_id
```

can be used to match WhatsApp/email provider callbacks.

This index is optional for the initial MVP.

---

# 49. notification_preferences Indexes

Existing:

```text
UNIQUE (user_id)
```

This already provides efficient:

```sql
SELECT *
FROM notification_preferences
WHERE user_id = ?;
```

No additional index is required.

---

# 50. announcements Indexes

Common queries:

```text
Latest announcements
Published announcements
Announcements for students
Announcements for faculty
Department announcements
Class announcements
```

Recommended:

```text
idx_announcements_status_published

idx_announcements_creator

idx_announcements_target

```

---

# 51. Announcement Publication Index

Main query:

```sql
SELECT *
FROM announcements
WHERE status = 'PUBLISHED'
ORDER BY published_at DESC;
```

Recommended:

```text
idx_announcements_status_published
```

Columns:

```text
(status, published_at)
```

---

# 52. Announcement Creator Index

Admin query:

```sql
SELECT *
FROM announcements
WHERE created_by = ?
ORDER BY created_at DESC;
```

Recommended:

```text
idx_announcements_creator
```

Columns:

```text
(created_by, created_at)
```

---

# 53. Announcement Target Index

For targeted announcements:

```text
target_type
+
target_reference
```

Recommended:

```text
idx_announcements_target
```

Columns:

```text
(target_type, target_reference, status, published_at)
```

This supports queries such as:

```text
Department-specific announcements
Class-specific announcements
Semester-specific announcements
```

---

# 54. Calendar Query Strategy

The calendar does not have to query every table independently for every request.

A date range might contain:

```text
Timetable
Assignments
Exams
Temporary changes
Announcements
```

The Calendar Service can query each relevant table using indexed date/context fields.

Example:

```text
CalendarService
      │
      ├── TimetableRepository
      │
      ├── TemporaryTimetableRepository
      │
      ├── AssignmentRepository
      │
      ├── ExamTimetableRepository
      │
      └── AnnouncementRepository
```

Then combine results into a common calendar DTO.

---

# 55. Student Calendar Queries

Typical student request:

```text
Give me events for:
Class X
Date:
2026-09-01 → 2026-09-30
```

Queries use:

```text
timetables
temporary_timetables
assignments
exam_timetables
```

Important indexes:

```text
idx_timetables_class_schedule
idx_temp_timetable_class_date_period
idx_assignments_class_deadline
idx_assignments_deadline
idx_exam_timetables_class_date
```

---

# 56. Faculty Calendar Queries

Typical faculty request:

```text
Give me my schedule:
Faculty X
Date range
```

Important indexes:

```text
idx_timetables_faculty_schedule
idx_temp_timetable_faculty_date_period
idx_period_requests_receiver_status
idx_period_requests_requester_status
```

---

# 57. Admin Calendar Queries

Admin may request:

```text
Class schedule
Faculty schedule
Room schedule
Exam schedule
Temporary changes
```

Important indexes:

```text
class timetable index
faculty timetable index
room timetable index
temporary class index
temporary faculty index
temporary room index
exam room/date index
```

---

# 58. Login Query

Primary login query:

```sql
SELECT id, email, password_hash, role, status
FROM users
WHERE email = ?;
```

Uses:

```text
uk_users_email
```

No additional login index is required.

---

# 59. Student Dashboard Query

Typical:

```text
Find student
     ↓
Find class
     ↓
Find timetable
     ↓
Find assignments
     ↓
Find exams
     ↓
Find notifications
```

Important indexes:

```text
students.user_id
students.class_id

timetables.class_id + context
assignments.class_id + deadline
exam_timetables.class_id + exam_date
notifications.user_id + read_status + created_at
```

---

# 60. Faculty Dashboard Query

Typical:

```text
Find faculty
     ↓
Find timetable
     ↓
Find assignments
     ↓
Find received requests
     ↓
Find sent requests
     ↓
Find notifications
```

Important:

```text
faculties.user_id
timetables.faculty_id + context
assignments.faculty_id + created_at
period_requests.receiver_faculty_id + status
period_requests.requester_faculty_id + status
notifications.user_id + read_status + created_at
```

---

# 61. Admin Dashboard Query

Admin may query:

```text
Users
Departments
Classes
Faculty
Subjects
Timetable
Exams
Announcements
Period requests
```

Most of these tables are relatively small in a college deployment.

Do not create indexes for every admin filter without evidence.

---

# 62. Indexes for Foreign Keys

Core FK indexes:

```text
semesters.academic_year_id

classes.department_id
classes.semester_id
classes.academic_year_id

students.user_id
students.class_id

faculties.user_id
faculties.department_id

subjects.department_id
subjects.semester_id

faculty_subjects.faculty_id
faculty_subjects.subject_id
faculty_subjects.academic_year_id
faculty_subjects.semester_id

class_subjects.class_id
class_subjects.subject_id
class_subjects.academic_year_id
class_subjects.semester_id
```

Many of these are already covered by composite indexes.

Avoid adding redundant single-column indexes when a composite index already serves the leftmost query pattern.

---

# 63. Composite Index Rule

For an index:

```text
(A, B, C)
```

MySQL can efficiently use it for queries involving:

```text
A
A + B
A + B + C
```

but it generally cannot use the same index as efficiently for:

```text
B only
C only
```

Therefore index order must follow actual query patterns.

---

# 64. Example

Index:

```text
idx_timetables_class_schedule

(class_id, academic_year_id, semester_id, day_of_week, period_id)
```

Excellent for:

```text
class_id
class_id + academic_year_id
class_id + academic_year_id + semester_id
class schedule by day/period
```

Not a replacement for:

```text
faculty_id
```

queries.

Therefore the faculty schedule index is separate.

---

# 65. Avoid Redundant Indexes

Do not create:

```text
idx_assignments_class
idx_assignments_class_deadline
```

if the application mainly queries:

```text
class_id + deadline
```

because:

```text
(class_id, deadline)
```

can already support queries beginning with:

```text
class_id
```

Similarly:

```text
(class_id, academic_year_id, semester_id, day_of_week, period_id)
```

may make a separate:

```text
(class_id)
```

unnecessary.

---

# 66. Low-Selectivity Columns

Avoid indexing columns such as:

```text
status
role
read_status
boolean settings
```

alone unless profiling proves the index is useful.

Example:

```text
status = ACTIVE
```

may match most rows.

A composite index is often more useful:

```text
(user_id, read_status, created_at)
```

rather than:

```text
(read_status)
```

---

# 67. Indexing Dates

Date/time columns are important for:

```text
calendar
deadlines
exams
temporary timetable
requests
notifications
```

Use indexes that start with the relevant entity/context where possible.

Examples:

```text
(class_id, deadline)

(class_id, exam_date)

(class_id, date, period_id)

(status, created_at)
```

---

# 68. Date Range Query Rule

For:

```sql
WHERE deadline BETWEEN ? AND ?
```

an index beginning with:

```text
deadline
```

can be useful.

For class-specific deadlines:

```text
(class_id, deadline)
```

is usually better.

---

# 69. Indexes and ORDER BY

Indexes can also help sorting.

Example:

```sql
SELECT *
FROM assignments
WHERE class_id = ?
ORDER BY deadline;
```

Index:

```text
(class_id, deadline)
```

can support both filtering and ordering.

This is why the assignment class/deadline index is preferred over separate indexes.

---

# 70. Indexes and Conflict Checking

Conflict checking is a core timetable requirement.

### Class

```text
(class_id, date/day, period_id)
```

### Faculty

```text
(faculty_id, date/day, period_id)
```

### Room

```text
(room_id, date/day, period_id)
```

For master timetable:

```text
day_of_week
```

is used.

For temporary timetable:

```text
date
```

is used.

---

# 71. Master vs Temporary Index Strategy

```text
MASTER TIMETABLE
day_of_week
        ↓
Weekly recurring schedule


TEMPORARY TIMETABLE
date
        ↓
Specific calendar-date override
```

Therefore their indexes intentionally use different date fields.

---

# 72. Suggested Initial Index Set

For the MVP, the following should be considered the core index set:

```text
users
├── PRIMARY
└── uk_users_email

departments
├── PRIMARY
├── uk_departments_code
└── uk_departments_name

academic_years
├── PRIMARY
└── uk_academic_years_name

semesters
├── PRIMARY
└── uk_semesters_year_number

classes
├── PRIMARY
└── idx_classes_academic_context

students
├── PRIMARY
├── uk_students_user
├── uk_students_register
└── idx_students_class

faculties
├── PRIMARY
├── uk_faculties_user
├── uk_faculties_employee
└── idx_faculties_department

subjects
├── PRIMARY
├── uk_subjects_code
├── idx_subjects_department
└── idx_subjects_semester

faculty_subjects
├── PRIMARY
├── uk_faculty_subject_context
├── idx_faculty_subjects_subject
└── idx_faculty_subjects_faculty_context

class_subjects
├── PRIMARY
├── uk_class_subject_context
├── idx_class_subjects_subject
└── idx_class_subjects_class_context

periods
├── PRIMARY
└── uk_periods_number

rooms
├── PRIMARY
└── uk_rooms_number

timetables
├── PRIMARY
├── idx_timetables_class_schedule
├── idx_timetables_faculty_schedule
└── idx_timetables_room_schedule

temporary_timetables
├── PRIMARY
├── uk_temp_timetable_request
├── idx_temp_class_date_period
├── idx_temp_faculty_date_period
├── idx_temp_room_date_period
└── idx_temp_original_date

assignments
├── PRIMARY
├── idx_assignments_class_deadline
├── idx_assignments_faculty_created
└── idx_assignments_deadline

assignment_attachments
├── PRIMARY
└── idx_assignment_attachments_assignment

exams
├── PRIMARY
└── idx_exams_academic_context

exam_timetables
├── PRIMARY
├── idx_exam_timetables_class_date
├── idx_exam_timetables_room_date
└── idx_exam_timetables_exam

period_requests
├── PRIMARY
├── idx_period_requests_receiver_status
├── idx_period_requests_requester_status
├── idx_period_requests_date
├── idx_period_requests_original_timetable
└── idx_period_requests_class_date_period

notifications
├── PRIMARY
├── idx_notifications_user_read_created
└── idx_notifications_status_created

notification_preferences
├── PRIMARY
└── uk_notification_preferences_user

announcements
├── PRIMARY
├── idx_announcements_status_published
├── idx_announcements_creator
└── idx_announcements_target
```

---

# 73. Index Count Principle

The initial database should not contain dozens of speculative indexes.

Start with:

```text
Required unique indexes
+
Important foreign-key indexes
+
High-frequency query indexes
+
Conflict-checking indexes
```

Then measure actual queries.

If later the application becomes large:

```text
EXPLAIN
EXPLAIN ANALYZE
slow query logs
query profiling
```

can be used to optimize indexes.

---

# 74. Index Testing

After creating the schema, test important queries with:

```sql
EXPLAIN SELECT ...
```

Look for:

```text
key
possible_keys
rows
type
```

A good query plan should avoid unnecessary full-table scans on large tables.

---

# 75. Index Maintenance

Indexes do not require manual maintenance for normal CRUD operations.

MySQL updates indexes automatically.

However:

```text
Too many indexes
```

increase write cost.

Therefore whenever a new index is proposed:

```text
1. Identify query
2. Check existing indexes
3. Use EXPLAIN
4. Add index only if useful
```

---

# 76. Repository Query → Index Mapping

## UserRepository

```text
findByEmail()
    ↓
uk_users_email
```

## StudentRepository

```text
findByUserId()
    ↓
uk_students_user

findByClassId()
    ↓
idx_students_class
```

## FacultyRepository

```text
findByUserId()
    ↓
uk_faculties_user

findByDepartmentId()
    ↓
idx_faculties_department
```

## TimetableRepository

```text
findByClass()
    ↓
idx_timetables_class_schedule

findByFaculty()
    ↓
idx_timetables_faculty_schedule

findByRoom()
    ↓
idx_timetables_room_schedule
```

## AssignmentRepository

```text
findByClass()
    ↓
idx_assignments_class_deadline

findUpcoming()
    ↓
idx_assignments_deadline
```

## PeriodRequestRepository

```text
findReceivedPending()
    ↓
idx_period_requests_receiver_status

findSent()
    ↓
idx_period_requests_requester_status
```

## NotificationRepository

```text
findByUser()
    ↓
idx_notifications_user_read_created

findPendingDelivery()
    ↓
idx_notifications_status_created
```

---

# 77. Index Design and Repository Layer

This is why the Repository Layer is important.

The Repository defines the actual query patterns:

```text
Repository Query
      ↓
WHERE / JOIN / ORDER BY
      ↓
Index Design
      ↓
MySQL Query Planner
```

Therefore, after we implement the Repository classes, we should revisit the indexes using the actual SQL queries.

---

# 78. Index Design and Future APIs

The future system may expose:

```text
JSP Web
REST API
Mobile App
Desktop Application
```

All of them can use the same Repository/Service architecture.

Therefore indexes should be designed around:

```text
business queries
```

rather than:

```text
JSP pages
```

This allows the database to remain useful when the frontend changes.

---

# 79. Important Warning

Do not assume:

```text
Every foreign key = separate index
```

and do not assume:

```text
Every WHERE column = index
```

The correct process is:

```text
Identify query
      ↓
Check existing index
      ↓
Check column order
      ↓
Use EXPLAIN
      ↓
Add/modify index
```

---

# 80. Final Index Principles

1. Primary keys are automatically indexed.
2. Unique constraints create unique indexes.
3. Foreign keys should have appropriate indexes.
4. Composite indexes should follow real query patterns.
5. Column order matters in composite indexes.
6. Class timetable queries need class-first indexes.
7. Faculty timetable queries need faculty-first indexes.
8. Room conflict queries need room-first indexes.
9. Temporary timetable queries need date-aware indexes.
10. Assignment dashboards need class/deadline indexes.
11. Calendar queries need date indexes.
12. Exam calendars need class/date indexes.
13. Period requests need requester/receiver/status indexes.
14. Notifications need user/read/time indexes.
15. Notification processing needs status/time indexes.
16. Targeted announcements need target indexes.
17. Low-selectivity columns should generally not be indexed alone.
18. Avoid redundant indexes.
19. Use `EXPLAIN` to verify important queries.
20. Revisit index design after Repository SQL is implemented.
21. Indexes improve reads but increase write overhead.
22. The initial schema should prioritize important application queries.
23. Indexes should support business operations, not individual UI pages.
24. Database performance optimization should be evidence-driven.

---

# 81. Final Database Design Progress

```text
03-database-design/
│
├── database-overview.md       ✓
├── entities.md                ✓
├── relationships.md           ✓
├── er-diagram.md              ✓
├── database-schema.md         ✓
├── table-structure.md         ✓
├── constraints.md             ✓
└── indexes.md                 ✓
```

The conceptual and logical database design is now complete.