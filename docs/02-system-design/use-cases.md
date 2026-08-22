# Use Cases

## 1. Overview

This document defines the major functional use cases of the Campus Management System.

The system has three primary user roles:

```text
                CAMPUS MANAGEMENT SYSTEM
                         │
          ┌──────────────┼──────────────┐
          ↓              ↓              ↓
       STUDENT         FACULTY         ADMIN
```

The main purpose of the system is to centralize academic schedules, assignments, examinations, period management, and notifications in one web-based platform.

---

# 2. Actors

## 2.1 Student

The Student can:

- Log in
- View dashboard
- View class timetable
- View calendar
- View assignments
- View assignment questions and attachments
- View assignment deadlines
- View exam timetable
- Receive notifications
- View notification history
- Manage notification preferences
- View profile
- Log out

---

## 2.2 Faculty

The Faculty can:

- Log in
- View dashboard
- View faculty timetable
- View faculty calendar
- Create assignments
- Edit assignments
- Deactivate assignments
- Upload assignment questions
- Set assignment deadlines
- View assignment information
- Request substitute periods
- Request borrowed periods
- Receive period requests
- Accept period requests
- Reject period requests
- Add optional reply notes
- View sent requests
- View received requests
- View request history
- Receive notifications
- Manage notification preferences
- View profile
- Log out

---

## 2.3 Admin

The Admin can:

- Log in
- View admin dashboard
- Manage students
- Manage faculty
- Manage departments
- Manage classes
- Manage subjects
- Manage academic years
- Manage semesters
- Create and manage class timetable
- Manage faculty timetable
- Manage exam timetable
- Publish timetable
- Monitor assignments
- Monitor period requests
- Monitor temporary timetable changes
- Manage announcements
- Monitor notifications
- Monitor academic data
- Manage authorized user accounts
- View reports
- View profile
- Log out

---

# 3. System-Level Use Case Map

```text
                              SYSTEM
                                 │
          ┌──────────────────────┼──────────────────────┐
          ↓                      ↓                      ↓
       STUDENT                FACULTY                 ADMIN
          │                      │                      │
          ↓                      ↓                      ↓
      Dashboard              Dashboard              Dashboard
          │                      │                      │
      Timetable              Timetable              Timetable
      Calendar               Calendar               Management
      Assignment             Assignment             User Management
      Exam Timetable         Period Requests        Academic Management
      Notifications          Notifications           Exam Management
      Profile                Profile                Announcements
      Logout                 Logout                 Monitoring
                                                     Reports
                                                     Profile
                                                     Logout
```

---

# 4. Use Case Relationships

The main functional relationships are:

```text
Assignment
   ↓
Calendar
   ↓
Notification

Timetable
   ↓
Faculty Calendar
   ↓
Period Management
   ↓
Temporary Timetable
   ↓
Student / Faculty Timetable
   ↓
Notification

Exam Timetable
   ↓
Calendar
   ↓
Notification

Announcement
   ↓
Notification
```

---

# 5. Authentication Use Cases

## UC-01: Login

**Actor:** Student / Faculty / Admin

**Goal:** Allow an authorized user to access the system.

### Preconditions

- User account exists.
- User has valid credentials.
- Account is active.

### Main Flow

```text
User
 ↓
Open Login Page
 ↓
Enter Username / Email
 ↓
Enter Password
 ↓
Submit
 ↓
AuthenticationServlet
 ↓
AuthService
 ↓
UserRepository
 ↓
MySQL
 ↓
Verify Credentials
 ↓
Create Session
 ↓
Redirect According to Role
```

### Alternative Flow

```text
Invalid Credentials
        ↓
Login Error
        ↓
User Remains on Login Page
```

### Postcondition

A valid user has an authenticated session.

---

## UC-02: Logout

**Actor:** Student / Faculty / Admin

**Goal:** End the authenticated session.

```text
User
 ↓
Click Logout
 ↓
LogoutServlet
 ↓
Invalidate Session
 ↓
Redirect to Login
```

---

# 6. Student Use Cases

## UC-S01: View Student Dashboard

**Actor:** Student

**Goal:** View important academic information in one place.

Possible dashboard information:

```text
Today's Timetable
Upcoming Assignments
Upcoming Exams
Recent Notifications
Upcoming Deadlines
```

Flow:

```text
Student
 ↓
Dashboard
 ↓
StudentServlet
 ↓
StudentService
 ↓
Required Repositories
 ↓
MySQL
 ↓
Dashboard Data
 ↓
JSP
```

---

## UC-S02: View Class Timetable

**Actor:** Student

**Goal:** View the timetable for the student's class.

```text
Student
 ↓
Timetable
 ↓
TimetableServlet
 ↓
TimetableService
 ↓
Get Student Class
 ↓
TimetableRepository
 ↓
TemporaryTimetableRepository
 ↓
Effective Timetable
 ↓
JSP
```

The timetable must include approved temporary changes.

---

## UC-S03: View Calendar

**Actor:** Student

**Goal:** View academic deadlines and events in calendar format.

Possible events:

```text
Assignment Deadline
Exam
Timetable Change
Announcement
```

Flow:

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
 ↓
JSP
```

---

## UC-S04: View Assignment

**Actor:** Student

**Goal:** View assignments assigned to the student's class.

The student can view:

```text
Assignment Title
Subject
Faculty
Question
Attachment
Deadline
Status
```

Flow:

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
MySQL
 ↓
Assignment Details
```

---

## UC-S05: View Assignment Question

**Actor:** Student

**Goal:** Read or open the assignment question.

Question formats:

```text
Text
Image
Document
```

Flow:

```text
Student
 ↓
Assignment
 ↓
Question
 ↓
Text / File
```

---

## UC-S06: View Assignment Deadline

**Actor:** Student

**Goal:** Know when an assignment is due.

```text
Assignment
 ↓
Deadline
 ↓
Calendar
 ↓
Student
```

Possible status:

```text
PENDING
DUE SOON
OVERDUE
```

---

## UC-S07: View Exam Timetable

**Actor:** Student

**Goal:** View published examination schedules.

```text
Student
 ↓
Exam Timetable
 ↓
ExamServlet
 ↓
ExamService
 ↓
ExamRepository
 ↓
MySQL
 ↓
Exam Timetable
```

---

## UC-S08: View Notifications

**Actor:** Student

**Goal:** View system notifications.

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
Notifications
```

---

## UC-S09: Manage Notification Preferences

**Actor:** Student

**Goal:** Control available notification channels.

Possible settings:

```text
In-App
Email
WhatsApp
```

Flow:

```text
Student
 ↓
Notification Settings
 ↓
Update Preferences
 ↓
NotificationPreferenceService
 ↓
Repository
 ↓
MySQL
```

---

## UC-S10: View Profile

**Actor:** Student

**Goal:** View personal account information.

---

# 7. Faculty Use Cases

## UC-F01: View Faculty Dashboard

**Actor:** Faculty

Possible information:

```text
Today's Classes
Upcoming Assignments
Pending Period Requests
Upcoming Exams
Recent Notifications
```

---

## UC-F02: View Faculty Timetable

**Actor:** Faculty

**Goal:** View teaching schedule.

```text
Faculty
 ↓
Timetable
 ↓
TimetableService
 ↓
TimetableRepository
 ↓
TemporaryTimetableRepository
 ↓
Effective Faculty Timetable
```

---

## UC-F03: View Faculty Calendar

**Actor:** Faculty

**Goal:** View teaching periods and period-management actions.

Possible calendar items:

```text
Regular Period
Substitute Period
Borrowed Period
Pending Request
Temporary Change
```

---

## UC-F04: Create Assignment

**Actor:** Faculty

**Goal:** Create an academic assignment.

### Main Flow

```text
Faculty
 ↓
Assignments
 ↓
Create Assignment
 ↓
Select Class
 ↓
Select Subject
 ↓
Enter Question
 ↓
Upload Optional File
 ↓
Set Deadline
 ↓
Submit
 ↓
AssignmentServlet
 ↓
AssignmentService
 ↓
Validation
 ↓
AssignmentRepository
 ↓
MySQL
 ↓
Assignment Created
 ↓
NotificationService
 ↓
Students
```

---

## UC-F05: Edit Assignment

**Actor:** Faculty

**Goal:** Modify an assignment created by the faculty member.

Possible changes:

```text
Title
Description
Question
Attachment
Deadline
```

Flow:

```text
Faculty
 ↓
My Assignments
 ↓
Select Assignment
 ↓
Edit
 ↓
Validate Authorization
 ↓
AssignmentService
 ↓
AssignmentRepository
 ↓
MySQL
 ↓
Updated
```

---

## UC-F06: Deactivate Assignment

**Actor:** Faculty

**Goal:** Remove an assignment from active student view while preserving its record where required.

```text
Faculty
 ↓
Assignment
 ↓
Deactivate
 ↓
Confirmation
 ↓
AssignmentService
 ↓
Repository
 ↓
Status = INACTIVE
```

---

## UC-F07: Request Substitute Period

**Actor:** Faculty

**Goal:** Ask another faculty member to teach the original subject during the requester's period.

### Rule

```text
Original Subject = Substitute Subject
Faculty = Receiving Faculty
```

### Flow

```text
Faculty A
 ↓
Calendar
 ↓
Select Own Period
 ↓
Request Substitute
 ↓
Select Faculty B
 ↓
Optional Note
 ↓
Submit
 ↓
PeriodRequestService
 ↓
Validation
 ↓
PENDING
 ↓
Notification
 ↓
Faculty B
```

---

## UC-F08: Borrow Period

**Actor:** Faculty

**Goal:** Request another faculty member's period to teach the borrower's own subject.

### Rule

```text
Subject = Borrowing Faculty's Subject
Faculty = Borrowing Faculty
```

Flow:

```text
Faculty B
 ↓
Calendar
 ↓
Select Target Period
 ↓
Borrow Period
 ↓
Select Own Subject
 ↓
Select Class
 ↓
Optional Note
 ↓
Submit
 ↓
Validation
 ↓
PENDING
 ↓
Notification
 ↓
Original Faculty
```

---

## UC-F09: View Received Period Requests

**Actor:** Faculty

**Goal:** View requests received from other faculty.

```text
Faculty
 ↓
Received Requests
 ↓
PeriodRequestService
 ↓
Repository
 ↓
MySQL
 ↓
Requests
```

---

## UC-F10: Accept Period Request

**Actor:** Faculty

**Goal:** Accept a substitute or borrow request.

```text
Faculty
 ↓
Open Request
 ↓
Accept
 ↓
Optional Reply Note
 ↓
Revalidate
 ↓
Update Status = ACCEPTED
 ↓
Create Temporary Timetable
 ↓
Notification
```

---

## UC-F11: Reject Period Request

**Actor:** Faculty

**Goal:** Reject a request.

```text
Faculty
 ↓
Open Request
 ↓
Reject
 ↓
Optional Reply Note
 ↓
Update Status = REJECTED
 ↓
Notification
```

No temporary timetable change is created.

---

## UC-F12: View Sent Requests

**Actor:** Faculty

**Goal:** Track requests created by the faculty member.

Possible statuses:

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

---

## UC-F13: View Request History

**Actor:** Faculty

**Goal:** View previous period-management activities.

---

## UC-F14: Manage Notification Preferences

**Actor:** Faculty

Channels:

```text
In-App
Email
WhatsApp
```

---

## UC-F15: View Profile

**Actor:** Faculty

**Goal:** View faculty account information.

---

# 8. Admin Use Cases

## UC-A01: View Admin Dashboard

**Actor:** Admin

Possible information:

```text
Total Students
Total Faculty
Total Classes
Total Subjects
Upcoming Exams
Upcoming Assignments
Pending Period Requests
Recent System Events
```

---

## UC-A02: Manage Students

**Actor:** Admin

Operations:

```text
Create
View
Search
Update
Activate
Deactivate
```

Flow:

```text
Admin
 ↓
Student Management
 ↓
StudentServlet
 ↓
StudentService
 ↓
StudentRepository
 ↓
MySQL
```

---

## UC-A03: Manage Faculty

**Actor:** Admin

Operations:

```text
Create
View
Update
Activate
Deactivate
Assign Department
```

---

## UC-A04: Manage Departments

**Actor:** Admin

Operations:

```text
Create
View
Update
Deactivate
```

---

## UC-A05: Manage Classes

**Actor:** Admin

Possible data:

```text
Class
Department
Semester
Academic Year
```

---

## UC-A06: Manage Subjects

**Actor:** Admin

Possible data:

```text
Subject Code
Subject Name
Department
Semester
Credits
Subject Type
```

---

## UC-A07: Manage Academic Year

**Actor:** Admin

```text
Create Academic Year
Activate Academic Year
Deactivate Academic Year
```

---

## UC-A08: Manage Semester

**Actor:** Admin

```text
Create Semester
Set Active Semester
Update Semester
```

---

## UC-A09: Create Class Timetable

**Actor:** Admin

**Goal:** Create the master timetable.

```text
Admin
 ↓
Timetable Management
 ↓
Select Class
 ↓
Select Day
 ↓
Select Period
 ↓
Select Subject
 ↓
Assign Faculty
 ↓
Assign Room
 ↓
Validate
 ↓
Save
```

---

## UC-A10: Update Class Timetable

**Actor:** Admin

The system must validate:

```text
Class Conflict
Faculty Conflict
Room Conflict
```

---

## UC-A11: View Faculty Timetable

**Actor:** Admin

**Goal:** Verify faculty teaching schedules.

---

## UC-A12: Publish Timetable

**Actor:** Admin

**Goal:** Make a timetable available to students and faculty.

```text
Draft
 ↓
Validate
 ↓
Publish
 ↓
NotificationService
 ↓
Students / Faculty
```

---

## UC-A13: Manage Exam Timetable

**Actor:** Admin

Operations:

```text
Create
Update
Validate
Publish
```

Possible data:

```text
Class
Subject
Date
Time
Room
Exam Type
```

---

## UC-A14: Monitor Assignments

**Actor:** Admin

Admin can filter assignments by:

```text
Department
Class
Subject
Faculty
Date
Status
```

---

## UC-A15: Monitor Period Requests

**Actor:** Admin

Admin can view:

```text
Requester
Receiver
Request Type
Class
Subject
Date
Period
Status
Request Note
Reply Note
```

Admin monitoring does not automatically mean Admin approves every request.

---

## UC-A16: Monitor Temporary Timetable Changes

**Actor:** Admin

Admin can view active temporary changes.

```text
Date
Period
Class
Original Faculty
Temporary Faculty
Original Subject
Temporary Subject
Change Type
```

---

## UC-A17: Manage Announcements

**Actor:** Admin

Operations:

```text
Create
Edit
Publish
Deactivate
```

Target audience:

```text
All Students
All Faculty
Department
Class
Semester
Selected Users
```

---

## UC-A18: Monitor Notifications

**Actor:** Admin

Possible information:

```text
Total
Pending
Sent
Delivered
Failed
```

---

## UC-A19: Manage Authorized User Accounts

**Actor:** Admin

Admin can manage account status and authorized roles.

Roles:

```text
STUDENT
FACULTY
ADMIN
```

A normal user must not be able to promote themselves to Admin.

---

## UC-A20: View Reports

**Actor:** Admin

Possible reports:

```text
Student Statistics
Faculty Statistics
Assignment Statistics
Attendance Statistics
Exam Schedule
Period Request Statistics
Notification Statistics
```

---

## UC-A21: View Profile

**Actor:** Admin

---

# 9. Assignment Use Case Relationships

```text
Faculty
   │
   ↓
Create Assignment
   │
   ├────────→ Set Deadline
   │
   ├────────→ Upload Question
   │
   └────────→ Select Class / Subject
   │
   ↓
Assignment Created
   │
   ├────────→ Student View
   ├────────→ Calendar Event
   └────────→ Notification
```

---

# 10. Timetable Use Case Relationships

```text
Admin
   ↓
Create Master Timetable
   │
   ├────────→ Validate Class
   ├────────→ Validate Faculty
   └────────→ Validate Room
   │
   ↓
Master Timetable
   │
   ├────────→ Student Timetable
   └────────→ Faculty Timetable
              │
              ↓
       Faculty Calendar
              │
              ↓
       Period Management
```

---

# 11. Period Management Use Case Relationships

```text
Faculty
   ↓
Faculty Calendar
   │
   ├───────────────┐
   ↓               ↓
Substitute        Borrow
Request           Request
   │               │
   └───────┬───────┘
           ↓
       PENDING
           │
           ↓
    Receiving Faculty
           │
      ┌────┴────┐
      ↓         ↓
   ACCEPT     REJECT
      │         │
      ↓         ↓
Temporary     Closed
Change
      │
      ↓
Student + Faculty Timetable
      │
      ↓
Notification
```

---

# 12. Notification Use Case Relationships

```text
System Event
     │
     ├── Assignment
     ├── Timetable
     ├── Period Request
     ├── Exam
     └── Announcement
     │
     ↓
NotificationService
     │
     ├── In-App
     ├── Email
     └── WhatsApp
```

---

# 13. Use Case: Notification Delivery

**Actors:** Student / Faculty / Admin

**Goal:** Receive important system events.

### Main Flow

```text
System Event
 ↓
NotificationService
 ↓
Identify Recipient
 ↓
Check Preferences
 ↓
Generate Message
 ↓
Send Through Enabled Channels
```

Channels:

```text
In-App
Email
WhatsApp
```

---

# 14. Use Case: WhatsApp Notification

**Actor:** Notification System

**Goal:** Deliver an authorized notification through WhatsApp.

### Preconditions

- User has a valid phone number where required.
- WhatsApp notification is enabled.
- Provider/API is configured.
- Message complies with provider requirements.

### Main Flow

```text
Notification Event
 ↓
NotificationService
 ↓
Check WhatsApp Preference
 ↓
WhatsAppNotificationService
 ↓
WhatsApp Provider
 ↓
WhatsApp Business API
 ↓
Recipient
```

### Failure Flow

```text
API Failure
 ↓
Classify Error
 ↓
Temporary?
 ├── YES → Retry
 └── NO → Log Failure
```

---

# 15. Use Case: Calendar Deadline

**Actor:** Student

**Goal:** View academic deadlines through a calendar.

```text
Assignment
 ↓
Deadline
 ↓
CalendarService
 ↓
Calendar Event
 ↓
Student Calendar
```

---

# 16. Use Case: Temporary Timetable Change

**Actors:** Faculty / Student

**Goal:** Reflect an approved temporary period change.

```text
Accepted Period Request
 ↓
TemporaryTimetableService
 ↓
TemporaryTimetableRepository
 ↓
MySQL
 ↓
Effective Timetable
 ↓
Student / Faculty
```

The master timetable remains unchanged.

---

# 17. Use Case: Substitute Period

**Actors:** Faculty

**Goal:** Arrange another faculty member to teach the original subject.

```text
Requester
 ↓
Select Own Period
 ↓
Select Substitute Faculty
 ↓
Submit Request
 ↓
Receiver
 ↓
Accept
 ↓
Temporary Change
 ↓
Same Subject + New Faculty
```

---

# 18. Use Case: Borrowed Period

**Actors:** Faculty

**Goal:** Use another faculty member's period to teach the borrower's own subject.

```text
Requester
 ↓
Select Target Period
 ↓
Select Own Subject
 ↓
Submit Request
 ↓
Original Faculty
 ↓
Accept
 ↓
Temporary Change
 ↓
Borrower's Subject + Borrowing Faculty
```

---

# 19. Use Case: Admin Timetable Conflict Validation

**Actor:** Admin

**Goal:** Prevent invalid timetable assignments.

```text
Admin
 ↓
Create / Edit Timetable
 ↓
Validate Class
 ↓
Validate Faculty
 ↓
Validate Room
 ↓
Conflict?
 ┌────┴────┐
 ↓         ↓
 YES       NO
 ↓          ↓
Error      Save
```

---

# 20. Use Case: Faculty Availability Validation

**Actors:** Faculty / System

**Goal:** Prevent a faculty member from being assigned to two periods simultaneously.

```text
Request
 ↓
Find Faculty Schedule
 ↓
Same Date + Period?
 ┌────┴────┐
 ↓         ↓
 YES       NO
 ↓          ↓
Reject    Available
```

---

# 21. Use Case: Student Access Control

**Actor:** Student

**Goal:** Ensure students only access data belonging to their class/account.

```text
Student Request
 ↓
Session Check
 ↓
Student ID
 ↓
Find Student Class
 ↓
Compare Requested Data
 ↓
Authorized?
 ┌────┴────┐
 ↓         ↓
 YES       NO
 ↓          ↓
ALLOW      DENY
```

---

# 22. Use Case: Faculty Access Control

**Actor:** Faculty

**Goal:** Ensure faculty can modify only authorized academic data.

Examples:

```text
Faculty
 ↓
Edit Own Assignment
 ↓
ALLOW
```

```text
Faculty
 ↓
Edit Another Faculty's Assignment
 ↓
DENY
```

```text
Faculty
 ↓
Modify Master Timetable
 ↓
DENY
```

---

# 23. Use Case: Admin Authorization

**Actor:** Admin

**Goal:** Access administrative operations.

```text
Admin Request
 ↓
Session Check
 ↓
Role Check
 ↓
Permission Check
 ↓
Admin Operation
```

---

# 24. General Use Case Template

Each major use case should eventually be documented using:

```text
Use Case ID
Use Case Name
Actor
Goal
Description
Preconditions
Postconditions
Main Flow
Alternative Flow
Exception Flow
Business Rules
Related Modules
```

This structure will be used when detailed use-case specifications are expanded.

---

# 25. Functional Use Case Summary

| ID | Use Case | Primary Actor |
|---|---|---|
| UC-01 | Login | All Users |
| UC-02 | Logout | All Users |
| UC-S01 | Student Dashboard | Student |
| UC-S02 | View Class Timetable | Student |
| UC-S03 | View Calendar | Student |
| UC-S04 | View Assignment | Student |
| UC-S05 | View Assignment Question | Student |
| UC-S06 | View Assignment Deadline | Student |
| UC-S07 | View Exam Timetable | Student |
| UC-S08 | View Notifications | Student |
| UC-S09 | Notification Preferences | Student |
| UC-S10 | Student Profile | Student |
| UC-F01 | Faculty Dashboard | Faculty |
| UC-F02 | View Faculty Timetable | Faculty |
| UC-F03 | Faculty Calendar | Faculty |
| UC-F04 | Create Assignment | Faculty |
| UC-F05 | Edit Assignment | Faculty |
| UC-F06 | Deactivate Assignment | Faculty |
| UC-F07 | Request Substitute | Faculty |
| UC-F08 | Borrow Period | Faculty |
| UC-F09 | Received Requests | Faculty |
| UC-F10 | Accept Request | Faculty |
| UC-F11 | Reject Request | Faculty |
| UC-F12 | Sent Requests | Faculty |
| UC-F13 | Request History | Faculty |
| UC-F14 | Notification Preferences | Faculty |
| UC-F15 | Faculty Profile | Faculty |
| UC-A01 | Admin Dashboard | Admin |
| UC-A02 | Manage Students | Admin |
| UC-A03 | Manage Faculty | Admin |
| UC-A04 | Manage Departments | Admin |
| UC-A05 | Manage Classes | Admin |
| UC-A06 | Manage Subjects | Admin |
| UC-A07 | Manage Academic Year | Admin |
| UC-A08 | Manage Semester | Admin |
| UC-A09 | Create Class Timetable | Admin |
| UC-A10 | Update Class Timetable | Admin |
| UC-A11 | View Faculty Timetable | Admin |
| UC-A12 | Publish Timetable | Admin |
| UC-A13 | Manage Exam Timetable | Admin |
| UC-A14 | Monitor Assignments | Admin |
| UC-A15 | Monitor Period Requests | Admin |
| UC-A16 | Monitor Temporary Changes | Admin |
| UC-A17 | Manage Announcements | Admin |
| UC-A18 | Monitor Notifications | Admin |
| UC-A19 | Manage User Accounts | Admin |
| UC-A20 | View Reports | Admin |
| UC-A21 | Admin Profile | Admin |

---

# 26. Primary Use Case Diagram

```text
                              CAMPUS MANAGEMENT SYSTEM
                                       │
        ┌──────────────────────────────┼──────────────────────────────┐
        │                              │                              │
        │                              │                              │
     STUDENT                        FACULTY                         ADMIN
        │                              │                              │
        │                              │                              │
        ├── Login                      ├── Login                      ├── Login
        ├── Dashboard                  ├── Dashboard                  ├── Dashboard
        ├── Timetable                  ├── Timetable                  ├── User Management
        ├── Calendar                   ├── Calendar                   ├── Academic Management
        ├── Assignments                ├── Create Assignment          ├── Timetable Management
        ├── Exam Timetable             ├── Edit Assignment            ├── Exam Timetable
        ├── Notifications              ├── Substitute Request         ├── Assignment Monitoring
        ├── Preferences                ├── Borrow Period               ├── Period Monitoring
        ├── Profile                    ├── Accept / Reject             ├── Temporary Changes
        └── Logout                     ├── Request History              ├── Announcements
                                      ├── Notifications                ├── Notification Monitoring
                                      ├── Preferences                  ├── Reports
                                      ├── Profile                      ├── Profile
                                      └── Logout                       └── Logout
```

---

# 27. Cross-Module Use Case Diagram

```text
                        ASSIGNMENT
                            │
                            ↓
                         CALENDAR
                            │
                            ↓
                       NOTIFICATION
                            │
                            ↓
                     In-App / Email /
                        WhatsApp


                         TIMETABLE
                            │
                            ↓
                    FACULTY CALENDAR
                            │
                            ↓
                    PERIOD MANAGEMENT
                            │
                    ┌───────┴───────┐
                    ↓               ↓
               SUBSTITUTE        BORROW
                    │               │
                    └───────┬───────┘
                            ↓
                  TEMPORARY TIMETABLE
                            │
                    ┌───────┴───────┐
                    ↓               ↓
                 STUDENT          FACULTY
                 TIMETABLE        TIMETABLE
                            │
                            ↓
                       NOTIFICATION


                      EXAM TIMETABLE
                            │
                            ↓
                       CALENDAR
                            │
                            ↓
                       NOTIFICATION
```

---

# 28. System-Level Business Rules

The following rules apply across the use cases:

1. Every protected operation requires authentication.
2. Role-based authorization must be enforced server-side.
3. Students can access data relevant to their own class/account.
4. Faculty can manage only resources they are authorized to manage.
5. Admin manages system-level academic configuration.
6. JSP pages must not directly access MySQL.
7. Servlets must not contain database queries.
8. Business rules belong in the Service Layer.
9. Database operations belong in the Repository Layer.
10. JDBC handles database communication.
11. Master timetable data must remain separate from temporary timetable changes.
12. Substitute periods retain the original subject.
13. Borrowed periods use the borrowing faculty's subject.
14. Accepted period requests create temporary timetable changes.
15. Rejected requests do not create temporary timetable changes.
16. Assignment deadlines must be represented in the student calendar.
17. Notifications can use In-App, Email, and WhatsApp channels.
18. WhatsApp messaging must use an appropriate official Business API/provider.
19. Notification preferences must be respected.
20. External notification failures must not corrupt the primary academic transaction.
21. Important actions should be auditable where required.
22. Sensitive credentials must remain server-side.
23. The database must enforce important relationships and constraints.
24. Exact implementation details may be refined during database and backend design.

---

# 29. Future Use Cases

The following can be added after the core mini-project:

```text
Student Assignment Submission
Faculty Assignment Evaluation
Marks / Feedback
Attendance Management
Result Publishing
Advanced Reports
Room Management
Event Management
Mobile Application
Desktop Application
Advanced Notification Scheduling
Notification Queue
Analytics Dashboard
```

These should be treated as extensions rather than forcing unnecessary complexity into the initial implementation.

---

# 30. Final Use Case Scope

```text
                           CAMPUS MANAGEMENT SYSTEM
                                      │
        ┌─────────────────────────────┼─────────────────────────────┐
        ↓                             ↓                             ↓
     STUDENT                       FACULTY                        ADMIN
        │                             │                             │
        ↓                             ↓                             ↓
   Authentication               Authentication               Authentication
        │                             │                             │
        ↓                             ↓                             ↓
   Dashboard                    Dashboard                    Dashboard
        │                             │                             │
   ┌────┼────┐                 ┌──────┼──────┐              ┌───────┼───────┐
   ↓    ↓    ↓                 ↓      ↓      ↓              ↓       ↓       ↓
  Time  Assign  Exam        Assign  Calendar Period       Users  Academic Timetable
  table  ment  Table        ments           Mgmt                  Setup
   │      │      │            │       │       │              │       │       │
   └──────┼──────┘            │       │       │              └───────┼───────┘
          ↓                   │       │       │                      ↓
       Calendar              │       │       ├── Substitute       Exams
          │                  │       │       └── Borrow           │
          ↓                  │       │                              ↓
    Notifications            │       └── Request History        Announcements
          │                  │                                      │
          └──────────────────┼──────────────────────────────────────┘
                             ↓
                      NotificationService
                             │
                   ┌─────────┼─────────┐
                   ↓         ↓         ↓
                In-App     Email    WhatsApp
```

This document defines the functional **Use Cases** of the Campus Management System and will be used as the reference for the next stages: **requirements finalization, database design, API/Servlet design, UI design, repository implementation, service implementation, and testing**.
