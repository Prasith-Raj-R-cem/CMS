# Database Entities

## 1. Overview

This document identifies the database entities required for the Campus Management System.

The entity design is based on the system architecture and functional flows already defined.

The main database domains are:

```text
Identity & Access
Academic Structure
Timetable
Assignments
Examinations
Period Management
Notifications
Announcements
```

The purpose of this document is to identify **what data the system needs to store**.

Relationships between these entities will be defined separately in:

```text
relationships.md
```

The final physical SQL structure will be defined later in:

```text
database-schema.md
table-structure.md
```

---

# 2. Entity Overview

The current planned entities are:

```text
IDENTITY
├── User
├── Student
├── Faculty
└── Admin

ACADEMIC STRUCTURE
├── Department
├── AcademicYear
├── Semester
├── Class
├── Subject
├── FacultySubject
├── ClassSubject
└── Period

TIMETABLE
├── Timetable
└── TemporaryTimetable

ASSIGNMENT
├── Assignment
└── AssignmentAttachment

EXAMINATION
├── Exam
└── ExamTimetable

PERIOD MANAGEMENT
└── PeriodRequest

NOTIFICATION
├── Notification
└── NotificationPreference

ANNOUNCEMENT
└── Announcement
```

Some of these may become tables directly, while others may become mapping/junction tables depending on the final relationship design.

---

# 3. User Entity

## Purpose

The `User` entity represents the central authentication account.

It allows all system users to authenticate through one account structure.

```text
User
├── Student
├── Faculty
└── Admin
```

## Main Attributes

```text
id
email
password_hash
role
status
created_at
updated_at
```

## Role

Possible values:

```text
STUDENT
FACULTY
ADMIN
```

## Status

Possible values:

```text
ACTIVE
INACTIVE
```

## Important Rules

- Email should be unique.
- Password must be stored as a secure hash.
- Role must be validated server-side.
- Users must not be able to assign themselves the ADMIN role.
- Deactivated users should not be allowed to authenticate normally.

---

# 4. Student Entity

## Purpose

Stores student-specific academic information.

## Main Attributes

```text
id
user_id
register_number
class_id
admission_year
status
created_at
updated_at
```

## Important Rules

- A student must have a valid user account.
- Register number should be unique.
- A student belongs to an academic class.
- Student access must be restricted to authorized academic data.

---

# 5. Faculty Entity

## Purpose

Stores faculty-specific information.

## Main Attributes

```text
id
user_id
employee_id
department_id
status
created_at
updated_at
```

## Important Rules

- A faculty member must have a valid user account.
- Employee ID should be unique.
- Faculty should belong to a department where applicable.
- Faculty authorization must be enforced server-side.

---

# 6. Admin Entity

## Purpose

Represents administrator-specific information.

For the initial system, an Admin may primarily be represented through the `User` entity using:

```text
role = ADMIN
```

A separate `Admin` profile table should only be created if administrator-specific information is required.

## Possible Attributes

```text
id
user_id
```

This entity is therefore **optional at the physical database level**.

---

# 7. Department Entity

## Purpose

Represents an academic department.

Examples:

```text
Computer Science and Engineering
Electrical and Electronics Engineering
Mechanical Engineering
Civil Engineering
```

## Main Attributes

```text
id
department_code
department_name
status
created_at
updated_at
```

## Important Rules

- Department code should be unique.
- Department name should normally be unique.
- A department can contain multiple classes.
- A department can contain multiple faculty members.
- A department can offer multiple subjects.

---

# 8. Academic Year Entity

## Purpose

Represents an academic year.

Example:

```text
2026-2027
```

## Main Attributes

```text
id
year_name
start_date
end_date
status
created_at
updated_at
```

## Status

Possible values:

```text
ACTIVE
INACTIVE
COMPLETED
```

Only the appropriate academic year should be marked active according to institutional rules.

---

# 9. Semester Entity

## Purpose

Represents a semester within the academic structure.

Example:

```text
S1
S2
S3
S4
```

## Main Attributes

```text
id
semester_number
semester_name
academic_year_id
status
created_at
updated_at
```

The final relationship between Semester and AcademicYear will be finalized in `relationships.md`.

---

# 10. Class Entity

## Purpose

Represents an academic student group.

Example:

```text
S2 CSE
S3 CSE
S2 ECE
```

## Main Attributes

```text
id
class_name
department_id
semester_id
academic_year_id
section
status
created_at
updated_at
```

## Important Rules

- A class belongs to a department.
- A class belongs to an academic period/semester structure.
- Students can be assigned to a class.
- A class can have many subjects.
- A class can have many timetable entries.

---

# 11. Subject Entity

## Purpose

Represents an academic subject.

Example:

```text
Data Structures
Object Oriented Programming
Engineering Mathematics
```

## Main Attributes

```text
id
subject_code
subject_name
department_id
semester_id
credits
subject_type
status
created_at
updated_at
```

## Subject Type

Possible examples:

```text
THEORY
LAB
ELECTIVE
OTHER
```

The final values will be decided according to the institution's requirements.

---

# 12. FacultySubject Entity

## Purpose

Represents the relationship between faculty and subjects they are authorized to teach.

This may be required because:

```text
One Faculty → Many Subjects
One Subject → Many Faculty
```

Therefore, a many-to-many relationship may require a mapping entity.

## Main Attributes

```text
id
faculty_id
subject_id
academic_year_id
semester_id
status
```

## Example

```text
Faculty A → Data Structures
Faculty A → OOP
Faculty B → Data Structures
```

This entity becomes particularly important for **borrow-period validation**.

Before a faculty member borrows a period to teach their own subject, the system can verify that the faculty member is authorized to teach that subject.

---

# 13. ClassSubject Entity

## Purpose

Represents which subjects are associated with a class.

This may be required because:

```text
One Class → Many Subjects
One Subject → Many Classes
```

## Main Attributes

```text
id
class_id
subject_id
academic_year_id
semester_id
status
```

## Example

```text
S2 CSE → Data Structures
S2 CSE → OOP
S2 CSE → Mathematics
```

This relationship is also useful for validating assignments and timetable entries.

---

# 14. Period Entity

## Purpose

Represents a predefined academic timetable period.

Example:

```text
Period 1
09:00 - 10:00

Period 2
10:00 - 11:00
```

## Main Attributes

```text
id
period_number
start_time
end_time
status
```

## Important Rules

Periods should be represented as database entities rather than relying entirely on hard-coded values.

This makes timetable management easier.

---

# 15. Timetable Entity

## Purpose

Represents a normal/master timetable entry.

This is the source of the regular academic schedule.

## Main Attributes

```text
id
class_id
subject_id
faculty_id
period_id
day_of_week
room_id / room_reference
academic_year_id
semester_id
status
created_at
updated_at
```

The final room design will be decided later.

## Important Rule

The master timetable must not be overwritten when a temporary period change occurs.

---

# 16. TemporaryTimetable Entity

## Purpose

Stores an approved temporary timetable change.

This entity is critical to the substitute and borrow-period systems.

## Main Attributes

```text
id
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
room_id / room_reference
status
created_at
updated_at
```

## Change Type

```text
SUBSTITUTE
BORROW
```

## Important Rule

The temporary timetable record overrides the effective schedule only for the relevant date and period.

The master timetable remains unchanged.

---

# 17. Effective Timetable Concept

`EffectiveTimetable` does not necessarily need to be a physical table.

It is a logical result produced by combining:

```text
Master Timetable
        +
Active Temporary Timetable
        ↓
Effective Timetable
```

Example:

```text
MASTER

Period 3
Data Structures
Faculty A


TEMPORARY

Period 3
Data Structures
Faculty B
SUBSTITUTE


EFFECTIVE

Period 3
Data Structures
Faculty B
```

For borrowing:

```text
MASTER

Period 3
Data Structures
Faculty A


TEMPORARY

Period 3
OOP
Faculty B
BORROW


EFFECTIVE

Period 3
OOP
Faculty B
```

---

# 18. Assignment Entity

## Purpose

Stores assignments created by faculty.

## Main Attributes

```text
id
title
description
class_id
subject_id
faculty_id
deadline
status
created_at
updated_at
```

## Status

Possible values:

```text
ACTIVE
INACTIVE
CANCELLED
```

## Important Rules

- Faculty must be authorized to create the assignment.
- Assignment must be associated with a valid class.
- Assignment must be associated with a valid subject.
- Deadline must be valid.
- Assignment deadline can be displayed in the student calendar.

---

# 19. AssignmentAttachment Entity

## Purpose

Stores metadata for files attached to an assignment.

Assignments may contain:

```text
Image
PDF
Document
Other Supported File
```

## Main Attributes

```text
id
assignment_id
file_name
file_type
file_size
storage_reference
uploaded_at
```

The actual file may be stored outside the relational database depending on the final implementation.

## Important Rule

The database should normally store the file's metadata/reference rather than unnecessarily storing large files directly in the main assignment table.

---

# 20. Exam Entity

## Purpose

Represents an examination event/type.

Possible examples:

```text
University Exam
Internal Exam
Model Exam
Other Exam
```

## Main Attributes

```text
id
exam_name
exam_type
academic_year_id
semester_id
status
created_at
updated_at
```

The exact exam structure can be simplified for the mini-project if necessary.

---

# 21. ExamTimetable Entity

## Purpose

Stores the scheduled examination for a class and subject.

## Main Attributes

```text
id
exam_id
class_id
subject_id
exam_date
start_time
end_time
room_id / room_reference
status
created_at
updated_at
```

## Important Rules

- Subject must belong to the relevant class/academic structure.
- Exam dates must be valid.
- Conflicting exams should be prevented.
- Published exam timetable changes can generate notifications.

---

# 22. PeriodRequest Entity

## Purpose

Stores faculty requests for substitute or borrowed periods.

This is one of the core entities of the system.

## Main Attributes

```text
id
request_type
requester_faculty_id
receiver_faculty_id
original_timetable_id
class_id
original_subject_id
requested_subject_id
date
period_id
request_note
reply_note
status
created_at
responded_at
```

## Request Type

```text
SUBSTITUTE
BORROW
```

## Status

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

---

# 23. Substitute Request Entity Logic

For a substitute request:

```text
request_type = SUBSTITUTE
```

The system should represent:

```text
Requester:
Faculty A

Receiver:
Faculty B

Original Subject:
Data Structures

Requested Subject:
Data Structures
```

The subject remains unchanged.

The temporary faculty becomes:

```text
Faculty B
```

---

# 24. Borrow Request Entity Logic

For a borrow request:

```text
request_type = BORROW
```

The system should represent:

```text
Requester:
Faculty B

Receiver:
Faculty A

Original Subject:
Data Structures

Requested Subject:
OOP
```

The temporary faculty becomes:

```text
Faculty B
```

This distinction is essential to the business logic.

---

# 25. Notification Entity

## Purpose

Stores notifications generated by system events.

## Main Attributes

```text
id
user_id
event_type
channel
title
message
status
read_status
created_at
sent_at
delivered_at
read_at
retry_count
provider_message_id
error_code
```

## Channel

```text
IN_APP
EMAIL
WHATSAPP
```

## Delivery Status

Possible values:

```text
PENDING
SENT
DELIVERED
FAILED
```

The exact status mapping can vary by channel/provider.

---

# 26. NotificationPreference Entity

## Purpose

Stores user preferences for notification channels.

## Main Attributes

```text
id
user_id
in_app_enabled
email_enabled
whatsapp_enabled
updated_at
```

Optional future design may support event-level preferences.

Example:

```text
Assignment Notifications → WhatsApp ON
Timetable Notifications → WhatsApp OFF
```

That advanced structure can be added later if required.

---

# 27. Announcement Entity

## Purpose

Stores announcements created by administrators.

## Main Attributes

```text
id
title
content
created_by
target_type
target_reference
status
published_at
created_at
updated_at
```

## Target Type

Possible examples:

```text
ALL_STUDENTS
ALL_FACULTY
DEPARTMENT
CLASS
SEMESTER
SELECTED_USERS
```

The exact targeting structure will be finalized during relationship design.

---

# 28. Calendar Event Concept

A separate `CalendarEvent` table is **not required initially** for every academic event.

Many calendar events can be derived from existing records:

```text
Assignment Deadline
        ↓
Assignment

Exam
        ↓
ExamTimetable

Timetable Change
        ↓
TemporaryTimetable
```

This avoids unnecessary duplication.

A dedicated calendar-event entity can be added later if the system needs custom events.

---

# 29. Room Entity

The current system requires room information for timetable and examination scheduling.

There are two possible designs:

### Option A — Dedicated Room Entity

```text
Room
├── id
├── room_number
├── building
└── capacity
```

### Option B — Simple Room Reference

Store a room identifier directly in timetable records.

For a professional long-term system, a dedicated `Room` entity is recommended.

It can therefore be included in the database design if room management is part of the final scope.

---

# 30. Room Entity — Recommended

## Purpose

Represents a physical classroom/laboratory.

## Main Attributes

```text
id
room_number
building
room_type
capacity
status
```

Possible room types:

```text
CLASSROOM
LAB
SEMINAR_HALL
OTHER
```

This allows timetable conflict validation.

---

# 31. AuditLog Entity — Optional

An audit log can record important administrative actions.

Possible attributes:

```text
id
user_id
action
entity_type
entity_id
description
created_at
```

Examples:

```text
Admin created faculty
Admin published timetable
Admin changed exam timetable
Faculty created assignment
Faculty accepted period request
```

For the 20-day mini-project, this can be treated as an optional extension if time is limited.

---

# 32. Entity Classification

The entities can be classified as follows.

## Core Entities

```text
User
Student
Faculty
Department
AcademicYear
Semester
Class
Subject
Period
Timetable
Assignment
Exam
ExamTimetable
PeriodRequest
Notification
NotificationPreference
```

## Supporting Entities

```text
FacultySubject
ClassSubject
AssignmentAttachment
TemporaryTimetable
Announcement
Room
```

## Optional Future Entities

```text
Admin
AuditLog
CalendarEvent
```

---

# 33. Entity Dependency Overview

```text
User
 │
 ├──────── Student
 │             │
 │             ↓
 │           Class
 │
 └──────── Faculty
               │
               ↓
           Department
               │
               ↓
             Subject


Department
    ↓
Class
    ↓
ClassSubject
    ↓
Subject


Faculty
    ↓
FacultySubject
    ↓
Subject


Class + Subject + Faculty + Period
                ↓
            Timetable
                │
                ↓
      TemporaryTimetable
                │
                ↓
        Effective Timetable


Faculty
   ↓
Assignment
   ↓
AssignmentAttachment


Exam
   ↓
ExamTimetable


Faculty
   ↓
PeriodRequest
   ↓
TemporaryTimetable


User
   ↓
Notification
   ↓
NotificationPreference


Admin
   ↓
Announcement
```

---

# 34. Entity Ownership

The system should clearly identify which role normally creates or manages each entity.

| Entity | Main Owner |
|---|---|
| User | Admin |
| Student | Admin |
| Faculty | Admin |
| Department | Admin |
| AcademicYear | Admin |
| Semester | Admin |
| Class | Admin |
| Subject | Admin |
| FacultySubject | Admin |
| ClassSubject | Admin |
| Period | Admin |
| Room | Admin |
| Timetable | Admin |
| TemporaryTimetable | System / Period Management |
| Assignment | Faculty |
| AssignmentAttachment | Faculty |
| Exam | Admin |
| ExamTimetable | Admin |
| PeriodRequest | Faculty |
| Notification | System |
| NotificationPreference | User |
| Announcement | Admin |
| AuditLog | System |

---

# 35. Entity Lifecycle

Different entities have different lifecycles.

### User

```text
CREATED
 ↓
ACTIVE
 ↓
INACTIVE
```

### Assignment

```text
CREATED
 ↓
ACTIVE
 ↓
INACTIVE / CANCELLED
```

### Period Request

```text
CREATED
 ↓
PENDING
 ├── ACCEPTED
 ├── REJECTED
 ├── CANCELLED
 └── EXPIRED
```

### Temporary Timetable

```text
CREATED
 ↓
ACTIVE
 ↓
EXPIRED
```

### Notification

```text
CREATED
 ↓
PENDING
 ↓
SENT
 ↓
DELIVERED
 ↓
READ
```

A failed notification can follow:

```text
PENDING
 ↓
FAILED
 ↓
RETRY
```

---

# 36. Entity Design Rules

The following rules will guide the final schema:

1. Every persistent entity should have a clear primary key.
2. Foreign keys should represent actual relationships.
3. Many-to-many relationships should use mapping entities where required.
4. Authentication data should be separated from role-specific profile data.
5. Master timetable and temporary timetable must remain separate.
6. Assignment files should use attachment metadata rather than unnecessarily duplicating assignment data.
7. Notification preferences should be separate from user identity data.
8. Notification delivery information should be stored separately from academic records.
9. WhatsApp API credentials must not be stored in normal user or notification tables.
10. Important historical records should be preserved where required.
11. Status fields should be used where soft deactivation is more appropriate than deletion.
12. Entity design should support multiple academic years and semesters.
13. Entity design should support multiple departments and classes.
14. Entity design should support faculty teaching multiple subjects.
15. Entity design should support subjects being taught to multiple classes.
16. Entity design must support both substitute and borrow period requests.
17. The system must be able to identify the original and temporary faculty/subject for timetable changes.
18. Calendar events should be derived from existing academic data wherever possible.
19. Physical table design should avoid unnecessary duplication.
20. Final relationships must be reviewed before SQL implementation.

---

# 37. Entity Count — Current Planning

The current design contains approximately:

```text
Core:
17 entities

Supporting:
6 entities

Optional:
3 entities
```

The exact final table count is **not fixed yet**.

Some concepts may become:

```text
Mapping tables
Lookup tables
Derived views
Embedded attributes
```

rather than independent tables.

This will be decided during relationship and schema design.

---

# 38. Recommended Final Core Entity Set

For the 20-day mini-project, the recommended minimum professional database scope is:

```text
1.  users
2.  students
3.  faculties
4.  departments
5.  academic_years
6.  semesters
7.  classes
8.  subjects
9.  faculty_subjects
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

This is the **current target database model**.

---