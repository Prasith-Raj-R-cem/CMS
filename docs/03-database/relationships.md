# Database Relationships

## 1. Overview

This document defines the relationships between the entities identified in `entities.md`.

The purpose is to determine:

- One-to-One relationships
- One-to-Many relationships
- Many-to-Many relationships
- Foreign keys
- Junction/mapping tables
- Optional relationships
- Timetable relationships
- Period-request relationships
- Notification relationships

These relationships will be used to create the ER diagram and final database schema.

---

# 2. Relationship Notation

The following notation is used:

```text
1 : 1   → One-to-One
1 : N   → One-to-Many
N : 1   → Many-to-One
N : N   → Many-to-Many
```

Example:

```text
Department 1 ───── N Faculty
```

means:

> One department can have many faculty members, while each faculty member belongs to one department.

---

# 3. Complete Relationship Overview

```text
USER
│
├── 1 : 1 ── STUDENT
│
├── 1 : 1 ── FACULTY
│
└── 1 : 1 ── ADMIN PROFILE (OPTIONAL)

DEPARTMENT
│
├── 1 : N ── FACULTY
├── 1 : N ── CLASS
└── 1 : N ── SUBJECT

ACADEMIC YEAR
│
├── 1 : N ── SEMESTER
├── 1 : N ── CLASS
├── 1 : N ── FACULTY-SUBJECT
├── 1 : N ── CLASS-SUBJECT
├── 1 : N ── TIMETABLE
└── 1 : N ── EXAM

SEMESTER
│
├── 1 : N ── CLASS
├── 1 : N ── SUBJECT
└── 1 : N ── TIMETABLE

CLASS
│
├── 1 : N ── STUDENT
├── N : N ── SUBJECT
├── 1 : N ── TIMETABLE
├── 1 : N ── ASSIGNMENT
└── 1 : N ── EXAM TIMETABLE

FACULTY
│
├── N : N ── SUBJECT
├── 1 : N ── TIMETABLE
├── 1 : N ── ASSIGNMENT
├── 1 : N ── PERIOD REQUEST
└── 1 : N ── TEMPORARY TIMETABLE

SUBJECT
│
├── N : N ── FACULTY
├── N : N ── CLASS
├── 1 : N ── TIMETABLE
├── 1 : N ── ASSIGNMENT
└── 1 : N ── EXAM TIMETABLE

PERIOD
│
└── 1 : N ── TIMETABLE

TIMETABLE
│
├── 1 : N ── PERIOD REQUEST
└── 1 : N / 0..N ── TEMPORARY TIMETABLE

ASSIGNMENT
│
└── 1 : N ── ASSIGNMENT ATTACHMENT

EXAM
│
└── 1 : N ── EXAM TIMETABLE

USER
│
├── 1 : N ── NOTIFICATION
└── 1 : 1 ── NOTIFICATION PREFERENCE

ADMIN
│
└── 1 : N ── ANNOUNCEMENT
```

---

# 4. User → Student

## Relationship

```text
User 1 ───── 0..1 Student
```

A user account can optionally have one student profile.

The student profile must belong to exactly one user.

```text
users.id
    ↓
students.user_id
```

## Why?

Authentication information should remain separate from academic information.

```text
users
├── email
├── password_hash
└── role

students
├── register_number
├── class_id
└── admission_year
```

---

# 5. User → Faculty

## Relationship

```text
User 1 ───── 0..1 Faculty
```

A user account can optionally have one faculty profile.

```text
users.id
    ↓
faculties.user_id
```

A faculty profile must belong to one user account.

---

# 6. User → Admin

For the initial system, a separate Admin table is not required.

Admin can be represented using:

```text
users.role = ADMIN
```

Therefore:

```text
User
  │
  └── role = ADMIN
```

A separate `admins` table may be introduced only if administrator-specific profile information is required.

---

# 7. Department → Faculty

## Relationship

```text
Department 1 ───── N Faculty
```

One department can contain many faculty members.

Each faculty member normally belongs to one department.

```text
departments.id
      ↓
faculties.department_id
```

Example:

```text
CSE Department
    │
    ├── Faculty A
    ├── Faculty B
    └── Faculty C
```

---

# 8. Department → Class

## Relationship

```text
Department 1 ───── N Class
```

One department can have many classes.

Each class belongs to one department.

```text
departments.id
      ↓
classes.department_id
```

Example:

```text
CSE
│
├── S2 CSE
├── S3 CSE
└── S4 CSE
```

---

# 9. Department → Subject

## Relationship

```text
Department 1 ───── N Subject
```

One department can manage multiple subjects.

```text
departments.id
      ↓
subjects.department_id
```

The exact ownership of interdisciplinary subjects can be handled later if required.

---

# 10. Academic Year → Semester

## Relationship

```text
AcademicYear 1 ───── N Semester
```

One academic year can contain multiple semester records.

Example:

```text
2026-2027
│
├── S1
├── S2
├── S3
├── S4
└── ...
```

```text
academic_years.id
        ↓
semesters.academic_year_id
```

---

# 11. Academic Year → Class

## Relationship

```text
AcademicYear 1 ───── N Class
```

A class instance belongs to a particular academic year.

Example:

```text
2026-2027
   │
   ├── S2 CSE
   ├── S2 ECE
   └── S2 EEE
```

This allows the same logical class structure to exist across different academic years without mixing records.

---

# 12. Semester → Class

## Relationship

```text
Semester 1 ───── N Class
```

A semester can contain multiple class groups.

Example:

```text
S2
│
├── S2 CSE
├── S2 ECE
└── S2 EEE
```

---

# 13. Class → Student

## Relationship

```text
Class 1 ───── N Student
```

One class can contain many students.

Each student belongs to one class at a time in the current model.

```text
classes.id
    ↓
students.class_id
```

Example:

```text
S2 CSE
│
├── Student A
├── Student B
├── Student C
└── Student D
```

Historical class changes can be supported later if required.

---

# 14. Class ↔ Subject

## Relationship

```text
Class N ───── N Subject
```

A class has multiple subjects.

A subject may be taught to multiple classes.

Therefore, a mapping table is required:

```text
class_subjects
```

Relationship:

```text
Class
  │
  └── class_subjects ── Subject
```

Conceptually:

```text
classes.id
      ↓
class_subjects.class_id

subjects.id
      ↓
class_subjects.subject_id
```

---

# 15. Faculty ↔ Subject

## Relationship

```text
Faculty N ───── N Subject
```

A faculty member can teach multiple subjects.

A subject can be taught by multiple faculty members.

Therefore:

```text
faculty_subjects
```

is used as the mapping table.

```text
Faculty
   │
   └── faculty_subjects ── Subject
```

This relationship is important for:

- Assignment authorization
- Timetable validation
- Borrow-period validation
- Faculty workload
- Subject allocation

---

# 16. FacultySubject → Academic Year

## Relationship

```text
AcademicYear 1 ───── N FacultySubject
```

A faculty-subject assignment may change between academic years.

Example:

```text
2026-2027
Faculty A → OOP

2027-2028
Faculty A → Data Structures
```

This prevents old academic assignments from being confused with current assignments.

---

# 17. ClassSubject → Academic Year

## Relationship

```text
AcademicYear 1 ───── N ClassSubject
```

The subjects associated with a class can change between academic years.

Therefore:

```text
class_subjects.academic_year_id
```

can preserve the academic context.

---

# 18. Period → Timetable

## Relationship

```text
Period 1 ───── N Timetable
```

A period definition can be reused across many timetable entries.

Example:

```text
Period 3
10:00 - 11:00
```

can be used by:

```text
S2 CSE Monday
S2 CSE Tuesday
S3 CSE Monday
...
```

---

# 19. Class → Timetable

## Relationship

```text
Class 1 ───── N Timetable
```

A class has many timetable entries.

```text
classes.id
    ↓
timetables.class_id
```

---

# 20. Faculty → Timetable

## Relationship

```text
Faculty 1 ───── N Timetable
```

A faculty member can have many scheduled periods.

```text
faculties.id
    ↓
timetables.faculty_id
```

This relationship is used to construct the faculty calendar.

---

# 21. Subject → Timetable

## Relationship

```text
Subject 1 ───── N Timetable
```

A subject can appear in many timetable periods.

```text
subjects.id
    ↓
timetables.subject_id
```

---

# 22. Academic Context → Timetable

A timetable entry belongs to an academic context.

Conceptually:

```text
Academic Year
      ↓
Semester
      ↓
Class
      ↓
Timetable
```

The timetable should contain the required academic foreign keys or derive them through its class/academic relationships according to the final schema.

The final schema should avoid unnecessary duplicate academic references if they can be reliably derived.

---

# 23. Timetable Uniqueness

A class should normally not have two subjects in the same:

```text
Day + Period + Academic Context
```

Conceptually:

```text
Class + Day + Period + Academic Year + Semester
```

should be unique for the master timetable.

Example:

```text
S2 CSE + Monday + Period 3
```

cannot contain both:

```text
OOP
```

and:

```text
Data Structures
```

at the same time.

The exact database constraint will be defined in `constraints.md`.

---

# 24. Faculty Timetable Conflict

A faculty member should not be assigned to multiple classes at the same time.

Conceptually:

```text
Faculty + Day + Period + Academic Context
```

should not conflict.

Example:

```text
Faculty A
Monday
Period 3
```

cannot simultaneously teach:

```text
S2 CSE
```

and:

```text
S3 CSE
```

The database constraints and service-level validation will work together.

---

# 25. Room → Timetable

If the recommended `Room` entity is included:

```text
Room 1 ───── N Timetable
```

A room can be used in many periods across different days.

However:

```text
Room + Day + Period + Academic Context
```

must not have conflicting timetable entries.

---

# 26. Room → ExamTimetable

```text
Room 1 ───── N ExamTimetable
```

A room can host many examinations at different times.

Conflicts should be prevented.

---

# 27. Timetable → PeriodRequest

## Relationship

```text
Timetable 1 ───── N PeriodRequest
```

A master timetable entry can be involved in multiple requests over time.

Example:

```text
Monday Period 3
Data Structures
Faculty A
```

may have:

```text
Request 1 → Substitute
Request 2 → Borrow
```

depending on institutional rules.

However, only one conflicting approved temporary change should be active for a given period.

---

# 28. Faculty → PeriodRequest

A faculty member can participate in requests in two different roles:

```text
Requester
Receiver
```

Therefore, the `PeriodRequest` table should contain two foreign keys:

```text
requester_faculty_id
receiver_faculty_id
```

Relationships:

```text
Faculty 1 ───── N PeriodRequest
          requester

Faculty 1 ───── N PeriodRequest
          receiver
```

This is a key relationship.

---

# 29. Subject → PeriodRequest

A period request may reference both:

```text
Original Subject
Requested Subject
```

Therefore:

```text
original_subject_id
requested_subject_id
```

can reference:

```text
subjects.id
```

This is necessary because substitute and borrow requests have different subject behavior.

---

# 30. Substitute Request Relationships

For:

```text
request_type = SUBSTITUTE
```

the relationships are:

```text
Requester Faculty
       ↓
PeriodRequest
       ↓
Receiver Faculty

Original Subject
       ↓
PeriodRequest
       ↓
Requested Subject
```

Business rule:

```text
original_subject_id
=
requested_subject_id
```

The receiving faculty teaches the original subject.

---

# 31. Borrow Request Relationships

For:

```text
request_type = BORROW
```

the relationships are:

```text
Requester Faculty
       ↓
PeriodRequest
       ↓
Receiver Faculty

Original Subject
       ↓
PeriodRequest

Requested Subject
       ↓
PeriodRequest
```

Business rule:

```text
requested_subject_id
=
requester's authorized subject
```

The borrowing faculty teaches their own subject during the borrowed period.

---

# 32. PeriodRequest → TemporaryTimetable

## Relationship

```text
PeriodRequest 1 ───── 0..1 TemporaryTimetable
```

A request can result in zero or one temporary timetable record.

```text
PENDING
   ↓
No temporary record

REJECTED
   ↓
No temporary record

ACCEPTED
   ↓
Temporary timetable created
```

This is one of the most important relationships in the system.

---

# 33. Original Timetable → TemporaryTimetable

A temporary timetable should retain a reference to the original timetable entry.

```text
Timetable 1 ───── N TemporaryTimetable
```

Possible foreign key:

```text
temporary_timetables.original_timetable_id
```

This allows the system to determine:

```text
What was the original schedule?
What changed?
Who was originally assigned?
What is currently active?
```

---

# 34. TemporaryTimetable → Class

```text
Class 1 ───── N TemporaryTimetable
```

A class can have multiple temporary changes over time.

The temporary record applies only to the relevant date/period.

---

# 35. TemporaryTimetable → Faculty

A temporary timetable identifies the faculty member who actually teaches the period.

```text
Faculty 1 ───── N TemporaryTimetable
```

The temporary faculty may differ from the master timetable faculty.

---

# 36. TemporaryTimetable → Subject

A temporary timetable identifies the subject being taught during the temporary change.

```text
Subject 1 ───── N TemporaryTimetable
```

This allows:

```text
SUBSTITUTE
→ Same subject, different faculty

BORROW
→ Different subject, different faculty
```

---

# 37. Assignment → Class

## Relationship

```text
Class 1 ───── N Assignment
```

A class can receive many assignments.

Each assignment targets one class in the current model.

```text
assignments.class_id
```

---

# 38. Assignment → Subject

```text
Subject 1 ───── N Assignment
```

A subject can have many assignments.

Each assignment belongs to one subject.

---

# 39. Faculty → Assignment

```text
Faculty 1 ───── N Assignment
```

A faculty member can create many assignments.

Each assignment has one creating faculty member.

```text
assignments.faculty_id
```

Authorization should verify that the faculty member is allowed to create assignments for that subject/class.

---

# 40. Assignment → AssignmentAttachment

## Relationship

```text
Assignment 1 ───── N AssignmentAttachment
```

One assignment can have zero or many attachments.

Example:

```text
Assignment
│
├── question.pdf
├── diagram.png
└── reference.pdf
```

---

# 41. Assignment → Calendar

No direct foreign key is required initially.

The calendar can derive events from:

```text
Assignment.deadline
```

Conceptually:

```text
Assignment
   ↓
Deadline
   ↓
Calendar Event
```

This avoids duplicating deadline information.

---

# 42. Exam → ExamTimetable

## Relationship

```text
Exam 1 ───── N ExamTimetable
```

An exam definition can have multiple timetable entries.

Example:

```text
University Examination
│
├── Mathematics
├── Physics
└── Data Structures
```

The exact design can be simplified if one exam timetable table is sufficient for the mini-project.

---

# 43. Class → ExamTimetable

```text
Class 1 ───── N ExamTimetable
```

A class can have many examination timetable entries.

---

# 44. Subject → ExamTimetable

```text
Subject 1 ───── N ExamTimetable
```

A subject can appear in multiple examination schedules across classes/semesters.

---

# 45. User → Notification

## Relationship

```text
User 1 ───── N Notification
```

A user can receive many notifications.

```text
users.id
    ↓
notifications.user_id
```

Examples:

```text
New Assignment
Deadline Reminder
Timetable Change
Period Request
Exam Timetable
Announcement
```

---

# 46. User → NotificationPreference

## Relationship

```text
User 1 ───── 1 NotificationPreference
```

Each user should have one primary notification-preference record.

Example:

```text
User
│
└── NotificationPreference
      ├── in_app_enabled
      ├── email_enabled
      └── whatsapp_enabled
```

A preference record may be created when the user account is created.

---

# 47. Notification → Event Source

The notification can reference the event type.

Example:

```text
event_type = ASSIGNMENT_CREATED
```

A notification may also need a source/reference identifier.

Conceptually:

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
source_id = 55
```

This can allow the notification to link back to the relevant system object.

The final polymorphic-reference strategy will be decided in `database-schema.md`.

---

# 48. Admin → Announcement

## Relationship

```text
User/Admin 1 ───── N Announcement
```

The creator should reference the administrator's user account.

```text
announcements.created_by
        ↓
users.id
```

The application must verify that the creator has the ADMIN role.

---

# 49. Announcement → Notification

There does not need to be a direct foreign key from Announcement to Notification.

Instead:

```text
Announcement Published
        ↓
NotificationService
        ↓
Notification records
```

This keeps notification delivery independent from announcement storage.

---

# 50. Calendar Relationships

The calendar is mainly a **derived view**, not necessarily a single physical database table.

Calendar data can come from:

```text
Assignment
    ↓
Deadline

ExamTimetable
    ↓
Exam Date

Timetable
    ↓
Regular Periods

TemporaryTimetable
    ↓
Temporary Changes

PeriodRequest
    ↓
Pending Request / Faculty Calendar
```

---

# 51. Student Calendar

The student calendar can combine:

```text
Assignment Deadlines
Exam Timetable
Regular Timetable
Temporary Timetable
Announcements
```

Conceptually:

```text
Database
   │
   ├── Assignments
   ├── Exams
   ├── Timetable
   ├── Temporary Timetable
   └── Announcements
            ↓
       CalendarService
            ↓
       Student Calendar
```

---

# 52. Faculty Calendar

The faculty calendar can combine:

```text
Regular Teaching Periods
Temporary Teaching Periods
Sent Period Requests
Received Period Requests
Exam Duties (if added later)
```

Conceptually:

```text
Timetable
TemporaryTimetable
PeriodRequest
       ↓
Faculty Calendar
```

---

# 53. Effective Timetable Relationship

The effective timetable is derived from:

```text
Timetable
    +
TemporaryTimetable
```

For a specific:

```text
Class
Date / Day
Period
Academic Context
```

the system should determine whether an active temporary timetable exists.

If yes:

```text
Temporary Timetable
```

is shown.

Otherwise:

```text
Master Timetable
```

is shown.

---

# 54. Substitute Effective Schedule

Example:

```text
MASTER
────────────────────────────
Class: S2 CSE
Monday
Period 3
Subject: Data Structures
Faculty: Faculty A


TEMPORARY
────────────────────────────
Class: S2 CSE
Date: 21-09-2026
Period: 3
Subject: Data Structures
Faculty: Faculty B
Type: SUBSTITUTE
```

Student sees:

```text
Monday, 21-09-2026
Period 3
Data Structures
Faculty B
```

---

# 55. Borrow Effective Schedule

Example:

```text
MASTER
────────────────────────────
Class: S2 CSE
Monday
Period 3
Subject: Data Structures
Faculty: Faculty A


TEMPORARY
────────────────────────────
Class: S2 CSE
Date: 21-09-2026
Period: 3
Subject: OOP
Faculty: Faculty B
Type: BORROW
```

Student sees:

```text
Monday, 21-09-2026
Period 3
OOP
Faculty B
```

---

# 56. Assignment Notification Relationship

The relationship is event-driven rather than a direct assignment-to-notification foreign key.

```text
Assignment
   ↓
Assignment Created
   ↓
NotificationService
   ↓
Find Students in Class
   ↓
User
   ↓
Notification
```

One assignment may therefore generate many notifications.

Conceptually:

```text
Assignment 1 ───── N Notification
```

but this does not necessarily need to be represented as a direct foreign key if a generic event-reference system is used.

---

# 57. Exam Notification Relationship

Similarly:

```text
ExamTimetable
   ↓
Published
   ↓
NotificationService
   ↓
Users
   ↓
Notifications
```

A single exam timetable publication may generate many notification records.

---

# 58. Period Request Notification Relationship

```text
PeriodRequest
   ↓
Request Created
   ↓
NotificationService
   ↓
Receiver User
   ↓
Notification
```

When accepted:

```text
PeriodRequest
   ↓
Accepted
   ↓
NotificationService
   ↓
Requester User
   ↓
Notification
```

---

# 59. Temporary Timetable Notification Relationship

When an approved temporary change affects a class:

```text
TemporaryTimetable
        ↓
NotificationService
        ↓
Students in Class
        ↓
Notifications
```

Affected faculty can also receive notifications.

---

# 60. Faculty Subject Validation Relationship

For borrow-period functionality:

```text
Requester Faculty
       ↓
FacultySubject
       ↓
Requested Subject
```

The system should verify:

```text
Faculty B
   ↓
Authorized to teach OOP?
```

If:

```text
YES → Request can proceed
NO  → Request rejected
```

This is primarily a Service Layer business rule supported by the database relationship.

---

# 61. Class Subject Validation Relationship

For assignments:

```text
Assignment
   ↓
Class
   ↓
ClassSubject
   ↓
Subject
```

The system should verify that the selected subject belongs to the class's academic subject structure.

---

# 62. Timetable Validation Relationships

Before creating a timetable entry:

```text
Class
Subject
Faculty
Period
Room
Academic Context
```

must be validated.

Conceptually:

```text
Class ───── Subject
  │           │
  │           │
  └─────┬─────┘
        ↓
     Timetable
        ↑
        │
Faculty ───── Period
        │
        ↓
       Room
```

---

# 63. Period Request Validation Relationships

Before submitting a request:

```text
Requester Faculty
       ↓
Own Timetable
       ↓
Selected Date + Period
       ↓
Target Faculty
       ↓
Target Period
       ↓
Requested Subject
```

The Service Layer validates all relevant relationships before inserting the request.

---

# 64. Relationship Cardinality Summary

| Relationship | Cardinality | Implementation |
|---|---|---|
| User → Student | 1 : 0..1 | FK |
| User → Faculty | 1 : 0..1 | FK |
| Department → Faculty | 1 : N | FK |
| Department → Class | 1 : N | FK |
| Department → Subject | 1 : N | FK |
| AcademicYear → Semester | 1 : N | FK |
| AcademicYear → Class | 1 : N | FK |
| Semester → Class | 1 : N | FK |
| Class → Student | 1 : N | FK |
| Class ↔ Subject | N : N | `class_subjects` |
| Faculty ↔ Subject | N : N | `faculty_subjects` |
| Period → Timetable | 1 : N | FK |
| Class → Timetable | 1 : N | FK |
| Faculty → Timetable | 1 : N | FK |
| Subject → Timetable | 1 : N | FK |
| Room → Timetable | 1 : N | FK |
| Timetable → PeriodRequest | 1 : N | FK |
| Faculty → PeriodRequest (requester) | 1 : N | FK |
| Faculty → PeriodRequest (receiver) | 1 : N | FK |
| PeriodRequest → TemporaryTimetable | 1 : 0..1 | FK |
| Timetable → TemporaryTimetable | 1 : N | FK |
| Class → TemporaryTimetable | 1 : N | FK |
| Faculty → TemporaryTimetable | 1 : N | FK |
| Subject → TemporaryTimetable | 1 : N | FK |
| Class → Assignment | 1 : N | FK |
| Subject → Assignment | 1 : N | FK |
| Faculty → Assignment | 1 : N | FK |
| Assignment → Attachment | 1 : N | FK |
| Exam → ExamTimetable | 1 : N | FK |
| Class → ExamTimetable | 1 : N | FK |
| Subject → ExamTimetable | 1 : N | FK |
| Room → ExamTimetable | 1 : N | FK |
| User → Notification | 1 : N | FK |
| User → NotificationPreference | 1 : 1 | FK + UNIQUE |
| User/Admin → Announcement | 1 : N | FK |

---

# 65. Core Foreign Key Map

The important foreign keys currently planned are:

```text
students.user_id
students.class_id

faculties.user_id
faculties.department_id

semesters.academic_year_id

classes.department_id
classes.semester_id
classes.academic_year_id

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

timetables.class_id
timetables.subject_id
timetables.faculty_id
timetables.period_id
timetables.room_id
timetables.academic_year_id
timetables.semester_id

temporary_timetables.request_id
temporary_timetables.original_timetable_id
temporary_timetables.class_id
temporary_timetables.subject_id
temporary_timetables.faculty_id
temporary_timetables.period_id
temporary_timetables.room_id

assignments.class_id
assignments.subject_id
assignments.faculty_id

assignment_attachments.assignment_id

exam_timetables.exam_id
exam_timetables.class_id
exam_timetables.subject_id
exam_timetables.room_id

period_requests.requester_faculty_id
period_requests.receiver_faculty_id
period_requests.original_timetable_id
period_requests.class_id
period_requests.original_subject_id
period_requests.requested_subject_id
period_requests.period_id

notifications.user_id

notification_preferences.user_id

announcements.created_by
```

---

# 66. Important Design Decision: Temporary Timetable

The temporary timetable must be linked to the request that created it.

```text
PeriodRequest
      │
      │ 1 : 0..1
      ↓
TemporaryTimetable
```

This gives us traceability:

```text
Temporary Change
      ↓
Which request created it?
      ↓
Who requested it?
      ↓
Who accepted it?
      ↓
What was the original period?
```

This will be important for debugging and future auditing.

---

# 67. Important Design Decision: No Direct Student → Assignment Relationship

A student does not need a direct foreign key to an assignment for the current system.

Instead:

```text
Student
   ↓
Class
   ↓
Assignment
```

This means all students belonging to the target class can see the assignment.

This avoids creating unnecessary duplicate assignment records for every student.

---

# 68. Important Design Decision: No Direct Student → Timetable Relationship

Similarly:

```text
Student
   ↓
Class
   ↓
Timetable
```

Students receive their timetable through their class.

This avoids duplicating timetable entries for every student.

---

# 69. Important Design Decision: No Direct Faculty → Student Relationship

Students and faculty interact through academic structures:

```text
Faculty
   ↓
Subject / Timetable
   ↓
Class
   ↓
Students
```

A direct Faculty → Student relationship is unnecessary for the core system.

---

# 70. Important Design Decision: Notification Is User-Centric

Notifications are assigned to users:

```text
User
   ↓
Notification
```

not directly to:

```text
Student
Faculty
```

This makes the notification system reusable across all roles.

---

# 71. Important Design Decision: WhatsApp Is a Channel, Not a User Entity

WhatsApp should not become a separate academic entity.

Instead:

```text
User
   ↓
NotificationPreference
   ↓
WhatsApp Enabled
   ↓
WhatsAppNotificationService
   ↓
WhatsApp Provider
```

The notification system remains independent of the external provider.

---

# 72. Important Design Decision: Calendar Is a Derived Module

The calendar should initially retrieve data from:

```text
Assignment
ExamTimetable
Timetable
TemporaryTimetable
PeriodRequest
Announcement
```

rather than duplicating every event into a separate calendar table.

This reduces data duplication.

---

# 73. Relationship Integrity Rules

The final database should enforce or support the following:

1. A student must reference a valid user.
2. A faculty member must reference a valid user.
3. A student must reference a valid class.
4. A faculty member must reference a valid department where required.
5. A class must reference a valid department.
6. A class must reference a valid academic year and semester.
7. A subject must reference its academic ownership.
8. Faculty-subject assignments must reference valid faculty and subjects.
9. Class-subject assignments must reference valid classes and subjects.
10. Timetable entries must reference valid classes, subjects, faculty, periods, and rooms where applicable.
11. Temporary timetable changes must reference an approved/request-related timetable change.
12. Assignments must reference valid classes, subjects, and faculty.
13. Attachments must reference a valid assignment.
14. Exam timetable entries must reference valid exams, classes, subjects, and rooms where applicable.
15. Period requests must reference valid requester and receiver faculty.
16. Period requests must reference the relevant original timetable.
17. Notifications must reference valid users.
18. Notification preferences must reference valid users.
19. Announcements must reference a valid creator.
20. Business-level rules must additionally be enforced by the Service Layer.

---

# 74. Relationship Validation Before ER Diagram

Before moving to `er-diagram.md`, the following relationship groups should be reviewed:

```text
Identity
    ↓
User / Student / Faculty

Academic
    ↓
Department / AcademicYear / Semester / Class / Subject

Teaching Allocation
    ↓
FacultySubject / ClassSubject

Timetable
    ↓
Period / Room / Timetable / TemporaryTimetable

Assignment
    ↓
Assignment / Attachment

Examination
    ↓
Exam / ExamTimetable

Period Management
    ↓
PeriodRequest / TemporaryTimetable

Notification
    ↓
Notification / NotificationPreference

Announcement
    ↓
Announcement
```

---

# 75. Final Relationship Architecture

```text
                              USERS
                                │
                 ┌──────────────┼──────────────┐
                 ↓              ↓              ↓
              STUDENT        FACULTY         ADMIN
                 │              │              │
                 ↓              ↓              ↓
               CLASS       DEPARTMENT      ANNOUNCEMENT
                 │              │
                 │              ├──────────────┐
                 │              ↓              ↓
                 │           FACULTY       SUBJECT
                 │              │              │
                 │              └──────┬───────┘
                 │                     ↓
                 │               FACULTY_SUBJECT
                 │
                 └──────────────┐
                                ↓
                         CLASS_SUBJECT
                                │
                                ↓
                         TIMETABLE DOMAIN
                                │
             ┌──────────────────┼──────────────────┐
             ↓                  ↓                  ↓
           PERIOD              ROOM            TIMETABLE
                                                   │
                                                   ↓
                                          PERIOD_REQUEST
                                                   │
                                                   ↓
                                      TEMPORARY_TIMETABLE
                                                   │
                                                   ↓
                                         EFFECTIVE TIMETABLE


            FACULTY
               │
               ↓
           ASSIGNMENT
               │
               ↓
       ASSIGNMENT_ATTACHMENT


             EXAM
               │
               ↓
        EXAM_TIMETABLE


             USER
               │
       ┌───────┴────────┐
       ↓                ↓
 NOTIFICATION    NOTIFICATION_PREFERENCE
       │
       ├── IN-APP
       ├── EMAIL
       └── WHATSAPP
```

---

# 76. Final Relationship Principles

The database relationship design follows these principles:

1. Authentication is separated from role-specific profiles.
2. Students are connected to classes rather than directly to assignments or timetables.
3. Faculty are connected to subjects through a mapping table.
4. Classes are connected to subjects through a mapping table.
5. Timetable entries connect classes, subjects, faculty, periods, and rooms.
6. Master timetable data is never replaced by temporary changes.
7. Temporary timetable changes originate from period requests.
8. Substitute requests retain the original subject.
9. Borrow requests use the requesting faculty's authorized subject.
10. Period requests have separate requester and receiver faculty relationships.
11. Assignments are associated with a class, subject, and creating faculty.
12. Assignment attachments belong to assignments.
13. Exam timetable entries connect exams, classes, subjects, and rooms.
14. Notifications belong to users rather than specific roles.
15. Notification preferences belong to users.
16. WhatsApp is treated as a notification channel.
17. Calendar events are initially derived from existing academic entities.
18. Many-to-many relationships use mapping entities.
19. Historical records should be preserved where appropriate.
20. Service-layer validation works together with database constraints.
21. The final schema must be reviewed for normalization before SQL creation.

---