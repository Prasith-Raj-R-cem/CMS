# System Flowchart

## 1. Overview

The System Flowchart represents the complete workflow of the Campus Management System from application access and authentication to role-based functionality and logout.

The system supports three primary users:

- Student
- Faculty
- Admin

The application is accessed through a web browser and follows the architecture:

```text
Browser
   ↓
HTML + CSS + JavaScript
   ↓
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

---

## 2. Complete System Flow

```text
                         ┌───────────────┐
                         │     START     │
                         └───────┬───────┘
                                 ↓
                    ┌────────────────────────┐
                    │    Open Web Browser    │
                    └────────────┬───────────┘
                                 ↓
                    ┌────────────────────────┐
                    │      Login Page        │
                    │     (JSP + HTML)       │
                    └────────────┬───────────┘
                                 ↓
                    ┌────────────────────────┐
                    │ Enter Username/Email   │
                    │      + Password        │
                    └────────────┬───────────┘
                                 ↓
                    ┌────────────────────────┐
                    │     LoginServlet       │
                    └────────────┬───────────┘
                                 ↓
                    ┌────────────────────────┐
                    │      AuthService       │
                    └────────────┬───────────┘
                                 ↓
                    ┌────────────────────────┐
                    │    UserRepository      │
                    └────────────┬───────────┘
                                 ↓
                              JDBC
                                 ↓
                             MySQL
                                 ↓
                    ┌────────────────────────┐
                    │ Credentials Valid?     │
                    └────────────┬───────────┘
                          ┌──────┴──────┐
                          ↓             ↓
                        NO             YES
                          │             │
                          ↓             ↓
                 ┌──────────────┐  ┌───────────────┐
                 │ Show Error   │  │ Identify Role │
                 └──────┬───────┘  └───────┬───────┘
                        │                   │
                        │          ┌────────┼────────┐
                        │          ↓        ↓        ↓
                        │       Student  Faculty   Admin
                        │          │        │        │
                        │          ↓        ↓        ↓
                        │      Dashboard Dashboard Dashboard
                        │          │        │        │
                        └──────────┐│        │        │
                                   ││        │        │
                                   ↓↓        ↓        ↓
                              Role-Specific Modules
                                         │
                                         ↓
                                       Logout
                                         │
                                         ↓
                                    Login Page
```

---

## 3. Authentication Flow

```text
                         LOGIN PAGE
                             │
                             ↓
                    Enter Credentials
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
                       ┌─────┴─────┐
                       ↓           ↓
                    INVALID       VALID
                       │           │
                       ↓           ↓
                 Show Error    Create Session
                                   │
                                   ↓
                              Get User Role
                                   │
                    ┌──────────────┼──────────────┐
                    ↓              ↓              ↓
                 STUDENT        FACULTY          ADMIN
                    │              │              │
                    ↓              ↓              ↓
              Student JSP     Faculty JSP      Admin JSP
```

---

## 4. Student Flow

After successful authentication, the student is redirected to the Student Dashboard.

```text
                       STUDENT LOGIN
                              │
                              ↓
                     Student Dashboard
                              │
          ┌───────────────────┼───────────────────┐
          ↓                   ↓                   ↓
      Timetable          Assignments          Calendar
          │                   │                   │
          ↓                   ↓                   ↓
   Class Timetable      Assignment Details    Deadlines
   Exam Timetable       Question / Files      Exam Dates
          │                   │                   │
          └───────────────────┼───────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ↓                   ↓                   ↓
      Attendance           Results          Notifications
          │                   │                   │
          ↓                   ↓                   ↓
    Attendance %         Marks / Grades     In-App Alerts
    Subject History      SGPA / CGPA        Email / WhatsApp
                              │
                              ↓
                       Announcements
                              │
                              ↓
                           Logout
```

### Student Timetable

The student timetable displays both normal and temporary timetable changes.

```text
                         STUDENT TIMETABLE
                                │
                ┌───────────────┼───────────────┐
                ↓               ↓               ↓
             Regular        Substitute        Borrowed
             Period           Period            Period
                │               │               │
                ↓               ↓               ↓
          Normal Subject   Same Subject     Different Subject
          Normal Faculty   New Faculty      Borrowing Faculty
```

Example:

```text
Normal:

10:00 - 11:00
Data Structures
Faculty A


Substitute:

10:00 - 11:00
Data Structures
Faculty B
[Substitute]


Borrowed:

10:00 - 11:00
OOP
Faculty B
[Borrowed]
```

---

## 5. Faculty Flow

```text
                       FACULTY LOGIN
                             │
                             ↓
                    Faculty Dashboard
                             │
        ┌────────────────────┼────────────────────┐
        ↓                    ↓                    ↓
    Timetable            Assignments          Attendance
        │                    │                    │
        ↓                    ↓                    ↓
 View Teaching         Create Assignment       Select Class
 Schedule              Set Deadline            Select Subject
 View Classes          Upload Question         Mark Attendance
 View Subjects         Edit / Delete            Update Records
        │                    │
        └─────────────┬──────┘
                      ↓
               Period Management
                      │
               ┌──────┴──────┐
               ↓             ↓
        Substitute Request  Borrow Period
               │             │
               └──────┬──────┘
                      ↓
                Other Faculty
                      │
               ┌──────┴──────┐
               ↓             ↓
            ACCEPT          REJECT
               │             │
               ↓             ↓
      Temporary Change   Request Closed
               │
               ↓
       Student Timetable
               │
               ↓
          Marks / Results
               │
               ↓
         Announcements
               │
               ↓
         Notifications
               │
               ↓
             Logout
```

---

## 6. Admin Flow

```text
                         ADMIN LOGIN
                              │
                              ↓
                       Admin Dashboard
                              │
        ┌─────────────────────┼─────────────────────┐
        ↓                     ↓                     ↓
   User Management      Academic Management      Timetable
        │                     │                     │
        ↓                     ↓                     ↓
    Students             Departments          Class Timetable
    Faculty               Classes             Faculty Timetable
    Accounts              Subjects             Exam Timetable
                          Academic Year
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              │
              ┌───────────────┼────────────────┐
              ↓               ↓                ↓
           Results       Announcements    Period Management
              │               │                │
              ↓               ↓                ↓
        Verify Results      Publish         Monitor Requests
        Manage Results   Announcements      Temporary Changes
              │               │                │
              └───────────────┼────────────────┘
                              ↓
                        Notifications
                              │
                              ↓
                            Logout
```

---

## 7. Assignment Flow

Faculty members can create assignments containing text-based questions or uploaded files/images.

```text
                         FACULTY
                            │
                            ↓
                  Assignment Management
                            │
                            ↓
                   Create Assignment
                            │
                            ↓
                 Enter Assignment Data
                            │
             ┌──────────────┼──────────────┐
             ↓              ↓              ↓
        Question Text    Image/File      Deadline
             │              │              │
             └──────────────┼──────────────┘
                            ↓
                   AssignmentServlet
                            │
                            ↓
                   AssignmentService
                            │
                            ↓
                        Validate
                            │
                      ┌─────┴─────┐
                      ↓           ↓
                   INVALID       VALID
                      │           │
                      ↓           ↓
                 Show Error   AssignmentRepository
                                  │
                                  ↓
                                 JDBC
                                  │
                                  ↓
                                MySQL
                                  │
                     ┌────────────┼────────────┐
                     ↓            ↓            ↓
                  Students     Calendar    Notification
                     │            │            │
                     ↓            ↓            ↓
                Assignment     Deadline      In-App
                   View         Event       Email/WhatsApp
```

---

## 8. Assignment Deadline Calendar Flow

```text
                   Assignment Created
                           │
                           ↓
                    Store Deadline
                           │
                           ↓
                    Calendar Event
                           │
                           ↓
                     Student Calendar
                           │
                           ↓
                     Display Deadline
                           │
                           ↓
                Deadline Approaching?
                      ┌────┴────┐
                      ↓         ↓
                     YES        NO
                      │         │
                      ↓         ↓
                Send Reminder  Continue
```

---

## 9. Regular Timetable Flow

The administrator manages the regular class and faculty timetable.

```text
                         ADMIN
                           │
                           ↓
                  Timetable Management
                           │
                           ↓
                     Select Class
                           │
                           ↓
                      Select Day
                           │
                           ↓
                    Select Period
                           │
                           ↓
                   Select Subject
                           │
                           ↓
                   Assign Faculty
                           │
                           ↓
                     Assign Room
                           │
                           ↓
                  Validate Conflicts
                           │
                     ┌─────┴─────┐
                     ↓           ↓
                  CONFLICT    NO CONFLICT
                     │           │
                     ↓           ↓
                 Show Error      Save
                                  │
                                  ↓
                            TimetableRepository
                                  │
                                  ↓
                                 JDBC
                                  │
                                  ↓
                                MySQL
                                  │
                  ┌───────────────┼───────────────┐
                  ↓               ↓               ↓
               Student         Faculty           Admin
                  │               │               │
                  ↓               ↓               ↓
             View Class      View Teaching     Manage
             Timetable         Timetable      Timetable
```

---

## 10. Examination Timetable Flow

```text
                         ADMIN
                           │
                           ↓
                 Exam Timetable Management
                           │
                           ↓
                     Select Class
                           │
                           ↓
                    Select Subject
                           │
                           ↓
                      Set Date
                           │
                           ↓
                      Set Time
                           │
                           ↓
                  Validate Schedule
                           │
                           ↓
                     Save Schedule
                           │
                           ↓
                           MySQL
                           │
                           ↓
                   Publish Timetable
                           │
              ┌────────────┴────────────┐
              ↓                         ↓
           STUDENT                   FACULTY
              │                         │
              ↓                         ↓
       View Exam Timetable       View Exam Timetable
```

---

## 11. Period Management Flow

The system provides two types of temporary period changes:

1. Substitute Period
2. Borrowed Period

Both use the Period Request system.

```text
                       FACULTY
                          │
                          ↓
                  Faculty Calendar
                          │
              ┌───────────┴───────────┐
              ↓                       ↓
       Substitute Request       Borrow Period
              │                       │
              ↓                       ↓
       Select Own Period       Select Another
                               Faculty's Period
              │                       │
              ↓                       ↓
       Select Faculty B        Select Own Subject
              │                       │
              ↓                       ↓
       Optional Note           Select Class
              │                       │
              └───────────┬───────────┘
                          ↓
                    Send Request
                          │
                          ↓
                PeriodRequestServlet
                          │
                          ↓
                PeriodRequestService
                          │
                          ↓
                Validate Request
                          │
                          ↓
               PeriodRequestRepository
                          │
                          ↓
                         JDBC
                          │
                          ↓
                        MySQL
                          │
                          ↓
                  Notify Other Faculty
                          │
                   ┌──────┴──────┐
                   ↓             ↓
                ACCEPT          REJECT
                   │             │
                   ↓             ↓
          Temporary Change   Request Closed
                   │
                   ↓
            Update Timetable
                   │
                   ↓
            Notify Students
```

---

## 12. Substitute Period Flow

A substitute period means another faculty member teaches the **same subject**.

```text
Original:

Period
  ↓
Subject A
  ↓
Faculty A


Faculty A
   ↓
Select Own Period
   ↓
Select Faculty B
   ↓
Optional Note
   ↓
Send Request
   ↓
Faculty B
   ↓
Accept
   ↓
Temporary Faculty = Faculty B
   ↓
Subject remains Subject A
   ↓
Student Timetable Updated
```

Example:

```text
Before:

10:00 - 11:00
Data Structures
Faculty A

After:

10:00 - 11:00
Data Structures
Faculty B
[Substitute]
```

---

## 13. Borrowed Period Flow

A borrowed period means another faculty member uses the period to teach **their own subject**.

```text
Original:

Period
  ↓
Subject A
  ↓
Faculty A


Faculty B
   ↓
Select Faculty A's Period
   ↓
Request Borrow
   ↓
Select Own Subject
   ↓
Select Class
   ↓
Optional Note
   ↓
Send Request
   ↓
Faculty A
   ↓
Accept
   ↓
Temporary Subject = Faculty B's Subject
   ↓
Temporary Faculty = Faculty B
   ↓
Student Timetable Updated
```

Example:

```text
Before:

10:00 - 11:00
Data Structures
Faculty A

After Borrow:

10:00 - 11:00
OOP
Faculty B
[Borrowed]
```

---

## 14. Student Timetable Update Flow

Temporary changes must be reflected in the student timetable.

```text
                  Period Request
                        │
                        ↓
                 Request Accepted
                        │
                        ↓
              Temporary Timetable
                    Created
                        │
                        ↓
                  Student View
                        │
             ┌──────────┴──────────┐
             ↓                     ↓
        Substitute             Borrowed
             │                     │
             ↓                     ↓
   Same Subject + New      New Subject + New
        Faculty                 Faculty
```

The system should preserve the original timetable information so the temporary change can be identified and eventually expire.

---

## 15. Calendar Flow

The student calendar will combine important academic events.

```text
                         CALENDAR
                            │
             ┌──────────────┼──────────────┐
             ↓              ↓              ↓
        Assignments       Exams        Timetable
             │              │           Changes
             ↓              ↓              ↓
         Deadlines       Exam Dates     Temporary
                                      Period Changes
             │              │              │
             └──────────────┼──────────────┘
                            ↓
                     Student Calendar
                            │
                            ↓
                      Select Event
                            │
                            ↓
                     Event Details
```

---

## 16. Attendance Flow

```text
                         FACULTY
                            │
                            ↓
                    Attendance Page
                            │
                            ↓
                       Select Class
                            │
                            ↓
                      Select Subject
                            │
                            ↓
                       Select Date
                            │
                            ↓
                    Load Student List
                            │
                            ↓
                    Mark Present/Absent
                            │
                            ↓
                    AttendanceServlet
                            │
                            ↓
                    AttendanceService
                            │
                            ↓
                    AttendanceRepository
                            │
                            ↓
                           JDBC
                            │
                            ↓
                          MySQL
                            │
                            ↓
                     Save Attendance
                            │
                            ↓
                          Student
                            │
                            ↓
                    View Attendance %
```

---

## 17. Result Flow

```text
                         FACULTY
                            │
                            ↓
                       Enter Marks
                            │
                            ↓
                        ResultServlet
                            │
                            ↓
                        ResultService
                            │
                            ↓
                     ResultRepository
                            │
                            ↓
                           MySQL
                            │
                            ↓
                      Submit Results
                            │
                            ↓
                          ADMIN
                            │
                            ↓
                     Verify Results
                            │
                            ↓
                    Publish Results
                            │
                            ↓
                         STUDENT
                            │
                            ↓
                      View Results
                            │
             ┌──────────────┼──────────────┐
             ↓              ↓              ↓
           Marks           Grade           SGPA
                                           │
                                           ↓
                                          CGPA
```

---

## 18. Notification Flow

The notification system can be triggered by different system events.

```text
                       SYSTEM EVENT
                            │
             ┌──────────────┼──────────────┐
             ↓              ↓              ↓
       New Assignment   Period Request   Exam Schedule
             │              │              │
             └──────────────┼──────────────┘
                            ↓
                  NotificationService
                            │
             ┌──────────────┼──────────────┐
             ↓              ↓              ↓
          In-App          Email         WhatsApp
             │              │              │
             ↓              ↓              ↓
           User           User           User
```

Possible events include:

```text
New Assignment
Upcoming Assignment Deadline
Exam Timetable Published
Timetable Changed
Substitute Request Received
Borrow Period Request Received
Request Accepted
Request Rejected
New Announcement
```

---

## 19. Announcement Flow

```text
                    FACULTY / ADMIN
                           │
                           ↓
                  Create Announcement
                           │
                           ↓
                    Enter Content
                           │
                           ↓
                    Select Target
                           │
                           ↓
                 AnnouncementServlet
                           │
                           ↓
                AnnouncementService
                           │
                           ↓
                AnnouncementRepository
                           │
                           ↓
                          JDBC
                           │
                           ↓
                         MySQL
                           │
                           ↓
                  Publish Announcement
                           │
                 ┌─────────┴─────────┐
                 ↓                   ↓
              STUDENT             FACULTY
                 │                   │
                 ↓                   ↓
            View Notice        View Notice
```

---

## 20. File Upload Flow

Faculty can upload assignment questions as text, images, or supported documents.

```text
Faculty
   ↓
Assignment Form
   ↓
Select File
   ↓
AssignmentServlet
   ↓
Validate File
   │
   ├── File Type
   ├── File Size
   └── File Name
   ↓
Store File
   ↓
Store File Metadata / Reference
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Assignment Available to Students
```

---

## 21. Logout Flow

```text
                  Authenticated User
                          │
                          ↓
                       Logout
                          │
                          ↓
                  LogoutServlet
                          │
                          ↓
                  Invalidate Session
                          │
                          ↓
                     Login Page
```

After logout, the previous authenticated session must no longer provide access to protected pages.

---

## 22. Error Flow

All major operations must handle validation, business, and database errors.

```text
User Action
     │
     ↓
Servlet
     │
     ↓
Service
     │
     ↓
Repository
     │
     ↓
Database / Business Rule
     │
     ↓
Error?
  ┌──┴──┐
 YES    NO
  │      │
  ↓      ↓
Exception Continue
  │      │
  ↓      ↓
Error JSP Success Response
```

Example:

```text
Admin creates timetable
        ↓
Faculty already assigned
to another class
        ↓
TimetableConflictException
        ↓
Controller
        ↓
Error Message
        ↓
"Faculty is already assigned
to another class during this period."
```

---

## 23. Core Request Flow

Every major feature should follow the same layered request flow:

```text
                         USER
                           │
                           ↓
                        BROWSER
                           │
                           ↓
                     HTML / JSP
                           │
                           ↓
                       SERVLET
                      CONTROLLER
                           │
                           ↓
                       SERVICE
                    BUSINESS LOGIC
                           │
                           ↓
                      REPOSITORY
                     DATA ACCESS
                           │
                           ↓
                          JDBC
                           │
                           ↓
                         MySQL
                           │
                           ↓
                        RESULT
                           │
                           ↓
                       SERVICE
                           │
                           ↓
                       SERVLET
                           │
                           ↓
                          JSP
                           │
                           ↓
                        BROWSER
                           │
                           ↓
                          USER
```

---

## 24. Complete System Overview

```text
                              START
                                │
                                ↓
                         Open Browser
                                │
                                ↓
                           Login JSP
                                │
                                ↓
                       Enter Credentials
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
                    ┌───────────┴───────────┐
                    ↓                       ↓
                 INVALID                  VALID
                    │                       │
                    ↓                       ↓
              Error Message            Identify Role
                                            │
              ┌─────────────────────────────┼─────────────────────────────┐
              ↓                             ↓                             ↓
           STUDENT                       FACULTY                         ADMIN
              │                             │                             │
              ↓                             ↓                             ↓
       Student Dashboard             Faculty Dashboard             Admin Dashboard
              │                             │                             │
       ┌──────┼───────┐             ┌──────┼────────┐            ┌───────┼────────┐
       ↓      ↓       ↓             ↓      ↓        ↓            ↓       ↓        ↓
   Timetable Assignment Calendar Timetable Assignment Attendance Users Timetable Results
       │      │       │             │      │        │            │       │        │
       ↓      ↓       ↓             ↓      ↓        ↓            ↓       ↓        ↓
    Exams  Deadline Events      Period Mgmt Create  Marks       Subjects Exams Announcements
       │                            │      │        │
       └────────────┐               ↓      ↓        ↓
                    ↓            Requests Results Notifications
              Notifications         │
                    │                ↓
                    ↓          Accept / Reject
             App / Email /          │
                WhatsApp            ↓
                              Timetable Update
                                    │
                                    ↓
                              Student Update
                                    │
                                    ↓
                                  Logout
                                    │
                                    ↓
                               Login Page
```

---

## 25. System Design Principle

Every major feature of the Campus Management System should follow the same separation of responsibilities:

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

The View should not directly access the database.

The Controller should not contain complex business logic.

The Service should not contain direct SQL queries.

The Repository should handle data access.

JDBC should handle database connectivity.

MySQL should handle persistent data storage.

This flow will be used as the foundation for the detailed Student, Faculty, Admin, Assignment, Timetable, Period Management, Notification, and Database Design documents.
