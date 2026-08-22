# System Features

## 1. Overview

The Campus Management System will provide a centralized platform for managing academic information and activities for students, faculty members, and administrators.

The system will consist of the following major feature modules:

1. Authentication and User Management
2. Student Management
3. Faculty Management
4. Academic Structure Management
5. Class Timetable Management
6. Examination Timetable Management
7. Assignment and Deadline Management
8. Academic Calendar
9. Faculty Period Management
10. Attendance Management
11. Marks and Result Management
12. Notification Management
13. Announcement Management
14. Profile Management
15. Database and Record Management

---

# 2. Authentication and User Management

The system will provide secure authentication for different types of users.

### Features

* User login
* Logout
* Role identification
* Role-based access
* Password management
* User account activation/deactivation
* User information management

### Supported roles

```text
Student
Faculty
Admin
```

---

# 3. Student Management

The system will maintain academic and personal information of students.

### Features

* Add student
* View student
* Update student information
* Assign student to department
* Assign student to class/division
* Assign academic year and semester
* View student profile
* Manage student account

---

# 4. Faculty Management

The system will maintain faculty information and teaching assignments.

### Features

* Add faculty
* View faculty
* Update faculty information
* Assign department
* Assign subjects
* Assign classes
* View faculty profile
* Manage faculty account

---

# 5. Academic Structure Management

The administrator will manage the academic structure used throughout the system.

### Features

* Department management
* Academic year management
* Semester management
* Class/division management
* Subject management
* Faculty-subject assignment
* Student-class assignment

The academic structure will be used by other modules such as timetable, assignments, attendance, and results.

---

# 6. Class Timetable Management

The system will provide a timetable management system for classes.

## Admin Features

Admin can:

* Create class timetable
* Select department
* Select semester
* Select class/division
* Select subject
* Assign faculty
* Assign room
* Set day
* Set start time
* Set end time
* Update timetable
* Delete timetable entry
* View timetable

The system should detect timetable conflicts.

## Student Features

Students can:

* View their class timetable
* View subject
* View faculty
* View room
* View day and time
* View temporary timetable changes

## Faculty Features

Faculty can:

* View their teaching timetable
* View assigned classes
* View assigned subjects
* View rooms
* View temporary changes

---

# 7. Examination Timetable

Administrators can create and manage examination schedules.

### Features

* Create examination schedule
* Select class
* Select subject
* Set examination date
* Set examination time
* Assign examination information
* Update examination schedule
* Delete examination schedule
* Publish examination timetable

Students and faculty can view relevant examination schedules.

---

# 8. Assignment and Deadline Management

Faculty members can create academic tasks and assign deadlines.

### Supported academic tasks

* Assignment
* Project
* Notebook submission
* Other academic submissions

### Assignment information

Each assignment can contain:

* Assignment ID
* Title
* Description
* Subject
* Class
* Faculty
* Question text
* Question image
* Uploaded document
* Submission date
* Submission time
* Creation date

### Faculty features

Faculty can:

* Create assignment
* Edit assignment
* Delete assignment
* Upload question
* Set deadline
* Change deadline where permitted
* View assignments

### Student features

Students can:

* View assignments
* View questions
* View uploaded files
* View submission deadline
* View assignment status

---

# 9. Academic Calendar

The system will provide a calendar for students and faculty.

### Calendar events can include:

* Assignment deadlines
* Project deadlines
* Notebook submission dates
* Examination dates
* Announcements
* Temporary timetable changes
* Other academic events

### Student calendar

Students will be able to see important academic deadlines in calendar format.

Example:

```text
August 2026

Mon   Tue   Wed   Thu   Fri

17    18    19    20    21
          📌 Exam

24    25    26    27    28
     📌 Assignment
```

Selecting an event will display its details.

---

# 10. Faculty Period Management

This module will manage temporary changes to teaching periods.

There will be two major operations:

## 10.1 Substitute Period Request

A faculty member can request another faculty member to take their assigned period.

Example:

```text
Original:

10:00 – 11:00
S2 CSE
Data Structures
Teacher A
```

Teacher A requests Teacher B to take the class.

If Teacher B accepts:

```text
10:00 – 11:00
S2 CSE
Data Structures
Teacher B
```

The **subject remains the same**, while the faculty member temporarily changes.

---

## 10.2 Borrow Period

A faculty member can request another faculty member's period to conduct their **own subject**.

Example:

```text
Original:

10:00 – 11:00
S2 CSE
Data Structures
Teacher A
```

Teacher B requests to borrow the period to teach OOP.

If Teacher A accepts:

```text
10:00 – 11:00
S2 CSE
OOP
Teacher B
```

The student's timetable will display the temporary change.

---

## 10.3 Period Request Features

Faculty members can:

* Select a period
* Select another faculty member
* Specify request type
* Add an optional message
* Send request
* View sent requests
* View received requests
* Accept request
* Reject request
* Add optional reply note
* View request status
* View request history

### Request statuses

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

---

# 11. Attendance Management

Faculty members will be able to record attendance.

### Faculty features

* Select class
* Select subject
* Select date
* View student list
* Mark present/absent
* Update attendance where permitted
* View attendance records

### Student features

* View attendance
* View subject-wise attendance
* View attendance percentage
* View attendance history

---

# 12. Marks and Result Management

The system will maintain academic marks and results.

### Faculty features

* Enter internal marks
* Update marks
* View marks
* Submit marks for processing

### Admin features

* View submitted results
* Verify results
* Update results where authorized
* Publish results

### Student features

Students can view:

* Subject marks
* Internal marks
* Examination marks
* Total marks
* Grade
* Semester result
* SGPA
* CGPA

---

# 13. Notification Management

The system will provide a centralized notification system.

## Notification channels

```text
Notification
     │
 ┌───┼──────────────┐
 ↓   ↓              ↓
App Email        WhatsApp
```

### Notification events

Notifications can be generated for:

* New assignments
* Upcoming deadlines
* Assignment deadline reminders
* Examination schedules
* Timetable changes
* Substitute requests
* Borrow-period requests
* Accepted requests
* Rejected requests
* Announcements
* Other important academic events

### In-application notifications

Users will have a notification section where they can:

* View notifications
* Mark notifications as read
* View notification details

---

# 14. Announcement Management

The system will allow authorized users to communicate academic information.

### Faculty announcements

Faculty can publish announcements to their authorized classes or subjects.

### Admin announcements

Admin can publish:

* College-wide announcements
* Department announcements
* Class announcements
* Academic announcements

Students and faculty can view relevant announcements.

---

# 15. Profile Management

Each user will have a profile.

### Student profile

May include:

* Name
* Student ID
* Email
* Department
* Semester
* Class/division
* Academic year

### Faculty profile

May include:

* Name
* Faculty ID
* Email
* Department
* Designation
* Assigned subjects

### Admin profile

May include:

* Name
* Admin ID
* Email
* Administrative role

---

# 16. Database and Record Management

The system will maintain centralized records using MySQL.

The database will contain information related to:

* Users
* Students
* Faculty
* Departments
* Classes
* Subjects
* Timetables
* Examinations
* Assignments
* Assignment files
* Attendance
* Marks
* Results
* Notifications
* Announcements
* Period requests

The application will use JDBC to perform database operations.

---

# 17. CRUD Operations

The system will demonstrate CRUD operations throughout appropriate modules.

```text
CREATE
   ↓
READ
   ↓
UPDATE
   ↓
DELETE
```

Examples:

### Admin

```text
Create Subject
Read Subject
Update Subject
Delete Subject
```

### Faculty

```text
Create Assignment
Read Assignment
Update Assignment
Delete Assignment
```

### Timetable

```text
Create Timetable
Read Timetable
Update Timetable
Delete Timetable
```

---

# 18. System-Level Features

The system will also include:

* Input validation
* Error handling
* Custom exceptions
* Database error handling
* Role-based access control
* Timetable conflict detection
* Period conflict detection
* User-friendly error messages
* Confirmation dialogs for important operations
* Search and filtering where appropriate

---

# 19. Future Expansion Features

The architecture will allow future versions to include:

* Web application
* Mobile application
* Cloud deployment
* Advanced WhatsApp integration
* Automated email scheduling
* KTU marksheet upload and processing
* OCR-based result extraction
* Parent portal
* Online fee management
* Advanced analytics
* Chat and messaging
* Multi-college support
* AI-based academic assistance

These features are not required for the initial implementation but are part of the long-term vision of the system.

---

# 20. Feature Relationship

The major modules are interconnected:

```text
                    CAMPUS MANAGEMENT SYSTEM
                              │
        ┌─────────────────────┼─────────────────────┐
        ↓                     ↓                     ↓
     STUDENT               FACULTY                ADMIN
        │                     │                     │
        ├─ Timetable         ├─ Timetable          ├─ Timetable
        ├─ Calendar          ├─ Assignments        ├─ Exam Timetable
        ├─ Assignments       ├─ Attendance         ├─ Users
        ├─ Attendance        ├─ Marks              ├─ Subjects
        ├─ Results           ├─ Period Requests    ├─ Classes
        ├─ Notifications     ├─ Announcements      ├─ Results
        └─ Announcements     └─ Notifications      └─ Announcements
                              │
                              ↓
                       CENTRAL DATABASE
                              │
                            MySQL
                              │
                            JDBC
```
