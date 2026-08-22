# Database Constraints

## 1. Overview

This document defines the integrity, validation, and business constraints for the Campus Management System database.

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
        ↓
constraints.md
```

The purpose of this document is to determine:

- Primary key constraints
- Foreign key constraints
- Unique constraints
- NOT NULL constraints
- CHECK constraints
- Default values
- Delete/update behavior
- Timetable conflict rules
- Faculty conflict rules
- Room conflict rules
- Period request rules
- Substitute rules
- Borrow rules
- Assignment rules
- Notification rules
- Admin creation policy
- Transaction requirements

Important distinction:

```text
Database Constraints
        +
Service Layer Validation
        ↓
Complete Business Integrity
```

Not every business rule should be forced into MySQL.

---

# 2. Constraint Categories

The system uses four major levels of validation.

```text
Level 1 → Application/UI validation
Level 2 → Service Layer business validation
Level 3 → Repository validation
Level 4 → Database constraints
```

Example:

```text
Student submits registration
        ↓
Servlet validates request
        ↓
Service validates business rules
        ↓
Repository executes SQL
        ↓
MySQL enforces constraints
```

The database remains the final structural integrity layer.

---

# 3. Primary Key Constraints

Every core entity must have a primary key.

Standard format:

```sql
id BIGINT PRIMARY KEY AUTO_INCREMENT
```

Tables:

```text
users
departments
academic_years
semesters
classes
students
faculties
subjects
faculty_subjects
class_subjects
periods
rooms
timetables
temporary_timetables
assignments
assignment_attachments
exams
exam_timetables
period_requests
notifications
notification_preferences
announcements
```

Primary keys must:

```text
NOT NULL
UNIQUE
IMMUTABLE
```

The application should never change an existing primary key.

---

# 4. User Constraints

## 4.1 Email

```text
users.email
```

must be:

```text
NOT NULL
UNIQUE
```

Recommended:

```text
case-insensitive uniqueness
```

For example:

```text
Admin@College.edu
admin@college.edu
```

should not create two separate accounts.

The implementation can normalize email to lowercase before storage.

---

# 5. Password Constraints

```text
users.password_hash
```

must:

```text
NOT NULL
```

It must contain a secure password hash.

Never store:

```text
plaintext password
```

Example:

```text
password_hash = secure_hash(password)
```

The hashing algorithm is an application/security decision rather than a MySQL constraint.

---

# 6. User Role Constraint

Allowed roles:

```text
STUDENT
FACULTY
ADMIN
```

No other role should be accepted.

Database:

```text
CHECK / ENUM
```

Service Layer:

```text
Role authorization
```

---

# 7. Admin Creation Constraint

There must be **no public admin registration**.

Normal registration must never accept:

```text
role = ADMIN
```

from an untrusted client.

Recommended flow:

```text
Secure Bootstrap
      ↓
First ADMIN
      ↓
ADMIN manages system
```

The first admin may be created through:

```text
Database seed
```

or a protected deployment/bootstrap mechanism.

After that:

```text
Admin → authorized administration operations
```

A student or faculty user must never be able to elevate their own role.

---

# 8. Role/Profile Consistency

The following logical relationship should be maintained:

```text
USER role = STUDENT
        ↓
Student profile should exist

USER role = FACULTY
        ↓
Faculty profile should exist

USER role = ADMIN
        ↓
No student/faculty profile required
```

This is primarily a Service Layer consistency rule.

The database can enforce profile uniqueness but should not rely solely on cross-table triggers for role/profile synchronization in the MVP.

---

# 9. Student Constraints

## 9.1 User Relationship

```text
students.user_id → users.id
```

must be:

```text
NOT NULL
UNIQUE
```

Therefore:

```text
One user → maximum one student profile
```

---

## 9.2 Register Number

```text
students.register_number
```

must be:

```text
NOT NULL
UNIQUE
```

Two students cannot have the same register number.

---

## 9.3 Class

```text
students.class_id
```

must reference a valid class.

A student should normally belong to exactly one current class.

---

# 10. Faculty Constraints

## 10.1 User Relationship

```text
faculties.user_id → users.id
```

must be:

```text
NOT NULL
UNIQUE
```

Therefore:

```text
One user → maximum one faculty profile
```

---

## 10.2 Employee ID

```text
faculties.employee_id
```

must be:

```text
NOT NULL
UNIQUE
```

---

## 10.3 Department

Faculty should reference a valid department.

```text
faculties.department_id → departments.id
```

---

# 11. Department Constraints

```text
department_code
```

must be unique.

```text
department_name
```

should also be unique.

Example:

```text
CSE
ECE
EEE
ME
```

No duplicate department code should exist.

---

# 12. Academic Year Constraints

```text
academic_years.year_name
```

must be unique.

Example:

```text
2026-2027
```

There should not be two active records with the same year name.

Date rule:

```text
start_date < end_date
```

This should be enforced through:

```text
CHECK
```

and/or Service Layer validation.

---

# 13. Semester Constraints

A semester must belong to an academic year.

```text
semesters.academic_year_id
    → academic_years.id
```

Semester number must be valid.

For the current KTU-style system:

```text
1
2
3
4
5
6
7
8
```

If the project later needs a different academic structure, this can be expanded.

Recommended:

```sql
CHECK (semester_number BETWEEN 1 AND 8)
```

Within one academic year, duplicate semester numbers should not exist.

Recommended unique combination:

```text
academic_year_id
+
semester_number
```

---

# 14. Class Constraints

A class must reference:

```text
department
semester
academic year
```

Therefore:

```text
department_id NOT NULL
semester_id NOT NULL
academic_year_id NOT NULL
```

---

# 15. Class Academic Consistency

The class's:

```text
semester
academic_year
```

must represent a valid academic context.

Example:

```text
Class:
S3 CSE

Academic Year:
2026-2027

Semester:
S3
```

A class should not reference:

```text
S3 semester from 2025-2026
```

while using:

```text
2026-2027 academic_year
```

This is a Service Layer validation rule unless the schema is later redesigned to eliminate redundant context.

---

# 16. Student Admission Year

```text
students.admission_year
```

must be a valid year.

The Service Layer should validate that it is not later than the current academic context.

---

# 17. Subject Constraints

```text
subject_code
```

must be:

```text
NOT NULL
UNIQUE
```

```text
subject_name
```

must be:

```text
NOT NULL
```

Subject credits, when present, must be positive.

Recommended:

```text
credits > 0
```

---

# 18. Subject Type Constraint

Allowed values:

```text
THEORY
LAB
ELECTIVE
OTHER
```

The database should reject unsupported values.

---

# 19. Faculty-Subject Mapping Constraints

`faculty_subjects` represents:

```text
Faculty N : N Subject
```

Required:

```text
faculty_id
subject_id
academic_year_id
semester_id
```

must all be:

```text
NOT NULL
```

Recommended unique combination:

```text
faculty_id
+
subject_id
+
academic_year_id
+
semester_id
```

This prevents duplicate assignment records.

---

# 20. Class-Subject Mapping Constraints

Required:

```text
class_id
subject_id
academic_year_id
semester_id
```

must be:

```text
NOT NULL
```

Recommended unique combination:

```text
class_id
+
subject_id
+
academic_year_id
+
semester_id
```

A class cannot have the same subject assigned twice in the same academic context.

---

# 21. Faculty Teaching Authorization

A faculty member may teach a subject only when a valid:

```text
faculty_subjects
```

record exists.

For example:

```text
Faculty B
    ↓
faculty_subjects
    ↓
OOP
```

Then:

```text
Faculty B → OOP
```

is authorized.

This is a Service Layer rule.

---

# 22. Class Subject Authorization

A timetable or assignment should normally use a subject that belongs to the class through:

```text
class_subjects
```

Example:

```text
S2 CSE
   ↓
class_subjects
   ↓
OOP
```

Therefore:

```text
S2 CSE → OOP
```

is valid.

---

# 23. Period Constraints

```text
period_number
```

must be positive.

Recommended:

```text
period_number > 0
```

Time rule:

```text
start_time < end_time
```

No period should have:

```text
start_time >= end_time
```

---

# 24. Period Uniqueness

Within the same period configuration:

```text
period_number
```

should normally be unique.

Example:

```text
Period 1
Period 2
Period 3
```

No duplicate period number should exist in the same timetable configuration.

---

# 25. Room Constraints

```text
room_number
```

must be unique.

Capacity, when present:

```text
capacity > 0
```

A room may be:

```text
CLASSROOM
LAB
SEMINAR_HALL
OTHER
```

---

# 26. Master Timetable Constraints

The master timetable is stored in:

```text
timetables
```

Every timetable entry must reference:

```text
class
subject
faculty
period
academic_year
semester
```

Room is optional if the college does not assign rooms for every period.

---

# 27. Class Timetable Conflict

A class cannot have two subjects in the same:

```text
academic_year
+
semester
+
day_of_week
+
period
```

Recommended database uniqueness:

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

This prevents:

```text
S2 CSE
Monday
Period 3
OOP
```

and:

```text
S2 CSE
Monday
Period 3
Data Structures
```

from existing simultaneously in the master timetable.

---

# 28. Faculty Timetable Conflict

A faculty member should not teach two classes during the same:

```text
academic_year
+
semester
+
day_of_week
+
period
```

Example invalid state:

```text
Faculty A
Monday
Period 3

S2 CSE
AND
S3 CSE
```

This rule is usually implemented through Service Layer conflict detection.

A database generated-column/functional unique strategy may be considered later, but the MVP should keep the rule understandable and enforce it transactionally in the Service Layer.

---

# 29. Room Timetable Conflict

A room should not be assigned to two classes during the same:

```text
academic_year
+
semester
+
day_of_week
+
period
```

Example:

```text
Room 201
Monday
Period 2
```

cannot simultaneously be:

```text
S2 CSE
```

and:

```text
S3 ECE
```

This is primarily a Service Layer conflict rule.

---

# 30. Timetable Academic Consistency

The timetable's:

```text
class_id
subject_id
faculty_id
academic_year_id
semester_id
```

must represent a valid combination.

The Service Layer should verify:

```text
Class → Subject
```

through:

```text
class_subjects
```

and:

```text
Faculty → Subject
```

through:

```text
faculty_subjects
```

---

# 31. Master Timetable Protection

Temporary timetable changes must never overwrite:

```text
timetables
```

Instead:

```text
timetables
       +
temporary_timetables
```

produce the effective schedule.

This preserves the original timetable.

---

# 32. Temporary Timetable Constraints

Every temporary timetable record must reference:

```text
request_id
original_timetable_id
class_id
subject_id
faculty_id
period_id
date
change_type
original_subject_id
original_faculty_id
```

Required values must not be NULL.

---

# 33. Temporary Timetable Request Constraint

A temporary timetable can be created only from an accepted request.

Logical rule:

```text
period_requests.status = ACCEPTED
        ↓
temporary_timetables can be created
```

A:

```text
PENDING
REJECTED
CANCELLED
```

request must not generate an active temporary timetable.

This is a Service Layer transaction rule.

---

# 34. One Temporary Change per Request

Recommended:

```text
temporary_timetables.request_id
```

must be unique.

Therefore:

```text
One accepted period request
        ↓
Maximum one temporary timetable record
```

This prevents duplicate application of the same request.

---

# 35. Temporary Timetable Date Constraint

The temporary timetable must contain a specific date.

```text
temporary_timetables.date NOT NULL
```

The date must correspond to the intended day of the original timetable.

Example:

```text
Master:
MONDAY + Period 3

Temporary date:
2026-09-21

2026-09-21 must be a Monday.
```

This should be validated in the Service Layer.

---

# 36. Temporary Timetable Change Type

Allowed:

```text
SUBSTITUTE
BORROW
```

No other value should be accepted.

---

# 37. Substitute Request Constraints

For:

```text
request_type = SUBSTITUTE
```

the expected logic is:

```text
original_subject_id
=
requested_subject_id
```

The receiving faculty teaches the original subject.

Example:

```text
Original:
Faculty A
Data Structures

Substitute:
Faculty B
Data Structures
```

Therefore:

```text
requested_subject_id = original_subject_id
```

This is a Service Layer business rule.

---

# 38. Substitute Faculty Constraint

The receiving faculty must be authorized to teach the subject.

Check:

```text
faculty_subjects
```

Example:

```text
Faculty B
      ↓
faculty_subjects
      ↓
Data Structures
```

If no valid record exists:

```text
Reject request
```

---

# 39. Borrow Request Constraints

For:

```text
request_type = BORROW
```

the requested subject can be different from the original subject.

Example:

```text
Original:
Data Structures
Faculty A

Borrow:
OOP
Faculty B
```

Therefore:

```text
original_subject_id
!=
requested_subject_id
```

is normally expected for a true borrow request.

The Service Layer should validate this.

---

# 40. Borrow Faculty Authorization

The borrowing faculty must be authorized to teach:

```text
requested_subject_id
```

through:

```text
faculty_subjects
```

Example:

```text
Faculty B
    ↓
faculty_subjects
    ↓
OOP
```

Only then:

```text
Faculty B → OOP
```

can be used for the borrowed period.

---

# 41. Borrowed Period Conflict

The requesting faculty cannot borrow a period if they are already teaching another class during the same:

```text
date
+
period
```

The Service Layer must check:

```text
Master timetable
+
Temporary timetable
```

for conflicts.

---

# 42. Receiver Faculty Conflict

The receiving faculty cannot accept a substitute request if they already have another teaching assignment at the same:

```text
date
+
period
```

The Service Layer must check both:

```text
Master timetable
```

and:

```text
Temporary timetable
```

---

# 43. Requester/Receiver Constraint

The following should normally be invalid:

```text
requester_faculty_id
=
receiver_faculty_id
```

A faculty member should not request their own period from themselves.

Service Layer validation:

```text
if requester == receiver
    reject
```

---

# 44. Period Request Original Timetable Constraint

The selected:

```text
original_timetable_id
```

must correspond to:

```text
class_id
period_id
date/day
```

stored in the request.

The Service Layer must verify the consistency.

---

# 45. Request Note Constraint

```text
request_note
```

is optional.

A faculty member can submit:

```text
Request
+
Optional Note
```

Example:

```text
"Please cover this period because I have an official meeting."
```

---

# 46. Reply Note Constraint

```text
reply_note
```

is optional.

The receiving faculty can respond:

```text
Accept
Reject
+
Optional Reply Note
```

Example:

```text
"I can take the period."
```

or:

```text
"Unable to take the period due to another commitment."
```

---

# 47. Period Request Status Constraint

Allowed values:

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

State transitions:

```text
PENDING
   ├── ACCEPTED
   ├── REJECTED
   ├── CANCELLED
   └── EXPIRED
```

An accepted request should not return to pending.

A rejected request should not become accepted without creating a new request or explicit administrative override.

---

# 48. Request Response Constraint

Only the receiver faculty or an authorized administrator should be able to:

```text
ACCEPT
REJECT
```

a period request.

A random faculty/student must not modify the response.

Authorization is a Service Layer rule.

---

# 49. Period Request Transaction

Accepting a request must be transactional.

Recommended:

```text
BEGIN TRANSACTION

1. Lock/check relevant timetable records
2. Verify request is still PENDING
3. Verify faculty availability
4. Verify room availability
5. Verify subject authorization
6. Update request → ACCEPTED
7. Create temporary timetable
8. Create notifications

COMMIT
```

If any critical step fails:

```text
ROLLBACK
```

This prevents inconsistent schedules.

---

# 50. Assignment Constraints

Every assignment requires:

```text
title
class_id
subject_id
faculty_id
deadline
```

Therefore these fields should be:

```text
NOT NULL
```

---

# 51. Assignment Faculty Authorization

The assignment creator must be authorized to teach the subject.

Validate:

```text
faculty_subjects
```

before creating the assignment.

---

# 52. Assignment Class Authorization

The selected subject must belong to the selected class.

Validate:

```text
class_subjects
```

before creating the assignment.

---

# 53. Assignment Deadline Constraint

Deadline must be a valid future date/time when creating a new assignment.

Example:

```text
Current:
2026-09-01 10:00

Deadline:
2026-09-10 23:59
```

is valid.

Deadline:

```text
2026-08-20
```

would normally be rejected for a newly created assignment.

This is primarily Service Layer validation.

---

# 54. Assignment Attachment Constraints

Every attachment must reference a valid assignment.

```text
assignment_id → assignments.id
```

Required:

```text
file_name
file_type
storage_reference
```

File size should be positive when supplied.

Recommended:

```text
file_size > 0
```

Maximum file size should be enforced by the application/storage layer.

---

# 55. Assignment Attachment Security

Allowed file types should be restricted by the application.

Do not blindly trust:

```text
file extension
Content-Type
filename
```

The backend should validate uploaded files.

Storage references must not allow path traversal.

Example unsafe:

```text
../../database.sql
```

The actual file-storage implementation will handle this.

---

# 56. Exam Constraints

An exam requires:

```text
exam_name
exam_type
academic_year_id
semester_id
```

All should be valid.

---

# 57. Exam Timetable Constraints

Each exam timetable entry requires:

```text
exam_id
class_id
subject_id
exam_date
start_time
end_time
```

Room is optional if the institution does not assign a room.

Time rule:

```text
start_time < end_time
```

---

# 58. Exam Subject/Class Validation

The exam subject must belong to the target class.

Validate:

```text
class_subjects
```

before publishing the exam timetable.

---

# 59. Exam Room Conflict

A room cannot host multiple examinations at the same:

```text
date
+
time range
```

This requires overlap checking.

Example:

```text
Room 201
10:00 - 12:00
```

cannot also host:

```text
09:30 - 11:00
```

The Service Layer must detect time-range overlap.

---

# 60. Exam Class Conflict

A class should not have two exams whose time ranges overlap on the same date.

Example:

```text
S3 CSE
10:00 - 12:00
Mathematics
```

cannot simultaneously have:

```text
S3 CSE
11:00 - 13:00
Physics
```

---

# 61. Notification Constraints

Every notification requires:

```text
user_id
event_type
channel
title
message
```

These should be:

```text
NOT NULL
```

---

# 62. Notification Channel Constraint

Allowed:

```text
IN_APP
EMAIL
WHATSAPP
```

No unsupported channel should be inserted.

---

# 63. Notification Status Constraint

Allowed:

```text
PENDING
SENT
DELIVERED
FAILED
```

Possible lifecycle:

```text
PENDING
   ↓
SENT
   ↓
DELIVERED
```

or:

```text
PENDING
   ↓
FAILED
```

---

# 64. Notification Read Constraint

Allowed:

```text
UNREAD
READ
```

Read state applies primarily to:

```text
IN_APP
```

For email/WhatsApp, delivery state is more important.

---

# 65. Notification Retry Constraint

```text
retry_count >= 0
```

A failed notification can be retried according to application policy.

The system should avoid infinite retries.

---

# 66. Notification Preference Constraints

Each user should have at most one preference record.

Therefore:

```text
notification_preferences.user_id
```

must be:

```text
UNIQUE
```

Allowed settings:

```text
TRUE
FALSE
```

---

# 67. WhatsApp Notification Constraint

WhatsApp is treated as a notification channel.

The system should only send WhatsApp notifications when:

```text
whatsapp_enabled = TRUE
```

and the user has the necessary contact/consent configuration required by the implementation.

The system must not assume that every user can receive WhatsApp messages.

---

# 68. Email Notification Constraint

Email notifications require a valid user email.

Before sending:

```text
users.email
```

must be available.

If email delivery fails:

```text
notifications.status = FAILED
```

and the error can be stored in:

```text
error_code
```

---

# 69. In-App Notification Constraint

In-app notifications are stored in:

```text
notifications
```

and should be visible through:

```text
user_id
+
read_status
```

A user can mark their own notification as read.

---

# 70. Notification Authorization

A user should only be able to:

```text
View own notifications
Mark own notifications as read
```

unless the user is an authorized administrator.

Students must not read another student's notifications.

---

# 71. Announcement Constraints

Announcements require:

```text
created_by
title
content
target_type
status
```

`created_by` must reference a valid user.

The Service Layer must verify:

```text
created_by.role = ADMIN
```

before publishing an administrator announcement.

---

# 72. Announcement Status

Allowed:

```text
DRAFT
PUBLISHED
ARCHIVED
```

Possible state flow:

```text
DRAFT
  ↓
PUBLISHED
  ↓
ARCHIVED
```

Only authorized administrators can publish/archive announcements.

---

# 73. Announcement Target Constraints

Allowed target types:

```text
ALL_USERS
ALL_STUDENTS
ALL_FACULTY
DEPARTMENT
CLASS
SEMESTER
```

For:

```text
ALL_USERS
ALL_STUDENTS
ALL_FACULTY
```

`target_reference` should be NULL.

For:

```text
DEPARTMENT
CLASS
SEMESTER
```

`target_reference` should contain the relevant entity ID.

Because `target_reference` can refer to different tables, this is a Service Layer validation rule.

---

# 74. Foreign Key Delete Strategy

Default strategy for important academic data:

```text
ON DELETE RESTRICT
```

This protects historical records.

Examples:

```text
Department
   ↓
Faculty
```

Do not allow deleting a department that still has dependent records.

---

# 75. Cascade Delete Strategy

Cascade delete should be used carefully.

Good candidate:

```text
assignments
    ↓
assignment_attachments
```

If an assignment is permanently deleted, its attachment metadata may be deleted.

However, the preferred application behavior is often:

```text
status = INACTIVE
```

rather than physical deletion.

---

# 76. Notification Delete Strategy

Notifications should normally not be automatically deleted when a user becomes inactive.

This preserves delivery history.

Therefore:

```text
User
   ↓
Notifications
```

should generally use:

```text
ON DELETE RESTRICT
```

or prevent user deletion entirely.

---

# 77. User Deletion Strategy

For the MVP:

```text
Do not physically delete users.
```

Use:

```text
status = INACTIVE
```

This preserves:

```text
Assignments
Notifications
Period Requests
Audit relationships
```

---

# 78. Academic Record Deletion Strategy

Avoid deleting:

```text
academic_years
semesters
classes
subjects
timetables
assignments
exams
period_requests
```

when they have historical dependencies.

Prefer:

```text
INACTIVE
COMPLETED
ARCHIVED
CANCELLED
```

depending on the entity.

---

# 79. Update Restrictions

Primary keys must not be changed.

Historical identifiers such as:

```text
register_number
employee_id
subject_code
```

should normally be treated as stable identifiers.

Changes should be restricted or carefully audited.

---

# 80. Timetable Change Policy

Master timetable changes should be handled separately from temporary daily changes.

```text
Permanent change
      ↓
Update master timetable

Temporary change
      ↓
Period request
      ↓
Temporary timetable
```

This distinction is critical.

---

# 81. Effective Timetable Rule

For a specific:

```text
class
+
date
+
period
```

the system should determine:

```text
Is there an active temporary timetable?
```

If:

```text
YES
```

use:

```text
temporary_timetables
```

Otherwise:

```text
timetables
```

This logic belongs to the Timetable Service.

---

# 82. Temporary Timetable Conflict

An active temporary timetable should not create a duplicate effective schedule for the same:

```text
class
+
date
+
period
```

The Service Layer should prevent two active temporary changes from occupying the same class/date/period.

---

# 83. Temporary Faculty Conflict

An active temporary timetable should not assign a faculty member to multiple classes during:

```text
date
+
period
```

The Service Layer must check:

```text
Master timetable
+
Active temporary timetable
```

before accepting a change.

---

# 84. Temporary Room Conflict

An active temporary timetable should not assign the same room to multiple classes during:

```text
date
+
period
```

The Service Layer must check room availability.

---

# 85. Period Request Expiration

A request should not remain pending forever.

The application may mark old requests as:

```text
EXPIRED
```

when:

```text
requested date/time has passed
```

This can be handled by:

```text
scheduled job
```

or during request retrieval.

---

# 86. Assignment Notification Rule

When an assignment is published:

```text
Assignment
    ↓
Find students in class
    ↓
Create notification records
```

Notification channels depend on:

```text
notification_preferences
```

---

# 87. Assignment Deadline Notification Rule

Before a deadline:

```text
Assignment
    ↓
Deadline reminder service
    ↓
Eligible students
    ↓
Notification
```

The reminder timing should be configurable later.

---

# 88. Exam Notification Rule

When an exam timetable is published:

```text
Exam Timetable
      ↓
Find affected class
      ↓
Create notifications
```

---

# 89. Timetable Change Notification Rule

When an approved temporary timetable is created:

```text
Temporary Timetable
        ↓
Affected Class
        ↓
Students
        ↓
Notifications
```

Affected faculty should also receive a notification.

---

# 90. Period Request Notification Rule

When a request is created:

```text
Requester
     ↓
Period Request
     ↓
Receiver
     ↓
Notification
```

When accepted/rejected:

```text
Receiver
     ↓
Response
     ↓
Requester
     ↓
Notification
```

---

# 91. Transaction Rules

The following operations should use database transactions.

## Accept Period Request

```text
BEGIN
 ↓
Validate request
 ↓
Check conflicts
 ↓
Update request
 ↓
Create temporary timetable
 ↓
Create notifications
 ↓
COMMIT
```

---

## Create Assignment

```text
BEGIN
 ↓
Validate faculty
 ↓
Validate class/subject
 ↓
Create assignment
 ↓
Create attachment metadata
 ↓
Create notification records
 ↓
COMMIT
```

---

## Publish Exam Timetable

```text
BEGIN
 ↓
Validate class/subject
 ↓
Validate room
 ↓
Validate conflicts
 ↓
Create/update exam timetable
 ↓
Create notifications
 ↓
COMMIT
```

---

# 92. Concurrency Protection

Timetable and period-request operations can be affected by two users acting simultaneously.

Example:

```text
Faculty A accepts request
        +
Faculty C updates timetable
        ↓
Potential conflict
```

The Service Layer should use:

```text
database transaction
+
appropriate row locking
+
revalidation before commit
```

for critical scheduling operations.

---

# 93. Optimistic vs Pessimistic Strategy

For the MVP:

```text
Normal CRUD
→ standard transaction

Critical scheduling changes
→ transaction + locking/revalidation
```

We do not need an overly complex distributed locking system for the college mini-project.

---

# 94. Repository Responsibility

Repository Layer handles:

```text
SQL
CRUD
transactions where appropriate
database exceptions
```

Example:

```text
TimetableRepository
```

can execute:

```text
findByClass()
findByFaculty()
findByDate()
save()
update()
delete/deactivate()
```

But Repository should not decide:

```text
"Can Faculty B borrow Faculty A's period?"
```

That belongs to:

```text
PeriodRequestService
```

---

# 95. Service Layer Responsibility

Service Layer handles:

```text
Authorization
Business rules
Conflict checking
Validation across multiple tables
Transactions
Workflow
```

Example:

```text
PeriodRequestService.acceptRequest()
```

should validate:

```text
request status
requester
receiver
subject authorization
faculty availability
class availability
room availability
date
period
```

before creating the temporary timetable.

---

# 96. Servlet Responsibility

Servlets should handle:

```text
HTTP request
session/user
input extraction
basic request validation
calling Service
HTTP response
```

Servlets should not directly execute SQL.

---

# 97. JSP Responsibility

JSP should handle:

```text
HTML rendering
form input
calendar UI
tables
buttons
messages
```

JSP must not contain database queries.

---

# 98. Constraint Responsibility Matrix

| Rule | Database | Service | Servlet/JSP |
|---|---|---|---|
| Primary key | ✓ | — | — |
| Foreign key | ✓ | — | — |
| Unique email | ✓ | ✓ | — |
| Password hashing | — | ✓ | — |
| Admin creation | — | ✓ | — |
| Faculty subject authorization | — | ✓ | — |
| Class subject authorization | — | ✓ | — |
| Class timetable conflict | Partial | ✓ | — |
| Faculty timetable conflict | Partial | ✓ | — |
| Room timetable conflict | Partial | ✓ | — |
| Borrow validation | — | ✓ | — |
| Substitute validation | — | ✓ | — |
| Request state transition | Partial | ✓ | — |
| Assignment deadline | — | ✓ | Basic |
| File validation | — | ✓ | Basic |
| Notification preference | ✓ | ✓ | Basic |
| Announcement authorization | — | ✓ | — |
| HTTP validation | — | — | ✓ |

---

# 99. Final Constraint Checklist

```text
[✓] Primary keys
[✓] Foreign keys
[✓] Unique email
[✓] Unique register number
[✓] Unique employee ID
[✓] Unique subject code
[✓] Unique room number
[✓] Mapping table uniqueness
[✓] User role validation
[✓] Admin bootstrap policy
[✓] Student profile uniqueness
[✓] Faculty profile uniqueness
[✓] Academic year validation
[✓] Semester validation
[✓] Class academic consistency
[✓] Subject authorization
[✓] Faculty authorization
[✓] Timetable class conflict
[✓] Timetable faculty conflict
[✓] Timetable room conflict
[✓] Temporary timetable rules
[✓] Substitute rules
[✓] Borrow rules
[✓] Request state machine
[✓] Request response authorization
[✓] Assignment rules
[✓] Attachment rules
[✓] Exam schedule rules
[✓] Notification rules
[✓] WhatsApp channel rules
[✓] Announcement authorization
[✓] Delete strategy
[✓] Transaction requirements
[✓] Concurrency protection
[✓] Repository responsibilities
[✓] Service responsibilities
[✓] Servlet responsibilities
[✓] JSP responsibilities
```

---

# 100. Final Database Integrity Model

```text
                    DATABASE
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
   STRUCTURAL       BUSINESS       SECURITY
   CONSTRAINTS       RULES          RULES
        │              │              │
        ↓              ↓              ↓
      MySQL          Service        Service
        │             Layer          Layer
        └──────────────┼──────────────┘
                       ↓
                 VALID SYSTEM
```

The database protects the structure.

The Service Layer protects the business logic.

The authentication/authorization layer protects access.

---

# 101. Final Constraint Principles

1. Primary keys uniquely identify every record.
2. Foreign keys protect relationships.
3. Unique constraints prevent duplicate identity and mapping records.
4. NOT NULL protects required information.
5. CHECK/ENUM constraints restrict controlled values.
6. Users cannot publicly create ADMIN accounts.
7. The first administrator is created through a secure bootstrap/seed mechanism.
8. Inactive users should normally be retained rather than deleted.
9. Academic records should be preserved whenever possible.
10. Master timetable records must not be overwritten for temporary changes.
11. Temporary timetable records must originate from accepted period requests.
12. Substitute requests retain the original subject.
13. Borrow requests use the requesting faculty's authorized subject.
14. Faculty conflicts must be checked before scheduling.
15. Class conflicts must be checked before scheduling.
16. Room conflicts must be checked before scheduling.
17. Period requests must use controlled state transitions.
18. Assignment creators must be authorized faculty.
19. Assignment subjects must belong to the target class.
20. Exam schedules must not overlap for the same class.
21. Exam rooms must not have overlapping exams.
22. Notifications must respect user preferences.
23. WhatsApp is treated as a notification channel.
24. Announcement publishing requires administrator authorization.
25. Critical scheduling operations must be transactional.
26. Service Layer validation is required even when database constraints exist.
27. Repository Layer handles persistence, not business decisions.
28. JSP handles presentation, not database access.
29. The schema should preserve enough history for future auditing.
30. These rules form the integrity foundation before writing the final SQL.

---