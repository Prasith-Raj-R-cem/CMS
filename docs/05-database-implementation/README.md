# Database Implementation

## 1. Overview

This folder contains the actual MySQL implementation of the Campus Management System database.

The database design was completed in:

```text
03-database-design/
```

The implementation is:

```text
05-database-implementation/
│
├── schema.sql
├── seed.sql
└── README.md
```

---

# 2. Files

## schema.sql

Creates the actual database structure.

It contains:

```text
Database
Tables
Primary Keys
Foreign Keys
Unique Constraints
CHECK Constraints
Default Values
Indexes
```

Run this first.

---

## seed.sql

Adds initial/development data.

It contains:

```text
Initial Admin
Departments
Academic Year
Semesters
Periods
Rooms
Sample Faculty
Sample Student
Subjects
Class-Subject Mapping
Faculty-Subject Mapping
Sample Timetable
Notification Preferences
```

Run this after `schema.sql`.

---

# 3. Technology

Database:

```text
MySQL 8+
```

Storage engine:

```text
InnoDB
```

Character set:

```text
utf8mb4
```

Collation:

```text
utf8mb4_unicode_ci
```

The Java backend will connect using:

```text
JDBC
```

---

# 4. Database Name

The application database is:

```text
campus_management
```

Connection format:

```text
jdbc:mysql://localhost:3306/campus_management
```

---

# 5. Recommended Installation

Install:

```text
MySQL Server 8+
MySQL Workbench
```

MySQL Workbench is optional but recommended for development because it makes it easier to:

```text
Run SQL
Inspect tables
View relationships
Test queries
Debug database errors
```

---

# 6. Create the Database

You do not need to manually create the database first.

`schema.sql` contains:

```sql
CREATE DATABASE IF NOT EXISTS campus_management;
```

Therefore the normal process is:

```text
Open MySQL
      ↓
Open schema.sql
      ↓
Execute
      ↓
campus_management created
```

---

# 7. Running schema.sql

Open:

```text
schema.sql
```

in MySQL Workbench.

Execute the entire file.

The script creates:

```text
users
departments
academic_years
semesters
classes
students
faculties
subjects
periods
rooms
faculty_subjects
class_subjects
timetables
assignments
assignment_attachments
exams
exam_timetables
period_requests
temporary_timetables
notification_preferences
notifications
announcements
```

---

# 8. Verify schema.sql

After executing:

```sql
USE campus_management;

SHOW TABLES;
```

You should see:

```text
academic_years
announcements
assignment_attachments
assignments
class_subjects
classes
departments
exam_timetables
exams
faculties
faculty_subjects
notification_preferences
notifications
period_requests
periods
rooms
semesters
students
subjects
temporary_timetables
timetables
users
```

The order shown by MySQL may be different.

---

# 9. Check Table Structure

Example:

```sql
DESCRIBE users;
```

```sql
DESCRIBE students;
```

```sql
DESCRIBE faculties;
```

```sql
DESCRIBE timetables;
```

```sql
DESCRIBE assignments;
```

This verifies that the expected columns were created.

---

# 10. Check Foreign Keys

Use:

```sql
SHOW CREATE TABLE timetables;
```

and:

```sql
SHOW CREATE TABLE period_requests;
```

and:

```sql
SHOW CREATE TABLE temporary_timetables;
```

You should see the foreign-key definitions.

---

# 11. Running seed.sql

Only run:

```text
seed.sql
```

after:

```text
schema.sql
```

has completed successfully.

Open:

```text
seed.sql
```

in MySQL Workbench and execute it.

The seed inserts development data.

---

# 12. Verify Seed Data

Run:

```sql
USE campus_management;
```

Then:

```sql
SELECT * FROM users;
```

```sql
SELECT * FROM departments;
```

```sql
SELECT * FROM academic_years;
```

```sql
SELECT * FROM semesters;
```

```sql
SELECT * FROM classes;
```

```sql
SELECT * FROM students;
```

```sql
SELECT * FROM faculties;
```

```sql
SELECT * FROM subjects;
```

```sql
SELECT * FROM periods;
```

```sql
SELECT * FROM rooms;
```

```sql
SELECT * FROM timetables;
```

---

# 13. Development Admin

`seed.sql` creates a development administrator:

```text
admin@campus.local
```

Important:

```text
The password is NOT stored in plaintext.
```

The seed currently contains a placeholder bcrypt hash:

```text
REPLACE_THIS_WITH_A_REAL_BCRYPT_HASH
```

Before testing login, generate a real password hash through the Java application.

Do not commit real production passwords to GitHub.

---

# 14. Development Faculty

The seed contains two development faculty accounts:

```text
faculty1@campus.local
faculty2@campus.local
```

Their password hashes are also placeholders and must be replaced before login testing.

---

# 15. Development Student

The seed contains:

```text
student1@campus.local
```

with register number:

```text
CSE2026001
```

The student belongs to:

```text
S3 CSE - A
```

---

# 16. Development Academic Data

The seed creates:

```text
Academic Year:
2026-2027
```

Example semesters:

```text
S1
S2
S3
```

Example department:

```text
CSE
Computer Science and Engineering
```

---

# 17. Period Configuration

The current project uses one common period configuration.

```text
Period 1 → 09:30 – 10:30
Period 2 → 10:40 – 11:40
Period 3 → 11:40 – 12:40
Period 4 → 13:20 – 14:20
Period 5 → 14:20 – 15:20
Period 6 → 15:30 – 16:30
```

Breaks are represented by gaps between periods.

For example:

```text
10:30 → 10:40
```

and:

```text
12:40 → 13:20
```

and:

```text
15:20 → 15:30
```

are not timetable periods.

If the college later changes the official period timings, update the period data rather than adding Friday-specific logic unless the project requirements change.

---

# 18. Database Reset During Development

If you need to completely reset the development database, you can use:

```sql
DROP DATABASE campus_management;
```

Then:

```text
1. Run schema.sql
2. Run seed.sql
```

This should only be done during development.

Never use this approach on a production database.

---

# 19. Recommended Development Workflow

Every team member should follow:

```text
Clone Git repository
        ↓
Install MySQL
        ↓
Run schema.sql
        ↓
Run seed.sql
        ↓
Verify tables
        ↓
Configure Java database connection
        ↓
Start backend
```

This ensures everyone uses the same database structure.

---

# 20. Database Credentials

Do not hard-code production credentials in:

```text
schema.sql
seed.sql
GitHub
Java source code
```

For development, the Java application may use:

```text
DB_URL
DB_USERNAME
DB_PASSWORD
```

through configuration/environment variables.

Example:

```text
DB_URL=jdbc:mysql://localhost:3306/campus_management
DB_USERNAME=root
DB_PASSWORD=your_password
```

The actual password should not be committed to Git.

---

# 21. Java JDBC Connection

Later the Java backend will use something similar to:

```java
String url =
    "jdbc:mysql://localhost:3306/campus_management";

String username = "...";
String password = "...";

Connection connection =
    DriverManager.getConnection(
        url,
        username,
        password
    );
```

This code belongs to the Java backend, not this database folder.

---

# 22. Database Architecture

The final backend flow will be:

```text
JSP
 ↓
Servlet / Controller
 ↓
Service
 ↓
Repository
 ↓
JDBC
 ↓
MySQL
```

Example:

```text
Login.jsp
    ↓
LoginServlet
    ↓
UserService
    ↓
UserRepository
    ↓
users table
```

---

# 23. Repository Layer

The Repository Layer is responsible for database interaction.

Examples:

```text
UserRepository
StudentRepository
FacultyRepository
ClassRepository
SubjectRepository
TimetableRepository
AssignmentRepository
ExamRepository
PeriodRequestRepository
NotificationRepository
```

Repository classes will contain SQL queries such as:

```sql
SELECT
INSERT
UPDATE
DELETE
JOIN
```

`schema.sql` creates the tables that these repositories will work with.

---

# 24. Important Separation

Do not put SQL directly inside JSP.

Bad:

```text
JSP
 ↓
SQL
 ↓
MySQL
```

Correct:

```text
JSP
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

This separation will make the project easier to maintain and expand later.

---

# 25. Database Testing Before Java

Before starting the Repository Layer, manually test basic SQL operations.

Example:

```sql
SELECT *
FROM users
WHERE email = 'admin@campus.local';
```

Example:

```sql
SELECT *
FROM students;
```

Example:

```sql
SELECT *
FROM timetables
ORDER BY day_of_week, period_id;
```

Example:

```sql
SELECT *
FROM assignments
ORDER BY deadline;
```

If these work, the database is ready for Java integration.

---

# 26. Team Development

Because this is a group project, all backend developers should use the same:

```text
Database name
Table names
Column names
Foreign keys
Status values
Role values
Repository naming
```

Do not allow one team member to create:

```text
student_table
```

while another expects:

```text
students
```

The database design documents are the source of truth.

---

# 27. Git Workflow

Recommended repository structure:

```text
Campus-Management-System/
│
├── 01-project-planning/
├── 02-system-design/
├── 03-database-design/
├── 04-syllabus/
├── 05-database-implementation/
│   ├── schema.sql
│   ├── seed.sql
│   └── README.md
│
└── backend/
```

Commit database changes separately.

Example:

```text
feat(database): add initial mysql schema
```

and:

```text
feat(database): add development seed data
```

---

# 28. When Database Schema Changes

If the team changes a table later:

```text
Do not silently modify the design.
```

Update:

```text
03-database-design/
```

first.

Then update:

```text
05-database-implementation/
```

This keeps:

```text
Documentation
      =
Actual Database
```

consistent.

---

# 29. Current Database Status

```text
[✓] Database design completed
[✓] Table structure completed
[✓] Constraints completed
[✓] Indexes completed
[✓] schema.sql created
[✓] seed.sql created
[ ] Run schema.sql in MySQL
[ ] Run seed.sql in MySQL
[ ] Verify database
[ ] Connect Java using JDBC
```

---

# 30. Next Development Stage

After the database is successfully tested, move to:

```text
06-backend/
```

Recommended initial structure:

```text
06-backend/
│
├── pom.xml
│
└── src/
    └── main/
        ├── java/
        │   ├── controller/
        │   ├── service/
        │   ├── repository/
        │   ├── model/
        │   ├── dto/
        │   ├── util/
        │   └── filter/
        │
        └── webapp/
            ├── WEB-INF/
            ├── css/
            ├── js/
            └── jsp/
```

The first backend task will be:

```text
DatabaseConnection.java
```

Then:

```text
Connection Test
      ↓
UserRepository
      ↓
UserService
      ↓
Login
      ↓
Authentication
```

---

# 31. Final Rule

The database is now considered the foundation of the backend.

Do not start writing random Java SQL queries before confirming:

```text
schema.sql
      ↓
MySQL
      ↓
Tables created successfully
      ↓
seed.sql
      ↓
Development data inserted
      ↓
Basic SQL queries tested
```

Once this succeeds, we can safely begin the Java Repository Layer.
