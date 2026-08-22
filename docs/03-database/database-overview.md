# Database Overview

## 1. Overview

The Campus Management System uses a relational database to store and manage academic, user, timetable, assignment, examination, period-management, and notification data.

The planned database technology is:

```text
Database: MySQL
Communication: JDBC
Backend: Java
Architecture: Layered Architecture
```

The database is accessed only through the backend Repository Layer.

```text
JSP / HTML / CSS / JavaScript
            ↓
        Servlet
            ↓
        Service
            ↓
       Repository
            ↓
           JDBC
            ↓
          MySQL
```

The frontend must never connect directly to MySQL.

---

# 2. Database Responsibilities

The database is responsible for persistent storage of:

```text
User Accounts
Students
Faculty
Departments
Classes
Subjects
Academic Years
Semesters
Periods
Master Timetables
Temporary Timetable Changes
Assignments
Assignment Attachments
Examinations
Exam Timetables
Period Requests
Notifications
Notification Preferences
Announcements
```

The database should preserve historical and relational information instead of storing everything in a single large table.

---

# 3. Database Design Goals

The database must be designed to be:

```text
Reliable
Consistent
Normalized
Secure
Maintainable
Scalable
Query-efficient
Easy to integrate with Java
```

The design should support the current web application while allowing future expansion into:

```text
Desktop Application
Mobile Application
REST API
Advanced Notification System
Analytics
```

---

# 4. Database Architecture

The application follows:

```text
                    CAMPUS MANAGEMENT SYSTEM
                              │
                              ↓
                         Java Backend
                              │
                    ┌─────────┴─────────┐
                    ↓                   ↓
                Service Layer      Repository Layer
                                        │
                                        ↓
                                       JDBC
                                        │
                                        ↓
                                     MySQL
```

The Repository Layer is the only application layer responsible for direct database operations.

---

# 5. Repository Layer

The Repository Layer separates database access from business logic.

Example:

```text
PeriodRequestService
        ↓
PeriodRequestRepository
        ↓
JDBC
        ↓
MySQL
```

The Service Layer should not contain raw SQL wherever possible.

Incorrect:

```text
PeriodRequestService
        ↓
SQL Query
        ↓
MySQL
```

Correct:

```text
PeriodRequestService
        ↓
PeriodRequestRepository
        ↓
JDBC
        ↓
MySQL
```

---

# 6. Database Connection

The application will use JDBC to connect Java to MySQL.

Conceptual flow:

```text
Java Application
      ↓
Connection Manager
      ↓
JDBC Driver
      ↓
MySQL Server
      ↓
Database
```

A centralized database connection/configuration approach should be used.

Possible structure:

```text
config/
    DatabaseConfig.java

util/
    DatabaseConnection.java
```

The exact implementation will be decided during backend development.

---

# 7. Database Naming Convention

Use consistent naming throughout the project.

Recommended:

```text
snake_case
```

Examples:

```text
user_id
student_id
faculty_id
department_id
class_id
subject_id
academic_year_id
semester_id
created_at
updated_at
```

Table names should also follow a consistent convention.

Recommended examples:

```text
users
students
faculties
departments
classes
subjects
timetables
assignments
notifications
```

The final naming convention will be fixed before SQL implementation.

---

# 8. Primary Keys

Each major entity should have a unique primary key.

Recommended approach:

```text
users.id
students.id
faculties.id
departments.id
classes.id
subjects.id
assignments.id
notifications.id
```

Primary keys should uniquely identify records.

Example:

```text
users
----------------
id  ← PRIMARY KEY
email
password_hash
role
```

---

# 9. Foreign Keys

Foreign keys will establish relationships between tables.

Example:

```text
students
    ↓
class_id
    ↓
classes.id
```

Another example:

```text
assignments
    ↓
subject_id
    ↓
subjects.id
```

Foreign keys help maintain referential integrity.

---

# 10. Core Database Domains

The database can be logically divided into domains.

```text
DATABASE
│
├── Identity & Access
│
├── Academic Structure
│
├── Timetable
│
├── Assignments
│
├── Examinations
│
├── Period Management
│
├── Notifications
│
└── Announcements
```

---

# 11. Identity & Access Domain

This domain manages authentication and user identity.

Conceptual entities:

```text
users
students
faculties
admins
```

Possible relationship:

```text
users
  │
  ├── student profile
  ├── faculty profile
  └── admin account
```

The exact inheritance/relationship strategy will be finalized in `entities.md`.

---

# 12. Academic Structure Domain

This domain represents the academic organization.

Conceptual entities:

```text
departments
academic_years
semesters
classes
subjects
```

Possible relationship:

```text
Department
    │
    ├── Classes
    ├── Faculty
    └── Subjects

Academic Year
    ↓
Semester
    ↓
Class
```

---

# 13. Timetable Domain

The timetable system has two important concepts:

```text
Master Timetable
        +
Temporary Timetable Change
        ↓
Effective Timetable
```

The master timetable represents the normal academic schedule.

Temporary timetable records represent approved temporary changes.

The temporary record must not overwrite the master timetable.

---

# 14. Master Timetable

The master timetable stores regular scheduling information.

Conceptually:

```text
Class
Subject
Faculty
Period
Day
Room
Academic Year
Semester
```

Example:

```text
S2 CSE
Monday
Period 3
Data Structures
Faculty A
Room 201
```

---

# 15. Temporary Timetable

Temporary timetable records represent approved changes caused by:

```text
Substitute Period
Borrowed Period
Other Approved Temporary Changes
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
```

The master timetable remains unchanged.

---

# 16. Effective Timetable

The timetable shown to users should be calculated using:

```text
Master Timetable
        +
Active Temporary Changes
        ↓
Effective Timetable
```

Example:

```text
Master:
Period 3 → Data Structures → Faculty A

Temporary:
Period 3 → Data Structures → Faculty B

Student sees:
Period 3 → Data Structures → Faculty B
```

For a borrowed period:

```text
Master:
Period 3 → Data Structures → Faculty A

Temporary:
Period 3 → OOP → Faculty B

Student sees:
Period 3 → OOP → Faculty B
```

---

# 17. Assignment Domain

The assignment domain stores:

```text
Assignment
Assignment Question
Assignment Attachment
Deadline
Class
Subject
Faculty
```

Assignments should be connected to the academic structure.

Conceptually:

```text
Faculty
   ↓
Assignment
   ↓
Subject
   ↓
Class
```

The deadline is also used by the Calendar and Notification modules.

---

# 18. Assignment Attachment

Assignments may contain:

```text
Text Question
Image
Document
Other Supported File
```

The database should store metadata rather than unnecessarily storing large files directly in normal relational columns.

Possible metadata:

```text
attachment_id
assignment_id
file_name
file_type
file_path / storage_reference
uploaded_at
```

The exact file-storage approach will be finalized during implementation.

---

# 19. Assignment and Calendar Relationship

An assignment deadline can appear as a calendar event.

```text
Assignment
    ↓
Deadline
    ↓
Calendar
    ↓
Student
```

The calendar can derive the deadline from assignment data instead of duplicating the same deadline unnecessarily.

---

# 20. Examination Domain

The examination domain stores:

```text
Exam
Exam Timetable
Class
Subject
Date
Time
Room
```

Conceptually:

```text
Exam
 ↓
Exam Timetable
 ↓
Class
Subject
```

Published examination schedules can generate notifications.

---

# 21. Period Management Domain

The Period Management domain stores:

```text
Period Requests
Request Type
Requester Faculty
Receiving Faculty
Original Timetable
Requested Subject
Request Note
Reply Note
Status
```

Request types:

```text
SUBSTITUTE
BORROW
```

---

# 22. Substitute Request Database Concept

A substitute request represents:

```text
Requester:
Faculty A

Receiver:
Faculty B

Original Subject:
Data Structures

Temporary Faculty:
Faculty B
```

The subject remains the original subject.

---

# 23. Borrow Request Database Concept

A borrow request represents:

```text
Requester:
Faculty B

Original Faculty:
Faculty A

Original Subject:
Data Structures

Borrowed Subject:
OOP

Temporary Faculty:
Faculty B
```

The borrowed period uses the requesting faculty's subject.

---

# 24. Notification Domain

The notification domain stores notification records.

Supported channels:

```text
IN_APP
EMAIL
WHATSAPP
```

Possible information:

```text
User
Event Type
Channel
Title
Message
Status
Created At
Sent At
Delivered At
Read At
Retry Count
Provider Message ID
Error Information
```

The exact fields will be finalized in `table-structure.md`.

---

# 25. Notification Preferences

Notification preferences allow users to control supported channels.

Example:

```text
Student
│
├── In-App     ON
├── Email      ON
└── WhatsApp   OFF
```

The preference data should be stored separately from the user's academic data.

---

# 26. WhatsApp Data

The database should not store WhatsApp API credentials.

It may store:

```text
User Phone Number
WhatsApp Enabled
Provider Message ID
Delivery Status
```

Credentials such as:

```text
API Key
Access Token
Client Secret
```

must remain in secure server-side configuration.

---

# 27. Announcement Domain

Announcements are created by authorized administrators.

Possible data:

```text
Announcement
Title
Content
Created By
Target Audience
Published At
Status
```

Announcements can generate notifications.

---

# 28. Relationship Between Major Domains

```text
                       ACADEMIC STRUCTURE
                              │
             ┌────────────────┼────────────────┐
             ↓                ↓                ↓
          Classes          Subjects         Faculty
             │                │                │
             └────────────────┼────────────────┘
                              ↓
                         TIMETABLE
                              │
                    ┌─────────┴─────────┐
                    ↓                   ↓
              Master Schedule     Temporary Change
                    │                   │
                    └─────────┬─────────┘
                              ↓
                       Effective Schedule
                              │
                ┌─────────────┼─────────────┐
                ↓             ↓             ↓
             Students      Faculty       Calendar
                              │
                              ↓
                       Period Management
                              │
                              ↓
                         Notifications


             FACULTY
                ↓
           ASSIGNMENTS
                ↓
           DEADLINES
                ↓
             CALENDAR
                ↓
          NOTIFICATIONS


             ADMIN
                ↓
        EXAM TIMETABLE
                ↓
           CALENDAR
                ↓
          NOTIFICATIONS
```

---

# 29. Normalization Strategy

The database should follow relational normalization principles.

The initial target is:

```text
1NF
2NF
3NF
```

The design should avoid unnecessary duplication.

Example of poor design:

```text
assignment
-------------------------------------------------
assignment_id
student1_name
student2_name
student3_name
student4_name
```

Better design:

```text
assignments
students
classes
```

with relationships between them.

---

# 30. Avoiding Data Duplication

Do not duplicate information unnecessarily.

For example, avoid storing:

```text
student_name
student_email
student_department
student_class
```

inside every assignment record.

Instead:

```text
assignments
      ↓
class_id
      ↓
classes
      ↓
students
```

This keeps the data consistent.

---

# 31. Historical Data

The system should preserve important historical records.

Examples:

```text
Assignment History
Period Request History
Notification History
Timetable Changes
Announcements
```

Instead of deleting important records unnecessarily, status fields may be used.

Example:

```text
ACTIVE
INACTIVE
CANCELLED
```

This allows auditing and future reporting.

---

# 32. Master vs Temporary Data

This is one of the most important database design rules for the timetable system.

Do not do:

```text
UPDATE master_timetable
SET faculty_id = ...
```

just because a substitute request was accepted.

Instead:

```text
master_timetable
        +
temporary_timetable
        ↓
effective_timetable
```

This preserves the original schedule.

---

# 33. Transaction Requirements

Some operations involve multiple database changes and should be handled as transactions.

Example:

```text
Accept Period Request
        ↓
Update Request Status
        ↓
Create Temporary Timetable
        ↓
Create Notification
```

These operations may need transactional handling.

Conceptually:

```text
BEGIN TRANSACTION

Update Period Request
        ↓
Create Temporary Change
        ↓
Create Notification Records

COMMIT
```

If a critical database operation fails:

```text
ROLLBACK
```

The exact transaction boundaries will be defined during Service and Repository implementation.

---

# 34. Referential Integrity

The database should prevent invalid references.

Example:

```text
assignment.class_id
        ↓
classes.id
```

If a class does not exist, an assignment should not reference it.

Similarly:

```text
period_request.requester_faculty_id
        ↓
faculties.id
```

---

# 35. Delete Strategy

Important academic records should not always be physically deleted.

Possible strategies:

```text
ACTIVE / INACTIVE
```

or:

```text
is_deleted
```

depending on the entity.

For example:

```text
Faculty Account
    ↓
Deactivate
```

rather than deleting historical assignment and timetable relationships.

The exact deletion strategy will be finalized per entity.

---

# 36. Date and Time Storage

The database must distinguish:

```text
Date
Time
Date + Time
```

Examples:

```text
Assignment Deadline → Date + Time
Exam Date → Date
Exam Start Time → Time
Period Start / End → Time
Created At → Date + Time
```

Timezone handling should be standardized across the backend and database.

---

# 37. Academic Period Representation

The system should not rely only on hard-coded period numbers.

A period may contain:

```text
Period ID
Period Number
Start Time
End Time
```

Example:

```text
Period 1
09:00 - 10:00

Period 2
10:00 - 11:00
```

This makes timetable rendering easier.

---

# 38. Academic Year and Semester

Academic structure should be represented explicitly.

Conceptually:

```text
Academic Year
      ↓
Semester
      ↓
Class
      ↓
Subjects
```

Example:

```text
2026-2027
    ↓
S3
    ↓
S3 CSE
```

The exact relationship will be finalized in `entities.md`.

---

# 39. Department Structure

A department can have:

```text
Faculty
Classes
Subjects
```

Conceptually:

```text
Department
│
├── Faculty
│
├── Classes
│
└── Subjects
```

This avoids repeating department information in every unrelated record.

---

# 40. Class Structure

A class represents an academic student group.

Possible attributes:

```text
Class ID
Class Name
Department
Semester
Academic Year
Section
```

Students belong to a class.

---

# 41. Faculty Structure

Faculty records can contain:

```text
Faculty ID
User ID
Employee Identifier
Department
```

Faculty-subject relationships may require a separate mapping table if a faculty member can teach multiple subjects.

---

# 42. Student Structure

Student records can contain:

```text
Student ID
User ID
Register Number
Class ID
Admission Year
```

The exact fields will be finalized in `table-structure.md`.

---

# 43. User Account Structure

A central user table can manage authentication.

Conceptually:

```text
users
------------------------
id
email
password_hash
role
status
created_at
updated_at
```

Profile-specific information can be stored in separate tables.

---

# 44. Why Separate User and Profile Tables?

A central user account can provide authentication while profile tables provide role-specific information.

```text
users
  │
  ├── students
  ├── faculties
  └── admins
```

Advantages:

```text
Authentication centralized
Role-specific data separated
Less duplication
Clear relationships
Future extensibility
```

The exact implementation will be decided in `entities.md`.

---

# 45. Database Security

Database security requirements:

```text
1. Never expose database credentials to the frontend.
2. Never place database passwords in JSP.
3. Use server-side configuration.
4. Use PreparedStatement for SQL parameters.
5. Validate user input.
6. Enforce authorization in backend code.
7. Use least-privilege database credentials.
8. Do not store plain-text passwords.
9. Store password hashes.
10. Avoid logging sensitive information.
```

---

# 46. SQL Injection Protection

All dynamic values must use prepared statements.

Incorrect:

```java
String sql =
    "SELECT * FROM users WHERE email = '" + email + "'";
```

Correct:

```java
String sql =
    "SELECT * FROM users WHERE email = ?";

PreparedStatement ps =
    connection.prepareStatement(sql);

ps.setString(1, email);
```

Repository classes should consistently follow this approach.

---

# 47. Password Storage

Passwords must never be stored as plain text.

Incorrect:

```text
password = "mypassword123"
```

Correct concept:

```text
password
    ↓
Password Hashing
    ↓
Stored Hash
```

The authentication implementation will use an appropriate password-hashing algorithm.

---

# 48. Database Indexing Overview

Indexes will be added where they improve common queries.

Likely candidates:

```text
users.email
students.register_number
assignments.class_id
assignments.deadline
timetable.class_id
timetable.faculty_id
period_requests.receiver_faculty_id
period_requests.status
notifications.user_id
notifications.status
```

The exact indexes will be documented in:

```text
indexes.md
```

Indexes should not be added blindly because excessive indexes increase write cost.

---

# 49. Database Scalability

The initial system is a college mini-project, but the database should be designed so that it can grow.

Future scale may include:

```text
More Departments
More Students
More Faculty
Multiple Academic Years
Multiple Semesters
Large Assignment History
Large Notification History
Mobile Applications
REST APIs
```

A normalized relational structure will make this easier to maintain.

---

# 50. Future API Support

The database should not be tightly coupled to JSP.

The intended architecture is:

```text
             ┌── JSP Web Frontend
             │
MySQL ← Repository ← Service ← Backend
             │
             ├── Future REST API
             │
             ├── Future Mobile App
             │
             └── Future Desktop App
```

This is important because the project is planned to expand beyond the initial web application.

---

# 51. Database Backup Considerations

For development:

```text
mysqldump
```

or an equivalent database backup method can be used.

Important data includes:

```text
Users
Academic Structure
Timetables
Assignments
Exams
Period Requests
Notifications
Announcements
```

The production backup strategy can be designed later.

---

# 52. Development Database Environment

Recommended separation:

```text
Development Database
        ↓
Testing Database
        ↓
Production Database
```

For the 20-day mini-project, development and testing may initially use separate schemas/databases if practical.

Production credentials should never be committed to Git.

---

# 53. Environment Configuration

Database configuration should be externalized.

Conceptually:

```text
DB_HOST
DB_PORT
DB_NAME
DB_USERNAME
DB_PASSWORD
```

Do not hard-code sensitive credentials in Java source code.

Example:

```text
application.properties
```

or environment variables can be used depending on the chosen project configuration.

---

# 54. Database Versioning

As the project grows, database schema changes should be tracked.

Example future structure:

```text
database/
├── schema/
├── seed/
└── migrations/
```

For the initial mini-project, SQL scripts can be maintained in the repository.

---

# 55. Seed Data

Development seed data can be used to test the application.

Example:

```text
Admin
Faculty
Students
Departments
Classes
Subjects
Periods
Timetable
Assignments
Exam Timetable
```

Seed data must be clearly separated from production data.

---

# 56. Database Testing

Database testing should verify:

```text
Insert
Update
Delete / Deactivate
Select
Relationships
Foreign Keys
Constraints
Transactions
Duplicate Prevention
Authorization-related queries
```

Example:

```text
Create Assignment
 ↓
Verify Assignment Row
 ↓
Verify Class Relationship
 ↓
Verify Subject Relationship
 ↓
Verify Faculty Relationship
```

---

# 57. Repository Testing

Repository methods should be tested independently where practical.

Example:

```text
PeriodRequestRepository
    ↓
createRequest()
    ↓
MySQL
    ↓
Verify Record
```

Similarly:

```text
AssignmentRepository
NotificationRepository
TimetableRepository
StudentRepository
FacultyRepository
```

---

# 58. Database Design Workflow

The database phase should follow this order:

```text
Database Overview
        ↓
Identify Entities
        ↓
Define Relationships
        ↓
Create ER Diagram
        ↓
Normalize
        ↓
Define Tables
        ↓
Define Columns
        ↓
Define PK / FK
        ↓
Define Constraints
        ↓
Define Indexes
        ↓
Write SQL
        ↓
Insert Seed Data
        ↓
Connect JDBC
        ↓
Test Repository Layer
```

---

# 59. Database Design Documents

The complete database-design documentation will be:

```text
03-database-design/
│
├── database-overview.md
├── entities.md
├── relationships.md
├── er-diagram.md
├── database-schema.md
├── table-structure.md
├── constraints.md
└── indexes.md
```

Each document has a separate purpose.

---

# 60. Database Overview → Entity Design

This document defines the overall direction.

The next document:

```text
entities.md
```

will identify every entity and explain:

```text
Entity Name
Purpose
Attributes
Primary Key
Important Relationships
```

Example:

```text
Entity:
Assignment

Purpose:
Stores academic assignments created by faculty.

Main Attributes:
id
title
description
deadline
faculty_id
class_id
subject_id
status
created_at
updated_at
```

---

# 61. Database Overview → Relationship Design

After entities are identified:

```text
entities.md
        ↓
relationships.md
```

Relationships will define:

```text
One-to-One
One-to-Many
Many-to-Many
```

Examples:

```text
Department 1 ──── * Faculty

Department 1 ──── * Class

Class 1 ──── * Student

Class * ──── * Subject
```

Many-to-many relationships will normally require junction tables.

---

# 62. Database Overview → ER Diagram

After relationships:

```text
relationships.md
        ↓
er-diagram.md
```

The ER design will show the actual relationships between the database entities.

This must be completed before writing the final SQL schema.

---

# 63. Database Overview → Schema

After ER design:

```text
ER Diagram
     ↓
database-schema.md
     ↓
table-structure.md
     ↓
constraints.md
     ↓
indexes.md
```

This creates a controlled path from concept to implementation.

---

# 64. Final Database Architecture

```text
                           MYSQL DATABASE
                                  │
        ┌─────────────────────────┼─────────────────────────┐
        ↓                         ↓                         ↓
 Identity & Access       Academic Structure            Timetable
        │                         │                         │
        ↓                         ↓                         ↓
 Users / Profiles       Departments / Classes      Master Timetable
                         Subjects / Semester       Temporary Timetable
                                                        │
                                                        ↓
                                                 Effective Schedule
        │                         │                         │
        └─────────────────────────┼─────────────────────────┘
                                  ↓
                         Academic Operations
                                  │
                 ┌────────────────┼────────────────┐
                 ↓                ↓                ↓
             Assignment         Exam        Period Management
                 │                │                │
                 └────────────────┼────────────────┘
                                  ↓
                            Notifications
                                  │
                         ┌────────┼────────┐
                         ↓        ↓        ↓
                      In-App   Email   WhatsApp
                                  │
                                  ↓
                           Notification Data
                                  │
                                  ↓
                            Announcements
```

---

# 65. Final Database Principles

The project will follow these principles:

1. MySQL is the primary relational database.
2. JDBC is used for Java-to-MySQL communication.
3. The Repository Layer owns database access.
4. The Service Layer owns business rules.
5. Servlets handle HTTP requests and responses.
6. JSP must not directly access the database.
7. Primary keys uniquely identify records.
8. Foreign keys maintain relationships.
9. The database should target 3NF where practical.
10. Duplicate data should be minimized.
11. Master timetable data must remain separate from temporary changes.
12. Temporary timetable changes must preserve the original schedule.
13. Transactions must protect multi-step critical operations.
14. Prepared statements must be used for dynamic SQL.
15. Passwords must be stored as secure hashes.
16. Database credentials must remain server-side.
17. Notification credentials must remain server-side.
18. WhatsApp API credentials must never be stored in the database as plain configuration data.
19. Important historical records should be preserved where required.
20. Indexes should be created based on real query patterns.
21. Database schema changes should be tracked.
22. Seed data should be separated from production data.
23. The schema should support future web, mobile, and desktop clients.
24. Exact entity relationships will be finalized before SQL implementation.
25. The final database should be simple enough to implement within the 20-day mini-project while remaining professionally structured.

---
