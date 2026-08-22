# Faculty Flow

## 1. Overview

The Faculty Flow defines the complete workflow available to faculty members in the Campus Management System.

Faculty members can:

- Log in securely
- View their faculty dashboard
- View their teaching timetable
- View assigned classes and subjects
- Create and manage assignments
- Set assignment deadlines
- Upload assignment questions as text, images, or documents
- Mark and view attendance
- Enter and manage marks/results where permitted
- Publish or manage announcements where permitted
- Receive application notifications
- Request another faculty member to take a period
- Borrow another faculty member's period to teach their own subject
- Accept or reject period requests
- Add an optional reply note to requests
- View period requests through the faculty calendar
- View temporary timetable changes
- Manage their profile where permitted
- Log out securely

The faculty member does not have unrestricted administrative access. Master academic configuration such as users, departments, classes, subjects, and the main timetable remains under Admin control.

---

## 2. Faculty Architecture Flow

Every faculty operation follows the common application architecture:

```text
Faculty
   ↓
Browser
   ↓
HTML / CSS / JavaScript
   ↓
JSP
   ↓
Servlet / Controller
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
Faculty
```

---

## 3. Faculty Login Flow

```text
                         FACULTY
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
                                FACULTY
                                   │
                                   ↓
                          Faculty Dashboard
```

---

## 4. Faculty Session

After successful authentication, the system creates an HTTP session.

The session may contain:

```text
User ID
Username
Role
Faculty ID
Department
```

Flow:

```text
Successful Login
      ↓
Create HTTP Session
      ↓
Store Faculty Information
      ↓
Redirect to Faculty Dashboard
      ↓
Access Faculty Modules
```

If the faculty member attempts to access a protected page without a valid session:

```text
Faculty
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

# 5. Faculty Dashboard

The Faculty Dashboard is the main entry point after login.

```text
                       FACULTY DASHBOARD
                              │
       ┌──────────────────────┼──────────────────────┐
       ↓                      ↓                      ↓
   Today's Classes        Assignments           Attendance
       │                      │                      │
       ↓                      ↓                      ↓
   Teaching Schedule     Pending Deadlines      Today's Classes
       │                      │                      │
       └──────────────────────┼──────────────────────┘
                              │
       ┌──────────────────────┼──────────────────────┐
       ↓                      ↓                      ↓
  Period Requests        Notifications          Calendar
       │                      │                      │
       ↓                      ↓                      ↓
 Pending Requests       Recent Alerts          Period Events
                              │
                              ↓
                        Announcements
```

The dashboard may display:

```text
Today's Teaching Schedule
Upcoming Assignment Deadlines
Pending Period Requests
Recent Notifications
Upcoming Calendar Events
Attendance Tasks
Latest Announcements
```

---

# 6. Faculty Navigation

The faculty navigation structure is:

```text
Faculty Dashboard
│
├── Home
│
├── Timetable
│   ├── My Timetable
│   └── Class / Subject Schedule
│
├── Calendar
│   ├── My Schedule
│   ├── Period Requests
│   └── Temporary Changes
│
├── Assignments
│   ├── Create Assignment
│   ├── My Assignments
│   ├── Edit Assignment
│   └── Delete Assignment
│
├── Attendance
│   ├── Mark Attendance
│   └── Attendance Records
│
├── Results / Marks
│   ├── Enter Marks
│   └── View Marks
│
├── Period Management
│   ├── Request Substitute
│   ├── Borrow Period
│   ├── Received Requests
│   └── Sent Requests
│
├── Notifications
│
├── Announcements
│
├── Profile
│
└── Logout
```

The exact navigation items can be refined during UI/UX design.

---

# 7. Faculty Timetable Flow

Faculty members can view their teaching timetable.

```text
Faculty
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
Retrieve Faculty Timetable
   ↓
Apply Approved Temporary Changes
   ↓
Timetable JSP
   ↓
Faculty
```

The timetable may display:

```text
Day
Date
Period
Start Time
End Time
Class
Subject
Room
Status
```

Example:

```text
Monday

09:00 - 10:00
S2 CSE
Data Structures
Room 201

10:00 - 11:00
S2 CSE
OOP
Room 201
```

---

# 8. Faculty Timetable and Temporary Changes

Faculty timetable entries can be affected by approved substitute or borrowed-period requests.

```text
                     FACULTY TIMETABLE
                            │
             ┌──────────────┼──────────────┐
             ↓              ↓              ↓
          Regular       Substitute       Borrowed
           Period          Period          Period
             │              │              │
             ↓              ↓              ↓
        Normal Class   Another Faculty   Own Subject
        Normal Subject Takes Period     Uses Period
```

The faculty member should be able to clearly identify temporary changes.

Example:

```text
10:00 - 11:00
OOP
S2 CSE
Faculty B

[Borrowed Period]
```

---

# 9. Faculty Calendar

The faculty calendar is an important part of period management.

It can display:

```text
Teaching Periods
Assignments
Assignment Deadlines
Exam-related Events
Period Requests
Accepted Requests
Rejected Requests
Temporary Timetable Changes
Announcements
```

Flow:

```text
Faculty
   ↓
Calendar
   ↓
CalendarServlet
   ↓
CalendarService
   ↓
Retrieve Faculty Events
   ↓
Combine Regular + Temporary Events
   ↓
Calendar JSP
   ↓
Faculty
```

---

# 10. Assignment Management Flow

Faculty members can create assignments for their assigned classes and subjects.

```text
Faculty
   ↓
Assignments
   ↓
Create Assignment
   ↓
Assignment Form
   ↓
Enter Assignment Details
```

The form may contain:

```text
Title
Description
Class
Subject
Submission Date
Submission Time
Question Text
Question Image
Question Document
```

The complete flow is:

```text
Faculty
   ↓
assignment-form.jsp
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
Validate Assignment
   ↓
AssignmentRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Assignment Created
```

---

# 11. Assignment Question Upload

The system should support both text and file-based questions.

```text
                    Assignment Question
                            │
                ┌───────────┴───────────┐
                ↓                       ↓
             Text Input             File Upload
                │                       │
                ↓                       ↓
          Question Text          Image / Document
                │                       │
                └───────────┬───────────┘
                            ↓
                    Validate Content
                            ↓
                      Store Assignment
```

Supported file types will be defined during the requirements and security phase.

The system should validate:

- File type
- File size
- File name
- User permission

---

# 12. Assignment Deadline Management

Faculty members can set the submission deadline.

```text
Faculty
   ↓
Create / Edit Assignment
   ↓
Set Submission Date
   ↓
Set Submission Time
   ↓
Validate Deadline
   ↓
Save Assignment
   ↓
Calendar Event Created
   ↓
Student Calendar Updated
   ↓
Notification System
```

The deadline must be stored consistently so that the student calendar and notification system use the same source of information.

---

# 13. Assignment Edit Flow

Faculty members can edit assignments they are authorized to manage.

```text
Faculty
   ↓
My Assignments
   ↓
Select Assignment
   ↓
Edit
   ↓
Assignment Form
   ↓
Modify Details
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
Validate Changes
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Updated Assignment
   ↓
Student View Updated
```

The system should ensure that a faculty member cannot edit another faculty member's assignment unless explicitly authorized.

---

# 14. Assignment Delete Flow

```text
Faculty
   ↓
My Assignments
   ↓
Select Assignment
   ↓
Delete
   ↓
Confirmation
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
Authorization Check
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Assignment Removed / Deactivated
   ↓
Student View Updated
```

The exact delete strategy, such as hard delete or soft delete, will be finalized during database design.

---

# 15. Attendance Flow

Faculty members can mark attendance for their assigned classes.

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
```

---

# 16. Attendance Validation

Before saving attendance, the system should validate:

```text
Faculty teaches selected class?
          ↓
        YES
          ↓
Faculty teaches selected subject?
          ↓
        YES
          ↓
Valid date?
          ↓
        YES
          ↓
Attendance already recorded?
          ↓
   ┌──────┴──────┐
   ↓             ↓
  YES            NO
   │              │
Update / prevent  Save Attendance
duplicate record
```

The exact attendance correction rules will be finalized during the requirements phase.

---

# 17. Attendance Records

Faculty members may view attendance records for classes and subjects they are authorized to access.

```text
Faculty
   ↓
Attendance Records
   ↓
Select Class
   ↓
Select Subject
   ↓
Select Date / Range
   ↓
AttendanceService
   ↓
AttendanceRepository
   ↓
MySQL
   ↓
Display Records
```

The faculty member should not be able to access unrelated classes without appropriate permission.

---

# 18. Marks / Results Flow

Faculty members may enter marks for subjects and classes assigned to them.

```text
Faculty
   ↓
Results / Marks
   ↓
Select Class
   ↓
Select Subject
   ↓
Select Exam / Assessment
   ↓
Load Students
   ↓
Enter Marks
   ↓
Validate Marks
   ↓
ResultService
   ↓
ResultRepository
   ↓
JDBC
   ↓
MySQL
```

Possible validations include:

```text
Mark cannot be negative
Mark cannot exceed maximum mark
Student must belong to selected class
Faculty must be authorized for subject/class
Duplicate records must be handled
```

---

# 19. Result Submission Flow

```text
Faculty
   ↓
Enter / Update Marks
   ↓
Validate Marks
   ↓
Save Draft / Submit
   ↓
ResultRepository
   ↓
MySQL
   ↓
Result Status
   │
   ├── DRAFT
   └── SUBMITTED
```

If the project requires Admin verification:

```text
Faculty
   ↓
Submit Results
   ↓
ADMIN
   ↓
Verify Results
   ↓
Publish
   ↓
Student Can View Results
```

---

# 20. Period Management

Period Management is one of the major faculty features.

The system supports:

1. Substitute Period Request
2. Borrow Period Request
3. Accept Request
4. Reject Request
5. Optional Reply Note
6. Request History
7. Temporary Timetable Update

The faculty calendar will be the main interface for starting these operations.

---

# 21. Substitute Period Request

A substitute request means:

> Another faculty member will teach the original faculty member's subject during that period.

Example:

```text
Original Period:

10:00 - 11:00
Data Structures
Faculty A

Substitute Request:

Faculty A
      ↓
Select 10:00 - 11:00
      ↓
Select Faculty B
      ↓
Optional Note
      ↓
Send Request
```

---

# 22. Substitute Request Flow

```text
Faculty A
   ↓
Faculty Calendar
   ↓
Select Own Period
   ↓
Select "Request Substitute"
   ↓
Select Faculty B
   ↓
Add Optional Note
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
Validate Request
   │
   ├── Faculty A owns period?
   ├── Faculty B available?
   ├── Valid date?
   └── No conflicting request?
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
NotificationService
   ↓
Faculty B
```

---

# 23. Substitute Request Response

Faculty B receives the request.

```text
                     FACULTY B
                         │
                         ↓
                  Notification
                         │
                         ↓
                  Period Request
                         │
                ┌────────┴────────┐
                ↓                 ↓
             ACCEPT              REJECT
                │                 │
                ↓                 ↓
       Optional Reply Note    Optional Reply Note
                │                 │
                ↓                 ↓
       Update Request Status  Update Request Status
                │                 │
                ↓                 ↓
      Temporary Timetable     Request Closed
             Change
                │
                ↓
       Notify Faculty A
                │
                ↓
       Update Student Timetable
```

---

# 24. Substitute Period Result

When the request is accepted:

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

Important rule:

```text
Subject = ORIGINAL SUBJECT
Faculty = SUBSTITUTE FACULTY
```

The original regular timetable should not be permanently overwritten.

---

# 25. Borrow Period Request

A borrow request means:

> A faculty member requests another faculty member's period to teach their own subject.

Example:

```text
Original:

10:00 - 11:00
Data Structures
Faculty A

Borrow Request:

Faculty B
      ↓
Select Faculty A's period
      ↓
Select own subject: OOP
      ↓
Select class
      ↓
Optional note
      ↓
Send Request
```

---

# 26. Borrow Period Request Flow

```text
Faculty B
   ↓
Faculty Calendar
   ↓
Select Another Faculty's Period
   ↓
Select "Borrow Period"
   ↓
Select Own Subject
   ↓
Select Class
   ↓
Add Optional Note
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
Validate Request
   │
   ├── Period exists?
   ├── Faculty B teaches selected subject?
   ├── Faculty B available?
   ├── Class valid?
   └── No conflict?
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
NotificationService
   ↓
Original Faculty
```

---

# 27. Borrow Request Response

The original faculty member receives the request.

```text
                     FACULTY A
                         │
                         ↓
                  Notification
                         │
                         ↓
                   Borrow Request
                         │
                ┌────────┴────────┐
                ↓                 ↓
             ACCEPT              REJECT
                │                 │
                ↓                 ↓
       Optional Reply Note    Optional Reply Note
                │                 │
                ↓                 ↓
       Update Request Status  Request Closed
                │
                ↓
       Temporary Timetable
            Change
                │
                ↓
       Notify Faculty B
                │
                ↓
       Update Student Timetable
```

---

# 28. Borrowed Period Result

When accepted:

```text
Before:

10:00 - 11:00
Data Structures
Faculty A


After:

10:00 - 11:00
OOP
Faculty B
[Borrowed]
```

Important rule:

```text
Subject = BORROWING FACULTY'S SUBJECT
Faculty = BORROWING FACULTY
```

The original timetable must remain available as the base schedule.

---

# 29. Optional Reply Note

The faculty member receiving a request can optionally add a note.

```text
Request
   ↓
Accept / Reject
   ↓
Add Optional Reply Note
   ↓
Submit Response
   ↓
Save Response
   ↓
Notify Requesting Faculty
```

Example:

```text
Status: ACCEPTED

Reply:
"I can take this period."
```

or:

```text
Status: REJECTED

Reply:
"I have another class during this time."
```

The reply note should not be mandatory unless future requirements specify otherwise.

---

# 30. Period Request Status

A period request can have statuses such as:

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

Flow:

```text
Request Created
      ↓
PENDING
      │
      ├───────────────┐
      ↓               ↓
   ACCEPTED         REJECTED
      │               │
      ↓               ↓
Temporary Change   Request Closed
```

Expired requests may be used when the requested date/time has already passed.

---

# 31. Period Request History

Faculty members should be able to view their request history.

```text
Faculty
   ↓
Period Management
   ↓
Request History
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
Display:
   - Sent Requests
   - Received Requests
   - Accepted
   - Rejected
   - Pending
```

---

# 32. Period Request Notification Flow

```text
Period Request Created
        ↓
NotificationService
        │
        ├──────────────┬──────────────┐
        ↓              ↓              ↓
      In-App          Email        WhatsApp
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                Receiving Faculty
```

When the request is accepted or rejected:

```text
Response
   ↓
NotificationService
   ↓
Requesting Faculty
```

---

# 33. Student Timetable Impact

Approved faculty period changes must affect the student timetable.

```text
Faculty Request
       ↓
Request Accepted
       ↓
Temporary Timetable Record
       ↓
Student Timetable Query
       ↓
Check Active Temporary Record
       ↓
Apply Change
       ↓
Student Sees Updated Period
```

Example:

```text
Regular:

10:00 - 11:00
Data Structures
Faculty A


Temporary:

10:00 - 11:00
OOP
Faculty B
[Borrowed]
```

---

# 34. Temporary Timetable Expiration

Temporary changes should be valid only for the specified date/period.

```text
Temporary Change
       ↓
Store Effective Date
       ↓
Store Period
       ↓
Current Date/Time
       ↓
Is Change Active?
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
Show      Show Regular
Temporary Timetable
Change
```

The original timetable remains the permanent source schedule.

---

# 35. Faculty Notification Center

Faculty members can view application notifications.

```text
Faculty
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
Notification JSP
```

Possible notification categories:

```text
Assignment
Deadline
Period Request
Request Response
Timetable Change
Exam
Announcement
System
```

---

# 36. Notification Read Status

```text
New Notification
       ↓
Status = UNREAD
       ↓
Faculty Opens Notification
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
Unread: 4
```

---

# 37. Announcement Flow

Authorized faculty members may create announcements depending on their permissions.

```text
Faculty
   ↓
Announcements
   ↓
Create Announcement
   ↓
Enter Content
   ↓
Select Target
   ↓
AnnouncementServlet
   ↓
AnnouncementService
   ↓
AnnouncementRepository
   ↓
MySQL
   ↓
Publish
   ↓
Target Users
```

Possible targets:

```text
Class
Department
Semester
Specific Group
```

Whether faculty can publish institution-wide announcements will be controlled by Admin permissions.

---

# 38. Faculty Profile Flow

Faculty can view their profile information.

```text
Faculty
   ↓
Profile
   ↓
FacultyServlet
   ↓
FacultyService
   ↓
FacultyRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Retrieve Profile
   ↓
Profile JSP
   ↓
Faculty
```

Possible information:

```text
Faculty ID
Name
Email
Department
Designation
Phone Number
Assigned Subjects
```

Editable fields will be defined during the requirements phase.

---

# 39. Faculty Authorization

Faculty permissions must be checked on the server side.

```text
Faculty Request
       ↓
Session Validation
       ↓
Role Validation
       ↓
Resource Authorization
       ↓
Allow / Deny
```

Examples:

```text
Faculty A
   ↓
Edit own assignment
   ↓
ALLOW
```

```text
Faculty A
   ↓
Edit Faculty B's assignment
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

unless an explicit administrative permission is introduced.

---

# 40. Faculty Data Access Rules

Faculty members can generally access:

```text
Their Timetable
Assigned Classes
Assigned Subjects
Their Assignments
Attendance for Assigned Classes
Marks for Authorized Subjects
Relevant Announcements
Period Requests
Notifications
Their Profile
```

Faculty members should not directly access:

```text
Other Faculty's Private Information
Unassigned Class Records
Other Students' Unrelated Records
Master System Configuration
User Management
Database Configuration
```

---

# 41. Faculty Logout Flow

```text
Faculty Dashboard
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
Faculty
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

# 42. Complete Faculty Flow

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
                                  Faculty Dashboard
                                         │
      ┌──────────────────────────────────┼──────────────────────────────────┐
      ↓                  ↓                ↓                ↓                ↓
  Timetable         Assignments       Attendance       Calendar       Notifications
      │                  │                │                │                │
      ↓                  ↓                ↓                ↓                ↓
 Teaching Schedule  Create/Edit       Mark/View       Period Requests   In-App
 Classes/Subjects   Set Deadline      Attendance       Temporary Changes Email
 Upload Questions                                    Calendar Events     WhatsApp
      │                  │                │                │
      └──────────────────┴────────────────┴────────────────┘
                                         │
                                         ↓
                                  Period Management
                                         │
                             ┌───────────┴───────────┐
                             ↓                       ↓
                    Substitute Request       Borrow Period
                             │                       │
                             ↓                       ↓
                         Other Faculty          Other Faculty
                             │                       │
                       ┌─────┴─────┐           ┌─────┴─────┐
                       ↓           ↓           ↓           ↓
                    ACCEPT       REJECT      ACCEPT       REJECT
                       │           │           │           │
                       ↓           ↓           ↓           ↓
                 Temp Change    Closed    Temp Change   Closed
                       │                       │
                       └───────────┬───────────┘
                                   ↓
                            Student Timetable
                                   │
                                   ↓
                              Notifications
                                   │
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

# 43. Faculty Request Architecture

Every major faculty feature should follow the layered request architecture.

```text
Faculty
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
Faculty
```

Examples:

```text
Assignments
    → AssignmentServlet
    → AssignmentService
    → AssignmentRepository

Timetable
    → TimetableServlet
    → TimetableService
    → TimetableRepository

Attendance
    → AttendanceServlet
    → AttendanceService
    → AttendanceRepository

Results
    → ResultServlet
    → ResultService
    → ResultRepository

Period Requests
    → PeriodRequestServlet
    → PeriodRequestService
    → PeriodRequestRepository

Notifications
    → NotificationServlet
    → NotificationService
    → NotificationRepository
```

---

# 44. Faculty Flow Design Rules

The following rules will be maintained during implementation:

1. Faculty members must authenticate before accessing protected pages.
2. Faculty permissions must be verified on the server side.
3. JSP pages must not directly access MySQL.
4. Servlets must not contain complex business logic.
5. Services must contain business rules.
6. Repositories must handle database operations.
7. JDBC must handle database connectivity.
8. Faculty members can manage only authorized academic records.
9. Faculty members can create assignments for authorized classes and subjects.
10. Assignment deadlines must be stored centrally and reflected in student calendars.
11. Assignment questions can contain text and supported file uploads.
12. Attendance must be restricted to authorized classes and subjects.
13. Marks/results must be restricted to authorized classes and subjects.
14. Period requests must be validated for conflicts before creation.
15. A substitute period keeps the original subject but changes the teaching faculty temporarily.
16. A borrowed period allows the requesting faculty member to teach their own subject temporarily.
17. The original timetable must not be permanently overwritten by temporary changes.
18. Approved temporary changes must appear in the student timetable.
19. Faculty members can accept or reject received requests.
20. Reply notes are optional.
21. Request status and history must be preserved.
22. Notifications should be generated for relevant request events.
23. Logout must invalidate the active session.
24. Sensitive system information must not be exposed to faculty users.

---

# 45. Final Faculty Module Flow

```text
                         FACULTY MODULE
                              │
                              ↓
                         Authentication
                              │
                              ↓
                      Faculty Dashboard
                              │
      ┌───────────────────────┼────────────────────────┐
      ↓                       ↓                        ↓
   Timetable              Assignments              Attendance
      │                       │                        │
      ↓                       ↓                        ↓
Teaching Schedule       Create / Edit             Mark / View
Classes / Subjects      Questions / Files         Attendance
                              │
                              ↓
                         Set Deadline
                              │
                              ↓
                           Calendar
                              │
      ┌───────────────────────┼────────────────────────┐
      ↓                       ↓                        ↓
Substitute Request      Borrow Period            Notifications
      │                       │                        │
      ↓                       ↓                        ↓
Other Faculty           Other Faculty            In-App / Email /
      │                       │                   WhatsApp
      ↓                       ↓
Accept / Reject         Accept / Reject
      │                       │
      ↓                       ↓
Temporary Change       Temporary Change
      │                       │
      └───────────────┬───────┘
                      ↓
               Student Timetable
                      │
                      ↓
                  Results / Marks
                      │
                      ↓
                 Announcements
                      │
                      ↓
                    Profile
                      │
                      ↓
                    Logout
```

This document defines the complete faculty-side workflow and will be used as the foundation for the **Faculty UI Design, Faculty Servlet Design, Faculty Service Design, Faculty Repository Design, Period Management Design, Notification Design, and Database Design** phases.
