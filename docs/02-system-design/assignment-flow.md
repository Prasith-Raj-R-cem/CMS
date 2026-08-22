# Assignment Flow

## 1. Overview

The Assignment Module manages the complete lifecycle of academic assignments in the Campus Management System.

The module allows faculty members to create assignments for their authorized classes and subjects, while students can view relevant assignments and their deadlines.

The current system focuses on:

- Assignment creation
- Assignment editing
- Assignment deletion/deactivation
- Text-based questions
- Image/document question uploads
- Submission deadline management
- Student assignment viewing
- Calendar integration
- Assignment status
- Notifications
- Authorization
- File validation
- Repository-based database access

A full student assignment submission workflow can be added later as an extension if required.

---

# 2. Assignment Architecture

The Assignment Module follows the project's standard layered architecture.

```text
                         ASSIGNMENT MODULE
                                │
                                ↓
                           Browser
                                │
                                ↓
                         JSP / HTML / JS
                                │
                                ↓
                    AssignmentServlet
                       CONTROLLER
                                │
                                ↓
                     AssignmentService
                      BUSINESS LOGIC
                                │
                                ↓
                   AssignmentRepository
                       DATA ACCESS
                                │
                                ↓
                              JDBC
                                │
                                ↓
                             MySQL
```

The same architecture is used for both faculty and student operations.

---

# 3. Assignment Actors

The primary actors are:

```text
Faculty
   │
   ├── Create Assignment
   ├── Edit Assignment
   ├── Delete / Deactivate Assignment
   ├── Set Deadline
   └── Upload Question

Student
   │
   ├── View Assignment
   ├── View Question
   ├── View Attachment
   ├── View Deadline
   └── View Calendar / Notifications

Admin
   │
   └── Monitor Assignment Data
```

---

# 4. Complete Assignment Lifecycle

```text
                         FACULTY
                            │
                            ↓
                    Create Assignment
                            │
                            ↓
                   Enter Assignment Data
                            │
              ┌─────────────┼─────────────┐
              ↓             ↓             ↓
          Question       Attachment     Deadline
            Text        Image/File       Date/Time
              │             │             │
              └─────────────┼─────────────┘
                            ↓
                    AssignmentServlet
                            │
                            ↓
                    AssignmentService
                            │
                            ↓
                         Validate
                            │
                       ┌────┴────┐
                       ↓         ↓
                    INVALID     VALID
                       │         │
                       ↓         ↓
                   Show Error  Repository
                                 │
                                 ↓
                                JDBC
                                 │
                                 ↓
                               MySQL
                                 │
                    ┌────────────┼────────────┐
                    ↓            ↓            ↓
                 Student      Calendar   Notification
                    │            │            │
                    ↓            ↓            ↓
               Assignment     Deadline      In-App
                  View          Event       Email
                                             WhatsApp
```

---

# 5. Assignment Creation Flow

Faculty members can create an assignment for a class and subject they are authorized to teach.

```text
Faculty
   ↓
Faculty Dashboard
   ↓
Assignments
   ↓
Create Assignment
   ↓
Assignment Form
   ↓
Enter Assignment Information
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
JDBC
   ↓
MySQL
   ↓
Assignment Created
```

---

# 6. Assignment Form

The assignment creation form may contain:

```text
Assignment Title
Description
Class
Subject
Question Text
Question File
Submission Date
Submission Time
```

Example:

```text
Title:
OOP Mini Assignment 01

Class:
S2 CSE

Subject:
Object Oriented Programming

Question:
Implement a Java program demonstrating inheritance.

Deadline:
25-09-2026
11:59 PM
```

---

# 7. Class and Subject Selection

The faculty member should only be able to select classes and subjects they are authorized to teach.

```text
Faculty
   ↓
Create Assignment
   ↓
Load Authorized Classes
   ↓
Select Class
   ↓
Load Authorized Subjects
   ↓
Select Subject
   ↓
Continue
```

Authorization must be checked again on the server side.

The system must not trust only the class/subject values sent by the browser.

---

# 8. Question Input Flow

The assignment question can be entered as text.

```text
Faculty
   ↓
Question Text Field
   ↓
Enter Question
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
Validate Text
   ↓
Store Assignment
```

Example:

```text
Question:

Write a Java program to demonstrate
method overriding using inheritance.
```

---

# 9. Question File Upload Flow

The system can also support question files such as images or documents.

```text
Faculty
   ↓
Assignment Form
   ↓
Choose File
   ↓
Upload
   ↓
AssignmentServlet
   ↓
File Validation
   │
   ├── File Type
   ├── File Size
   └── File Name
   ↓
Store File
   ↓
Store File Reference / Metadata
   ↓
AssignmentRepository
   ↓
MySQL
```

The database should normally store the file reference/metadata rather than unnecessarily storing large binary files directly in ordinary assignment records.

---

# 10. Supported Question Types

The assignment can support:

```text
TEXT
IMAGE
DOCUMENT
```

The system can also support a combination.

Example:

```text
Assignment
   │
   ├── Question Text
   │
   └── Question Image
```

or:

```text
Assignment
   │
   └── Question Document
```

---

# 11. File Validation

Before accepting an uploaded question file:

```text
Uploaded File
      ↓
Check File Name
      ↓
Check File Extension / MIME Type
      ↓
Check File Size
      ↓
Check Upload Error
      ↓
Check Faculty Authorization
      ↓
Valid?
  ┌───┴───┐
  ↓       ↓
 NO      YES
  │        │
  ↓        ↓
Error    Store File
```

The allowed file types and maximum file size will be finalized during the security and requirements phase.

---

# 12. Deadline Flow

The faculty member must specify the assignment submission deadline.

```text
Faculty
   ↓
Create Assignment
   ↓
Set Date
   ↓
Set Time
   ↓
Validate Deadline
   ↓
Save Assignment
```

The system should reject invalid deadlines.

Possible validation rules:

```text
Deadline cannot be empty
Deadline must be valid
Deadline should normally be in the future
Date/time format must be valid
```

The exact rule for editing an already-published deadline will be defined later.

---

# 13. Assignment Validation Flow

Before creating an assignment:

```text
Assignment Data
      ↓
Check Title
      ↓
Check Class
      ↓
Check Subject
      ↓
Check Faculty Authorization
      ↓
Check Question
      ↓
Check File
      ↓
Check Deadline
      ↓
Check Duplicate / Business Rules
      ↓
Valid?
  ┌───┴───┐
  ↓       ↓
 NO      YES
  │        │
  ↓        ↓
Show     Save
Error
```

---

# 14. Assignment Service Flow

The `AssignmentService` contains the business rules.

```text
AssignmentServlet
       ↓
AssignmentService
       │
       ├── Validate Input
       ├── Validate Faculty
       ├── Validate Class
       ├── Validate Subject
       ├── Validate Deadline
       ├── Validate File
       └── Call Repository
       ↓
AssignmentRepository
```

The Service layer should not directly execute SQL.

---

# 15. Assignment Repository Flow

The Repository handles database operations.

```text
AssignmentService
       ↓
AssignmentRepository
       │
       ├── create()
       ├── findById()
       ├── findByClass()
       ├── findByFaculty()
       ├── update()
       ├── delete()
       └── deactivate()
       ↓
JDBC
       ↓
MySQL
```

Exact method names can be refined during implementation.

---

# 16. Database Creation Flow

```text
AssignmentRepository
       ↓
JDBC Connection
       ↓
PreparedStatement
       ↓
INSERT Assignment
       ↓
MySQL
       ↓
Generated Assignment ID
       ↓
Return Result
       ↓
AssignmentService
       ↓
AssignmentServlet
```

Example conceptual operation:

```text
INSERT
INTO assignments
(
    title,
    description,
    class_id,
    subject_id,
    faculty_id,
    deadline
)
VALUES
(
    ?,
    ?,
    ?,
    ?,
    ?,
    ?
);
```

Parameterized queries must be used.

---

# 17. Assignment Creation Success Flow

After successful creation:

```text
Assignment Created
       │
       ├────────────────┬────────────────┐
       ↓                ↓                ↓
Assignment Record   Calendar Event   Notification Event
       │                │                │
       ↓                ↓                ↓
     MySQL           Student          Notification
                        Calendar         Service
```

The assignment becomes available to students belonging to the selected class.

---

# 18. Student Assignment Retrieval

Students should see only assignments relevant to their class.

```text
Student
   ↓
Assignments
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
Get Student Class
   ↓
AssignmentRepository
   ↓
Find Assignments By Class
   ↓
JDBC
   ↓
MySQL
   ↓
Assignment List
   ↓
Assignment JSP
   ↓
Student
```

---

# 19. Student Assignment List

The student assignment page can show:

```text
Assignment Title
Subject
Faculty
Deadline
Status
```

Example:

```text
-------------------------------------------------
OOP Mini Assignment 01

Subject: Object Oriented Programming
Faculty: Faculty B
Deadline: 25-09-2026 11:59 PM

Status: PENDING
-------------------------------------------------
```

---

# 20. Student Assignment Details

When a student selects an assignment:

```text
Student
   ↓
Select Assignment
   ↓
Assignment Details
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Retrieve Assignment
   ↓
Assignment Details JSP
   ↓
Student
```

The details page may contain:

```text
Title
Description
Subject
Faculty
Question Text
Question File
Assigned Date
Deadline
Status
```

---

# 21. Assignment Authorization for Students

Students must only access assignments intended for their class.

```text
Student
   ↓
Request Assignment
   ↓
Session Validation
   ↓
Get Student Class
   ↓
Get Assignment Class
   ↓
Classes Match?
   ┌───┴───┐
   ↓       ↓
 YES      NO
  │        │
  ↓        ↓
ALLOW     DENY
```

This check should happen on the server side.

---

# 22. Assignment Status

The assignment status can be calculated from the deadline and, if submission functionality is later implemented, submission state.

Current planned statuses:

```text
PENDING
DUE SOON
OVERDUE
```

Future submission-related statuses may include:

```text
SUBMITTED
LATE
```

---

# 23. Assignment Status Flow

```text
Assignment
    ↓
Check Current Date/Time
    ↓
Deadline Passed?
    │
 ┌──┴──┐
 ↓     ↓
YES    NO
 │      │
 ↓      ↓
OVERDUE Check Near Deadline
          │
       ┌──┴──┐
       ↓     ↓
      YES    NO
       │      │
       ↓      ↓
   DUE SOON  PENDING
```

The exact "due soon" threshold will be defined in the notification requirements.

---

# 24. Assignment Calendar Integration

Every valid assignment deadline should be available to the relevant students through the calendar.

```text
Assignment Created
       ↓
Assignment Deadline
       ↓
CalendarService
       ↓
Calendar Event
       ↓
Student Calendar
       ↓
Display Deadline
```

Example:

```text
25 September

OOP Assignment
Deadline: 11:59 PM
```

---

# 25. Calendar Event Architecture

The calendar event can be generated from the assignment record.

```text
Assignment
   │
   ├── Title
   ├── Subject
   ├── Class
   └── Deadline
         │
         ↓
    CalendarService
         │
         ↓
    Calendar Event
         │
         ↓
    Student Calendar
```

The assignment should remain the source of truth for the deadline.

---

# 26. Deadline Notification Flow

When an assignment deadline approaches:

```text
Assignment
   ↓
Deadline
   ↓
Notification Scheduler / Notification Process
   ↓
Check Reminder Rule
   ↓
Reminder Required?
   │
 ┌─┴─┐
 ↓   ↓
YES  NO
 │    │
 ↓    ↓
Create Continue
Notification
```

Notification channels:

```text
In-App
Email
WhatsApp
```

---

# 27. Assignment Notification Architecture

```text
                     Assignment Event
                            │
                            ↓
                  NotificationService
                            │
              ┌─────────────┼─────────────┐
              ↓             ↓             ↓
         App Adapter    Email Adapter  WhatsApp Adapter
              │             │             │
              └─────────────┼─────────────┘
                            ↓
                         Student
```

The Adapter approach keeps external notification providers separate from the assignment business logic.

---

# 28. Assignment Notification Events

Possible events include:

```text
New Assignment
Assignment Deadline Approaching
Deadline Changed
Assignment Cancelled / Deactivated
```

For example:

```text
Faculty Creates Assignment
       ↓
Assignment Saved
       ↓
NotificationService
       ↓
Student Notification
```

---

# 29. Assignment Edit Flow

Faculty can edit an assignment they own or are authorized to manage.

```text
Faculty
   ↓
My Assignments
   ↓
Select Assignment
   ↓
Edit
   ↓
Load Existing Data
   ↓
Assignment Form
   ↓
Modify
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
Authorization
   ↓
Validation
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Updated Assignment
```

---

# 30. Editing the Deadline

If a deadline is changed:

```text
Faculty
   ↓
Edit Assignment
   ↓
Change Deadline
   ↓
AssignmentService
   ↓
Validate New Deadline
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Updated Deadline
   ↓
Update Calendar Event
   ↓
Notification Event
```

Students should see the updated deadline.

---

# 31. Assignment Delete / Deactivation Flow

```text
Faculty
   ↓
My Assignments
   ↓
Select Assignment
   ↓
Delete / Deactivate
   ↓
Confirmation
   ↓
AssignmentService
   ↓
Authorization
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Assignment Status Updated
```

A soft-delete/deactivation approach is preferable when historical records or audit information must be preserved.

Possible status:

```text
ACTIVE
INACTIVE
```

---

# 32. Assignment Deactivation Effect

When an assignment is deactivated:

```text
Assignment
     ↓
Status = INACTIVE
     ↓
Student Assignment List
     ↓
Do Not Display as Active
```

The system may retain the record for administrative or audit purposes.

The exact visibility rules will be finalized later.

---

# 33. Assignment Deadline Change Notification

```text
Existing Assignment
       ↓
Faculty Changes Deadline
       ↓
Validate
       ↓
Save New Deadline
       ↓
Compare Old vs New
       ↓
Deadline Changed
       ↓
NotificationService
       ↓
Relevant Students
       ↓
In-App / Email / WhatsApp
```

---

# 34. Assignment Access Flow

```text
Student
   ↓
Open Assignment
   ↓
Check Session
   ↓
Check Student Role
   ↓
Check Student Class
   ↓
Check Assignment Status
   ↓
Allow Access?
   ┌────┴────┐
   ↓         ↓
  YES        NO
   │          │
   ↓          ↓
Display     Access Denied /
Assignment  Not Available
```

---

# 35. Assignment File Access

When a student opens an assignment attachment:

```text
Student
   ↓
Assignment Details
   ↓
Select Attachment
   ↓
File Access Request
   ↓
Validate Session
   ↓
Validate Assignment Access
   ↓
Validate File Reference
   ↓
Return File
```

The file should not be exposed through an unrestricted public path if access control is required.

---

# 36. Faculty Assignment List

Faculty members can view assignments they created or are authorized to manage.

```text
Faculty
   ↓
My Assignments
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Find By Faculty
   ↓
Assignment List
```

The list can show:

```text
Title
Class
Subject
Deadline
Status
Created Date
```

---

# 37. Admin Assignment Monitoring

Admin can monitor assignment information.

```text
Admin
   ↓
Assignment Monitoring
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Assignment Records
```

Admin may filter by:

```text
Department
Class
Subject
Faculty
Date
Status
```

The Admin monitoring feature should not unnecessarily alter faculty-owned assignments.

---

# 38. Assignment Database Relationship

The Assignment entity depends on several academic entities.

Conceptually:

```text
Department
    │
    ↓
Class
    │
    ↓
Assignment
    │
    ├────────→ Subject
    │
    ├────────→ Faculty
    │
    └────────→ Assignment File
```

The assignment is also connected to:

```text
Student Class
Calendar Event
Notification
```

---

# 39. Conceptual Assignment Data

The assignment record may contain:

```text
Assignment ID
Title
Description
Class ID
Subject ID
Faculty ID
Question Text
Deadline
Created At
Updated At
Status
```

A separate file metadata record may contain:

```text
File ID
Assignment ID
Original File Name
Stored File Name / Reference
File Type
File Size
Created At
```

Exact table structure will be defined in the database design document.

---

# 40. Assignment Request Architecture

### Faculty Create

```text
Faculty
   ↓
assignment-create.jsp
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
```

### Student View

```text
Student
   ↓
assignments.jsp
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
```

### Faculty Edit

```text
Faculty
   ↓
assignment-edit.jsp
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
```

---

# 41. Assignment Exception Flow

Possible exceptions include:

```text
AssignmentNotFoundException
UnauthorizedAssignmentAccessException
InvalidAssignmentException
InvalidDeadlineException
FileUploadException
InvalidFileTypeException
FileSizeExceededException
DatabaseException
```

Flow:

```text
Assignment Operation
       ↓
Service
       ↓
Exception
       ↓
Servlet
       ↓
Error Handling
       ↓
JSP Error Message
```

Example:

```text
Faculty attempts to edit another faculty's assignment
       ↓
Authorization Check
       ↓
UnauthorizedAssignmentAccessException
       ↓
Controller
       ↓
Access Denied Message
```

---

# 42. Complete Faculty Assignment Creation Flow

```text
                              FACULTY
                                 │
                                 ↓
                         Assignment Page
                                 │
                                 ↓
                         Create Assignment
                                 │
                                 ↓
                         Select Class
                                 │
                                 ↓
                        Select Subject
                                 │
                                 ↓
                       Enter Assignment
                                 │
                    ┌────────────┼────────────┐
                    ↓            ↓            ↓
                Text Question  File Upload  Deadline
                    │            │            │
                    └────────────┼────────────┘
                                 ↓
                        AssignmentServlet
                                 │
                                 ↓
                        AssignmentService
                                 │
              ┌──────────────────┼──────────────────┐
              ↓                  ↓                  ↓
       Authorization         Validation        File Validation
              │                  │                  │
              └──────────────────┼──────────────────┘
                                 ↓
                      AssignmentRepository
                                 │
                                 ↓
                                JDBC
                                 │
                                 ↓
                               MySQL
                                 │
             ┌───────────────────┼───────────────────┐
             ↓                   ↓                   ↓
       Assignment Saved      Calendar Event      Notification
             │                   │                   │
             ↓                   ↓                   ↓
          Faculty             Students            Students
```

---

# 43. Complete Student Assignment View Flow

```text
                              STUDENT
                                 │
                                 ↓
                          Assignments Page
                                 │
                                 ↓
                        AssignmentServlet
                                 │
                                 ↓
                        AssignmentService
                                 │
                  ┌──────────────┼──────────────┐
                  ↓              ↓              ↓
             Session Check   Class Check   Assignment Check
                  │              │              │
                  └──────────────┼──────────────┘
                                 ↓
                      AssignmentRepository
                                 │
                                 ↓
                                JDBC
                                 │
                                 ↓
                               MySQL
                                 │
                                 ↓
                         Assignment Details
                                 │
                 ┌───────────────┼───────────────┐
                 ↓               ↓               ↓
             Question Text    Attachment       Deadline
                 │               │               │
                 └───────────────┼───────────────┘
                                 ↓
                              Student
```

---

# 44. Complete Assignment Notification Flow

```text
                     ASSIGNMENT EVENT
                            │
              ┌─────────────┼─────────────┐
              ↓             ↓             ↓
        New Assignment  Deadline Change  Deadline Near
              │             │             │
              └─────────────┼─────────────┘
                            ↓
                  NotificationService
                            │
              ┌─────────────┼─────────────┐
              ↓             ↓             ↓
           In-App          Email        WhatsApp
              │             │             │
              └─────────────┼─────────────┘
                            ↓
                         Student
```

---

# 45. Future Assignment Submission Extension

The current Assignment Module primarily handles assignment creation, deadlines, viewing, and notifications.

A future extension can add student submission.

```text
Student
   ↓
Open Assignment
   ↓
Upload Answer
   ↓
AssignmentSubmissionServlet
   ↓
SubmissionService
   ↓
Validate Submission
   ↓
SubmissionRepository
   ↓
MySQL / File Storage
   ↓
Submission Created
   ↓
Faculty
   ↓
View Submission
   ↓
Evaluate
   ↓
Feedback / Marks
```

Possible future statuses:

```text
NOT SUBMITTED
SUBMITTED
LATE
EVALUATED
```

This workflow is intentionally separated from the current core Assignment Flow.

---

# 46. Security Rules

The Assignment Module must follow these security rules:

```text
1. Authenticate user
2. Validate user role
3. Validate faculty authorization
4. Validate student class access
5. Validate uploaded file
6. Use PreparedStatement
7. Do not expose database credentials
8. Do not expose unrestricted file paths
9. Validate all server-side input
10. Do not trust client-side authorization
```

---

# 47. Assignment Design Rules

The following rules will be maintained:

1. Faculty can create assignments only for authorized classes and subjects.
2. Students can view only assignments relevant to their class.
3. Assignment questions can be text-based.
4. Assignment questions can contain supported image/document files.
5. File type and size must be validated.
6. Assignment deadlines must be validated.
7. Assignment deadlines must appear in the student calendar.
8. Assignment events can trigger notifications.
9. Faculty can edit their authorized assignments.
10. Faculty can delete or deactivate their authorized assignments.
11. Deadline changes should update the associated calendar information.
12. Relevant students should be notified about important assignment changes.
13. JSP must not directly access the database.
14. Servlets must not contain complex business logic.
15. Services must contain assignment business rules.
16. Repositories must contain assignment data-access operations.
17. JDBC must handle database communication.
18. Assignment records should preserve appropriate historical information.
19. Student access must be validated server-side.
20. Future assignment submission functionality should be implemented as a separate module.

---

# 48. Final Assignment Module Flow

```text
                         ASSIGNMENT MODULE
                                │
                                ↓
                     ┌─────────────────────┐
                     │       FACULTY       │
                     └──────────┬──────────┘
                                ↓
                       Create Assignment
                                │
          ┌─────────────────────┼─────────────────────┐
          ↓                     ↓                     ↓
     Class / Subject       Question Text          File Upload
          │                     │                     │
          └─────────────────────┼─────────────────────┘
                                ↓
                            Deadline
                                │
                                ↓
                       AssignmentServlet
                                │
                                ↓
                       AssignmentService
                                │
                                ↓
                      AssignmentRepository
                                │
                                ↓
                               JDBC
                                │
                                ↓
                             MySQL
                                │
             ┌──────────────────┼──────────────────┐
             ↓                  ↓                  ↓
         Assignment          Calendar         Notification
             │                  │                  │
             ↓                  ↓                  ↓
          Students           Deadline         In-App / Email /
             │                Events            WhatsApp
             ↓
       View Assignment
             │
       ┌─────┼─────┐
       ↓     ↓     ↓
    Question File Deadline
       │     │     │
       └─────┼─────┘
             ↓
          Student
```

This document defines the complete current Assignment Module and provides the foundation for the **Assignment UI, Assignment Servlet, Assignment Service, Assignment Repository, Database Design, Calendar Integration, Notification Integration, and future Assignment Submission module**.
