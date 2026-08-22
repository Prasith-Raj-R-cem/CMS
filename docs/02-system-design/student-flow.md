# Student Flow

## 1. Overview

The Student Flow defines the complete workflow available to a student in the Campus Management System.

The student can:

- Log in securely
- View the student dashboard
- View class timetable
- View examination timetable
- View assignments and submission deadlines
- View deadlines through a calendar
- Receive notifications
- View attendance
- View results, marks, grades, SGPA and CGPA
- View announcements
- See temporary timetable changes caused by substitute or borrowed periods
- Manage profile information where permitted
- Log out securely

The student does not have permission to modify administrative data such as the master timetable, examination timetable, faculty accounts, or other students' records.

---

## 2. Student Architecture Flow

Every student operation follows the common application architecture:

```text
Student
   ↓
Browser
   ↓
HTML / CSS / JavaScript
   ↓
JSP
   ↓
Student Servlet / Feature Servlet
   ↓
Service Layer
   ↓
Repository Layer
   ↓
JDBC
   ↓
MySQL
   ↓
Repository
   ↓
Service
   ↓
Servlet
   ↓
JSP
   ↓
Browser
   ↓
Student
```

---

## 3. Student Login Flow

```text
                         STUDENT
                            │
                            ↓
                         Browser
                            │
                            ↓
                       Login Page
                         (JSP)
                            │
                            ↓
                  Enter Email / Password
                            │
                            ↓
                     LoginServlet
                            │
                            ↓
                      AuthService
                            │
                            ↓
                   UserRepository
                            │
                            ↓
                           JDBC
                            │
                            ↓
                          MySQL
                            │
                            ↓
                  Verify Credentials
                            │
                     ┌──────┴──────┐
                     ↓             ↓
                  INVALID         VALID
                     │             │
                     ↓             ↓
               Show Login Error  Create Session
                                   │
                                   ↓
                              Check Role
                                   │
                                   ↓
                                STUDENT
                                   │
                                   ↓
                         Student Dashboard
```

---

## 4. Student Session

After successful login, the system creates an HTTP session.

The session may contain:

```text
User ID
Username
Role
Student ID
```

Flow:

```text
Successful Login
      ↓
Create HTTP Session
      ↓
Store Student Information
      ↓
Redirect to Student Dashboard
      ↓
Access Student Modules
```

If the student tries to access a protected page without a valid session:

```text
Student
   ↓
Protected Page
   ↓
Session Check
   ↓
No Valid Session
   ↓
Redirect to Login
```

---

## 5. Student Dashboard

The Student Dashboard is the main entry point after login.

```text
                       STUDENT DASHBOARD
                              │
       ┌──────────────────────┼──────────────────────┐
       ↓                      ↓                      ↓
   Timetable              Assignments             Calendar
       │                      │                      │
       ↓                      ↓                      ↓
   Today's Classes       Pending Work          Upcoming Events
       │                      │                      │
       └──────────────────────┼──────────────────────┘
                              │
       ┌──────────────────────┼──────────────────────┐
       ↓                      ↓                      ↓
   Attendance              Results             Notifications
       │                      │                      │
       ↓                      ↓                      ↓
  Attendance %          Marks / Grades        Recent Alerts
       │                      │                      │
       └──────────────────────┼──────────────────────┘
                              ↓
                       Announcements
```

The dashboard may display summary information such as:

```text
Today's Classes
Upcoming Assignment
Nearest Deadline
Upcoming Exam
Attendance Percentage
Latest Result
Unread Notifications
Latest Announcement
```

---

## 6. Student Navigation

The student navigation structure is:

```text
Student Dashboard
│
├── Home
├── Timetable
│   ├── Class Timetable
│   └── Exam Timetable
│
├── Assignments
│   ├── All Assignments
│   ├── Pending
│   └── Completed / Submitted
│
├── Calendar
│
├── Attendance
│
├── Results
│
├── Notifications
│
├── Announcements
│
├── Profile
│
└── Logout
```

The exact pages and navigation items can be refined during the UI/UX design phase.

---

# 7. Student Timetable Flow

The student can view the timetable created by the administrator.

```text
Student
   ↓
Timetable Page
   ↓
TimetableServlet
   ↓
TimetableService
   ↓
TimetableRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Retrieve Timetable
   ↓
Apply Temporary Changes
   ↓
Return Timetable
   ↓
Timetable JSP
   ↓
Student
```

The timetable should display information such as:

```text
Day
Date
Period
Start Time
End Time
Subject
Faculty
Room
Status
```

Example:

```text
Monday

09:00 - 10:00
Data Structures
Faculty A
Room 201

10:00 - 11:00
OOP
Faculty B
Room 201
```

---

## 8. Temporary Timetable Changes

The student's timetable must reflect approved temporary changes.

There are two types:

1. Substitute Period
2. Borrowed Period

### Substitute

The subject remains the same, but the faculty member changes.

```text
Original:

Data Structures
Faculty A

        ↓

Approved Substitute

Data Structures
Faculty B
```

### Borrowed Period

Both the subject and faculty may change because another faculty member is using the period to teach their own subject.

```text
Original:

Data Structures
Faculty A

        ↓

Approved Borrow

OOP
Faculty B
```

The student should be able to identify temporary changes clearly.

Example:

```text
10:00 - 11:00
OOP
Faculty B

[Borrowed Period]
```

---

# 9. Timetable Temporary Change Flow

```text
Faculty Request
       ↓
Request Sent
       ↓
Other Faculty Accepts
       ↓
Period Request Approved
       ↓
Temporary Timetable Record
       ↓
Student Timetable Query
       ↓
Check Temporary Changes
       ↓
Apply Active Change
       ↓
Display Updated Timetable
```

The original timetable should remain preserved.

The temporary record should define the affected:

```text
Class
Date
Period
Original Subject
Original Faculty
Temporary Subject
Temporary Faculty
Change Type
```

---

# 10. Examination Timetable Flow

Students can view the examination timetable published by the administrator.

```text
Student
   ↓
Exam Timetable
   ↓
ExamTimetableServlet
   ↓
ExamService
   ↓
ExamRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Retrieve Published Exams
   ↓
Exam Timetable JSP
   ↓
Student
```

The exam timetable may display:

```text
Date
Day
Time
Subject
Exam Type
Room
```

Example:

```text
20-09-2026
Monday
09:30 AM - 12:30 PM
Data Structures
University Exam
Room 201
```

Only published examination schedules should be visible to students.

---

# 11. Assignment Flow

Students can view assignments assigned to their class.

```text
Student
   ↓
Assignments
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
AssignmentRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Retrieve Class Assignments
   ↓
Assignments JSP
   ↓
Student
```

The system should automatically determine the student's class and display relevant assignments.

---

# 12. Assignment Details

When the student selects an assignment:

```text
Student
   ↓
Select Assignment
   ↓
Assignment Details
```

The page may display:

```text
Assignment Title
Subject
Faculty
Description
Question Text
Question Image / File
Assigned Date
Submission Deadline
Submission Status
```

Example:

```text
Assignment:
OOP Mini Task

Subject:
Object Oriented Programming

Faculty:
Faculty B

Deadline:
25-09-2026
11:59 PM

Question:
Implement a Java program demonstrating inheritance.

Attachment:
question.jpg
```

---

# 13. Assignment Status

Each assignment can have a status based on its deadline and student activity.

Possible states:

```text
PENDING
DUE SOON
OVERDUE
COMPLETED
```

Example:

```text
Assignment
    │
    ↓
Check Deadline
    │
    ├── Future ──────→ PENDING
    │
    ├── Near Deadline → DUE SOON
    │
    └── Passed ──────→ OVERDUE
```

If submission functionality is implemented later, the status can additionally become:

```text
SUBMITTED
```

---

# 14. Student Calendar Flow

The calendar provides a centralized view of academic deadlines and events.

```text
Student
   ↓
Calendar
   ↓
CalendarServlet
   ↓
CalendarService
   ↓
Retrieve Events
   │
   ├── Assignment Deadlines
   ├── Examination Dates
   ├── Timetable Changes
   ├── Announcements
   └── Other Academic Events
   ↓
Calendar JSP
   ↓
Student
```

The calendar can provide:

```text
Month View
Week View
Day View
Event Details
```

---

# 15. Calendar Event Example

```text
                         CALENDAR
                            │
                            ↓
                      Select Date
                            │
                            ↓
                    View Day Events
                            │
              ┌─────────────┼─────────────┐
              ↓             ↓             ↓
         Assignment       Exam       Timetable
          Deadline        Date         Change
              │             │             │
              ↓             ↓             ↓
         View Details   View Details   View Details
```

Example:

```text
25 September

10:00 AM
OOP Class

11:59 PM
OOP Assignment Deadline

```

---

# 16. Deadline Notification Flow

The system can notify students about upcoming assignment deadlines.

```text
Assignment Deadline
        ↓
Check Current Date/Time
        ↓
Deadline Approaching?
        │
   ┌────┴────┐
   ↓         ↓
  YES        NO
   │         │
   ↓         ↓
Create      Continue
Notification
   │
   ├──────────────┬──────────────┐
   ↓              ↓              ↓
 In-App          Email        WhatsApp
   │              │              │
   └──────────────┼──────────────┘
                  ↓
               Student
```

The exact reminder timing will be defined later in the notification requirements.

---

# 17. Attendance Flow

Students can view their attendance records.

```text
Student
   ↓
Attendance Page
   ↓
AttendanceServlet
   ↓
AttendanceService
   ↓
AttendanceRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Retrieve Attendance
   ↓
Calculate / Retrieve Percentage
   ↓
Attendance JSP
   ↓
Student
```

The student may view:

```text
Subject
Total Classes
Present
Absent
Attendance Percentage
```

Example:

```text
Subject             Attendance

Data Structures     87%
OOP                 92%
Mathematics         78%
Physics             85%
```

---

# 18. Attendance Detail Flow

```text
Student
   ↓
Select Subject
   ↓
Attendance Details
   ↓
View Attendance Records
   ↓
Date-wise Information
```

Example:

```text
Date         Status

10-09-2026   Present
11-09-2026   Present
12-09-2026   Absent
15-09-2026   Present
```

Students will have read-only access to attendance records unless a separate correction/request feature is introduced.

---

# 19. Results Flow

Students can view results published by authorized faculty/admin users.

```text
Student
   ↓
Results
   ↓
ResultServlet
   ↓
ResultService
   ↓
ResultRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Retrieve Published Results
   ↓
Calculate / Retrieve Grade Data
   ↓
Results JSP
   ↓
Student
```

The result page may display:

```text
Subject
Marks
Grade
Credit
Grade Point
Semester
```

---

# 20. SGPA and CGPA Flow

```text
Published Results
       ↓
Retrieve Subject Credits
       ↓
Retrieve Grade Points
       ↓
Calculate SGPA
       ↓
Retrieve Previous Semester Results
       ↓
Calculate / Retrieve CGPA
       ↓
Display to Student
```

The exact calculation rules will follow the academic grading system used by the institution.

---

# 21. Notification Center Flow

Students can access all application notifications from a centralized notification page.

```text
Student
   ↓
Notifications
   ↓
NotificationServlet
   ↓
NotificationService
   ↓
NotificationRepository
   ↓
MySQL
   ↓
Retrieve Notifications
   ↓
Display Notification Center
```

Notification categories may include:

```text
Assignment
Deadline
Exam
Timetable
Period Change
Announcement
System
```

---

# 22. Notification Read Status

Notifications can have a read/unread state.

```text
New Notification
       ↓
Status = UNREAD
       ↓
Student Opens Notification
       ↓
NotificationServlet
       ↓
NotificationService
       ↓
NotificationRepository
       ↓
Status = READ
```

The dashboard can display:

```text
Notifications
Unread: 3
```

---

# 23. Announcement Flow

Students can view announcements published for their class, department, or the entire institution.

```text
Announcement Published
        ↓
Target Determined
        ↓
Student Matches Target?
        │
   ┌────┴────┐
   ↓         ↓
  YES        NO
   │         │
   ↓         ↓
Display     Ignore
Announcement
```

Possible announcement targets:

```text
All Students
Department
Class
Semester
Specific Group
```

---

# 24. Student Profile Flow

The student can view their profile information.

```text
Student
   ↓
Profile
   ↓
StudentServlet
   ↓
StudentService
   ↓
StudentRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Retrieve Profile
   ↓
Profile JSP
   ↓
Student
```

Profile information may include:

```text
Student ID
Name
Email
Department
Class
Semester
Academic Year
Phone Number
```

Editable fields and permissions will be defined during the requirements and database design phases.

---

# 25. Student Authorization

Students must only access information they are authorized to view.

```text
Student Request
       ↓
Session Validation
       ↓
Role Validation
       ↓
Resource Ownership / Class Validation
       ↓
Allow / Deny
```

Examples:

```text
Student A
   ↓
View Student A's Profile
   ↓
ALLOW
```

```text
Student A
   ↓
Attempt to modify another student's result
   ↓
DENY
```

```text
Student
   ↓
Attempt to access Admin Dashboard
   ↓
DENY
```

Authorization must be enforced on the server side.

---

# 26. Student Data Flow

The main student data flow is:

```text
                         MySQL
                           │
          ┌────────────────┼────────────────┐
          ↓                ↓                ↓
      Timetable        Assignments       Attendance
          │                │                │
          ↓                ↓                ↓
       Student          Student          Student
          │                │                │
          └────────────────┼────────────────┘
                           ↓
                       Dashboard
                           │
          ┌────────────────┼────────────────┐
          ↓                ↓                ↓
       Calendar         Results       Notifications
```

---

# 27. Student Read-Only Permissions

The student will generally have read access to:

```text
Class Timetable
Exam Timetable
Assignments
Assignment Questions
Assignment Deadlines
Calendar Events
Attendance
Published Results
Notifications
Announcements
Profile
```

The student should not directly modify:

```text
Master Timetable
Exam Timetable
Faculty Data
Other Student Data
Attendance Records
Published Results
System Configuration
```

If future modules require student actions such as assignment submission or attendance correction requests, those will be implemented through separate controlled workflows.

---

# 28. Student Logout Flow

```text
Student Dashboard
       ↓
Click Logout
       ↓
LogoutServlet
       ↓
Invalidate HTTP Session
       ↓
Clear Authentication State
       ↓
Redirect to Login Page
```

After logout:

```text
Student
   ↓
Browser Back Button
   ↓
Protected Page Request
   ↓
Session Validation
   ↓
No Valid Session
   ↓
Redirect to Login
```

---

# 29. Complete Student Flow

```text
                              START
                                │
                                ↓
                           Login Page
                                │
                                ↓
                       Enter Credentials
                                │
                                ↓
                        Authentication
                                │
                       ┌────────┴────────┐
                       ↓                 ↓
                    INVALID             VALID
                       │                 │
                       ↓                 ↓
                  Login Error       Create Session
                                         │
                                         ↓
                                  Student Dashboard
                                         │
        ┌────────────────────────────────┼────────────────────────────────┐
        ↓                ↓               ↓               ↓               ↓
   Timetable        Assignments       Calendar       Attendance        Results
        │                │               │               │               │
        ↓                ↓               ↓               ↓               ↓
 Class Timetable   Assignment List   Deadlines      Attendance %     Marks/Grades
 Exam Timetable    Questions/Files   Exam Dates     Subject Wise     SGPA/CGPA
 Temporary Changes Deadlines         Timetable
                                     Changes
        │                │               │               │               │
        └────────────────┴───────────────┴───────────────┴───────────────┘
                                         │
                                         ↓
                                  Notifications
                                         │
                          ┌──────────────┼──────────────┐
                          ↓              ↓              ↓
                       In-App          Email         WhatsApp
                          │              │              │
                          └──────────────┼──────────────┘
                                         ↓
                                   Announcements
                                         │
                                         ↓
                                      Profile
                                         │
                                         ↓
                                       Logout
                                         │
                                         ↓
                                    Login Page
```

---

# 30. Student Request Architecture

Every student module should follow the same request architecture.

```text
Student
   ↓
Browser
   ↓
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
   ↓
Repository
   ↓
Service
   ↓
Servlet
   ↓
JSP
   ↓
Browser
   ↓
Student
```

Examples:

```text
Timetable
    → TimetableServlet
    → TimetableService
    → TimetableRepository

Assignments
    → AssignmentServlet
    → AssignmentService
    → AssignmentRepository

Attendance
    → AttendanceServlet
    → AttendanceService
    → AttendanceRepository

Results
    → ResultServlet
    → ResultService
    → ResultRepository

Notifications
    → NotificationServlet
    → NotificationService
    → NotificationRepository
```

---

# 31. Student Flow Design Rules

The following rules will be maintained during implementation:

1. Students must authenticate before accessing protected pages.
2. Student permissions must be verified on the server side.
3. JSP pages must not directly access MySQL.
4. Servlets must not contain complex business logic.
5. Services must contain business rules.
6. Repositories must handle database operations.
7. JDBC must handle database connectivity.
8. Students can view only authorized academic information.
9. Temporary timetable changes must be reflected in the student's timetable.
10. Original timetable records must not be permanently overwritten for temporary changes.
11. Notifications should be generated from defined system events.
12. Published examination schedules and results should be read-only for students.
13. Logout must invalidate the active session.
14. Sensitive information must not be exposed through client-side code.

---

# 32. Final Student Module Flow

```text
                         STUDENT MODULE
                              │
                              ↓
                         Authentication
                              │
                              ↓
                       Student Dashboard
                              │
      ┌───────────────────────┼───────────────────────┐
      ↓                       ↓                       ↓
   Timetable              Assignments              Calendar
      │                       │                       │
      ↓                       ↓                       ↓
 Regular + Temporary      Questions + Files      Deadlines + Exams
      │                       │                       │
      └───────────────────────┼───────────────────────┘
                              │
      ┌───────────────────────┼───────────────────────┐
      ↓                       ↓                       ↓
  Attendance              Results              Notifications
      │                       │                       │
      ↓                       ↓                       ↓
 Attendance %            Marks / Grades        In-App / Email /
                                             WhatsApp
      │                       │                       │
      └───────────────────────┼───────────────────────┘
                              ↓
                       Announcements
                              │
                              ↓
                           Profile
                              │
                              ↓
                           Logout
```

This document defines the complete student-side workflow and will be used as the foundation for the **Student UI Design, Student Servlet Design, Student Service Design, Student Repository Design, and Database Design** phases.
