# Timetable Flow

## 1. Overview

The Timetable Module manages the academic timetable used by administrators, faculty members, and students.

The system separates the **master timetable** from temporary timetable changes.

The Admin creates and manages the regular timetable. Faculty and students view timetable information generated from the master timetable. Approved substitute and borrowed-period requests create temporary timetable changes without permanently overwriting the original schedule.

The module supports:

- Class timetable management
- Faculty timetable management
- Student timetable viewing
- Day and period management
- Subject assignment
- Faculty assignment
- Room assignment
- Timetable conflict detection
- Faculty availability validation
- Class conflict validation
- Room conflict validation
- Substitute period requests
- Borrowed period requests
- Faculty calendar integration
- Temporary timetable changes
- Student timetable updates
- Temporary change expiration
- Timetable notifications
- Exam timetable separation
- Repository → JDBC → MySQL architecture

---

# 2. Timetable Architecture

The Timetable Module follows the project's standard layered architecture.

```text
                         TIMETABLE MODULE
                                │
                                ↓
                            Browser
                                │
                                ↓
                         JSP / HTML / JS
                                │
                                ↓
                       TimetableServlet
                           CONTROLLER
                                │
                                ↓
                        TimetableService
                         BUSINESS LOGIC
                                │
                                ↓
                       TimetableRepository
                          DATA ACCESS
                                │
                                ↓
                              JDBC
                                │
                                ↓
                             MySQL
```

---

# 3. Timetable Types

The system contains two major timetable categories.

```text
TIMETABLE
│
├── Regular Timetable
│   ├── Class Timetable
│   └── Faculty Timetable
│
└── Temporary Timetable Changes
    ├── Substitute Period
    └── Borrowed Period
```

The **Exam Timetable** is managed separately because examinations follow a different scheduling process.

---

# 4. Master Timetable Concept

The regular timetable is the master schedule created by Admin.

```text
                         ADMIN
                           │
                           ↓
                    Master Timetable
                           │
             ┌─────────────┼─────────────┐
             ↓             ↓             ↓
          Students       Faculty        Admin
             │             │             │
             ↓             ↓             ↓
       Class Timetable  Teaching       Management
                         Timetable
```

The master timetable acts as the permanent base schedule.

Temporary changes should not directly overwrite it.

---

# 5. Complete Timetable Flow

```text
                           ADMIN
                             │
                             ↓
                    Timetable Management
                             │
                             ↓
                     Select Academic Year
                             │
                             ↓
                        Select Semester
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
                    Validate Timetable
                             │
                        ┌────┴────┐
                        ↓         ↓
                     CONFLICT   VALID
                        │         │
                        ↓         ↓
                    Show Error   Save
                                  │
                                  ↓
                         Master Timetable
                                  │
                   ┌──────────────┼──────────────┐
                   ↓              ↓              ↓
                Student         Faculty         Admin
                   │              │              │
                   ↓              ↓              ↓
               View Class     View Teaching    Manage
               Timetable       Timetable      Timetable
```

---

# 6. Timetable Data

A regular timetable entry may contain:

```text
Timetable ID
Academic Year
Semester
Class
Day
Period
Start Time
End Time
Subject
Faculty
Room
Status
```

Exact database fields will be finalized during the Database Design phase.

---

# 7. Timetable Creation Flow

Admin creates the master timetable through the timetable management interface.

```text
Admin
   ↓
Timetable Management
   ↓
Create Timetable Entry
   ↓
Select Academic Year
   ↓
Select Semester
   ↓
Select Class
   ↓
Select Day
   ↓
Select Period
   ↓
Select Subject
   ↓
Select Faculty
   ↓
Select Room
   ↓
Validate
   ↓
Save
```

---

# 8. Timetable Entry Validation

Before saving a timetable entry, the system validates:

```text
Class
Subject
Faculty
Room
Day
Period
Academic Year
Semester
```

The system should also check whether the selected values are compatible.

```text
New Timetable Entry
       ↓
Validate Academic Period
       ↓
Validate Class
       ↓
Validate Subject
       ↓
Validate Faculty
       ↓
Validate Room
       ↓
Check Conflicts
       ↓
Save / Reject
```

---

# 9. Class Conflict

A class cannot normally have two subjects during the same period.

```text
New Entry
   ↓
Class = S2 CSE
Day = Monday
Period = 3
   ↓
Search Existing Timetable
   ↓
Class already occupied?
   │
 ┌─┴─┐
 ↓   ↓
YES  NO
 │    │
 ↓    ↓
Error Save
```

Example:

```text
Existing:

Monday
10:00 - 11:00
S2 CSE
Data Structures

New:

Monday
10:00 - 11:00
S2 CSE
OOP

Result:
CONFLICT
```

---

# 10. Faculty Conflict

A faculty member cannot normally teach two classes during the same period.

```text
New Entry
   ↓
Faculty = Faculty A
Day = Monday
Period = 3
   ↓
Check Faculty Timetable
   ↓
Already Assigned?
   │
 ┌─┴─┐
 ↓   ↓
YES  NO
 │    │
 ↓    ↓
Error Save
```

Example:

```text
Faculty A

Monday
10:00 - 11:00
S2 CSE
Data Structures

Attempt:

Monday
10:00 - 11:00
S3 CSE
OOP

Result:
CONFLICT
```

---

# 11. Room Conflict

A room cannot normally be assigned to two classes during the same period.

```text
New Entry
   ↓
Room = 201
Day = Monday
Period = 3
   ↓
Check Room Schedule
   ↓
Room occupied?
   │
 ┌─┴─┐
 ↓   ↓
YES  NO
 │    │
 ↓    ↓
Error Save
```

---

# 12. Complete Conflict Validation

```text
                    NEW TIMETABLE ENTRY
                            │
                            ↓
                 Academic Period Check
                            │
                            ↓
                       Class Check
                            │
                            ↓
                      Subject Check
                            │
                            ↓
                      Faculty Check
                            │
                            ↓
                       Room Check
                            │
                            ↓
                     Conflict Check
                            │
                   ┌────────┴────────┐
                   ↓                 ↓
                CONFLICT           VALID
                   │                 │
                   ↓                 ↓
               Show Error           Save
                                     │
                                     ↓
                              Master Timetable
```

---

# 13. Timetable Repository Flow

The Repository Layer handles timetable database operations.

```text
TimetableService
       ↓
TimetableRepository
       │
       ├── create()
       ├── findByClass()
       ├── findByFaculty()
       ├── findByDay()
       ├── findByPeriod()
       ├── update()
       ├── delete()
       └── checkConflict()
       ↓
JDBC
       ↓
MySQL
```

The exact method names can be refined during implementation.

---

# 14. Timetable Service Flow

The Service Layer contains timetable business rules.

```text
TimetableServlet
       ↓
TimetableService
       │
       ├── Validate Academic Period
       ├── Validate Class
       ├── Validate Subject
       ├── Validate Faculty
       ├── Validate Room
       ├── Check Class Conflict
       ├── Check Faculty Conflict
       ├── Check Room Conflict
       └── Call Repository
       ↓
TimetableRepository
```

The Service must not contain direct SQL queries.

---

# 15. Timetable Database Flow

```text
TimetableService
       ↓
TimetableRepository
       ↓
JDBC Connection
       ↓
PreparedStatement
       ↓
SQL Query
       ↓
MySQL
       ↓
ResultSet / Update Count
       ↓
Repository
       ↓
Service
       ↓
Servlet
```

Parameterized SQL queries must be used.

---

# 16. Student Timetable Flow

Students can view the timetable associated with their class.

```text
Student
   ↓
Student Timetable
   ↓
TimetableServlet
   ↓
TimetableService
   ↓
Get Student Class
   ↓
TimetableRepository
   ↓
Retrieve Master Timetable
   ↓
Check Temporary Changes
   ↓
Apply Active Changes
   ↓
Return Timetable
   ↓
Student Timetable JSP
   ↓
Student
```

---

# 17. Faculty Timetable Flow

Faculty members can view their teaching schedule.

```text
Faculty
   ↓
Faculty Timetable
   ↓
TimetableServlet
   ↓
TimetableService
   ↓
Get Faculty ID
   ↓
TimetableRepository
   ↓
Retrieve Master Timetable
   ↓
Check Temporary Changes
   ↓
Apply Active Changes
   ↓
Faculty Timetable JSP
   ↓
Faculty
```

---

# 18. Student and Faculty Timetable Relationship

Both views should be generated from the same master timetable.

```text
                     MASTER TIMETABLE
                            │
              ┌─────────────┴─────────────┐
              ↓                           ↓
        CLASS-BASED VIEW             FACULTY-BASED VIEW
              │                           │
              ↓                           ↓
           STUDENT                     FACULTY
```

Example:

```text
Master Record:

Monday
10:00 - 11:00
S2 CSE
Data Structures
Faculty A
Room 201
```

Student sees:

```text
10:00 - 11:00
Data Structures
Faculty A
Room 201
```

Faculty A sees:

```text
10:00 - 11:00
S2 CSE
Data Structures
Room 201
```

The underlying schedule remains the same.

---

# 19. Faculty Calendar Integration

The Faculty Calendar provides a convenient way to view periods and request changes.

```text
Faculty
   ↓
Faculty Calendar
   ↓
Load Timetable
   ↓
Display Periods
   ↓
Select Period
   ↓
Choose Action
```

Possible actions:

```text
View Period
Request Substitute
Borrow Period
View Request
```

---

# 20. Substitute Period Flow

A substitute period means another faculty member takes the original faculty member's period while teaching the **same subject**.

Example:

```text
Original:

10:00 - 11:00
S2 CSE
Data Structures
Faculty A


Temporary:

10:00 - 11:00
S2 CSE
Data Structures
Faculty B
[Substitute]
```

Important rule:

```text
Subject = Original Subject
Faculty = Substitute Faculty
```

---

# 21. Substitute Request Flow

```text
Faculty A
   ↓
Faculty Calendar
   ↓
Select Own Period
   ↓
Request Substitute
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
   ├── Period belongs to Faculty A?
   ├── Faculty B exists?
   ├── Faculty B available?
   ├── No conflict?
   └── Date valid?
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

# 22. Substitute Request Response

```text
                    FACULTY B
                        │
                        ↓
                 Period Request
                        │
              ┌─────────┴─────────┐
              ↓                   ↓
           ACCEPT                REJECT
              │                   │
              ↓                   ↓
      Optional Reply Note   Optional Reply Note
              │                   │
              ↓                   ↓
       Update Request Status
              │
        ┌─────┴─────┐
        ↓           ↓
     ACCEPTED     REJECTED
        │           │
        ↓           ↓
 Temporary       Request
  Change          Closed
        │
        ↓
 Student Timetable
        │
        ↓
 Notification
```

---

# 23. Borrowed Period Flow

A borrowed period means another faculty member uses an existing period to teach **their own subject**.

Example:

```text
Original:

10:00 - 11:00
S2 CSE
Data Structures
Faculty A


Temporary:

10:00 - 11:00
S2 CSE
OOP
Faculty B
[Borrowed]
```

Important rule:

```text
Subject = Borrowing Faculty's Subject
Faculty = Borrowing Faculty
```

---

# 24. Borrow Request Flow

```text
Faculty B
   ↓
Faculty Calendar
   ↓
Select Another Faculty's Period
   ↓
Borrow Period
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
   ├── Faculty B teaches selected subject?
   ├── Selected class valid?
   ├── Faculty B available?
   ├── Period available?
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

# 25. Borrow Request Response

```text
                    ORIGINAL FACULTY
                           │
                           ↓
                    Borrow Request
                           │
                ┌──────────┴──────────┐
                ↓                     ↓
             ACCEPT                  REJECT
                │                     │
                ↓                     ↓
        Optional Reply Note    Optional Reply Note
                │                     │
                ↓                     ↓
          Update Status
                │
          ┌─────┴─────┐
          ↓           ↓
       ACCEPTED     REJECTED
          │           │
          ↓           ↓
 Temporary          Closed
  Change
          │
          ↓
 Student Timetable
          │
          ↓
 Notification
```

---

# 26. Substitute vs Borrowed Period

The two temporary changes must be clearly separated.

| Feature | Substitute Period | Borrowed Period |
|---|---|---|
| Requester | Faculty whose period is affected | Faculty who wants the period |
| Receiving Faculty | Substitute faculty | Original period owner |
| Subject | Original subject | Borrowing faculty's subject |
| Faculty shown | Substitute faculty | Borrowing faculty |
| Class | Original class | Selected valid class |
| Purpose | Cover a period | Use another period for own subject |
| Student timetable | Updated | Updated |

Example:

```text
SUBSTITUTE

Before:
Data Structures - Faculty A

After:
Data Structures - Faculty B


BORROWED

Before:
Data Structures - Faculty A

After:
OOP - Faculty B
```

---

# 27. Period Request Status

Period requests can have:

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

Flow:

```text
Create Request
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

---

# 28. Optional Reply Note

The faculty member receiving a request can add an optional response note.

```text
Request
   ↓
Accept / Reject
   ↓
Optional Reply Note
   ↓
Submit Response
   ↓
Save Status + Note
   ↓
Notify Requesting Faculty
```

Example:

```text
Status:
ACCEPTED

Reply:
"I can take this period."
```

or:

```text
Status:
REJECTED

Reply:
"I have another class at this time."
```

---

# 29. Temporary Timetable Architecture

Temporary changes should be stored separately from the master timetable.

```text
                  MASTER TIMETABLE
                         │
                         │
                         ├───────────────┐
                         │               │
                         ↓               ↓
                  Regular Schedule   Temporary Changes
                                         │
                                  ┌──────┴──────┐
                                  ↓             ↓
                              Substitute     Borrowed
                                  │             │
                                  └──────┬──────┘
                                         ↓
                                Effective Timetable
                                         │
                          ┌──────────────┴──────────────┐
                          ↓                             ↓
                       Student                       Faculty
```

This prevents temporary changes from destroying the original schedule.

---

# 30. Temporary Change Data

A temporary timetable record may contain:

```text
Temporary Change ID
Original Timetable ID
Request ID
Change Type
Class
Date
Period
Original Subject
Original Faculty
Temporary Subject
Temporary Faculty
Start Time
End Time
Status
Created At
```

Exact database fields will be finalized during Database Design.

---

# 31. Effective Timetable Logic

The system should determine what the user sees based on the current date.

```text
Request Timetable
       ↓
Load Master Timetable
       ↓
Find Active Temporary Changes
       ↓
Temporary Change Exists?
       │
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
Apply     Use Master
Change    Timetable
   │        │
   └────┬───┘
        ↓
Effective Timetable
        ↓
Display
```

---

# 32. Temporary Change Expiration

Temporary changes should only affect the specified date/period.

```text
Temporary Change
       ↓
Effective Date
       ↓
Current Date
       ↓
Is Active?
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
Apply     Ignore
Change    Change
   │        │
   └────┬───┘
        ↓
Effective Timetable
```

After the affected period passes, the master timetable automatically becomes the visible schedule again.

---

# 33. Example of Temporary Change Expiration

```text
Master:

Monday
10:00 - 11:00
Data Structures
Faculty A


Temporary Change:

Date: 25-09-2026
10:00 - 11:00
OOP
Faculty B
[Borrowed]
```

On 25-09-2026:

```text
Student sees:
OOP
Faculty B
[Borrowed]
```

On the next normal occurrence:

```text
Student sees:
Data Structures
Faculty A
```

The master record was never permanently changed.

---

# 34. Student Timetable Update

When a temporary change is approved:

```text
Request Approved
       ↓
Create Temporary Timetable Record
       ↓
Student Requests Timetable
       ↓
TimetableService
       ↓
Load Master Timetable
       ↓
Load Active Temporary Change
       ↓
Apply Temporary Change
       ↓
Student Sees Updated Schedule
```

---

# 35. Faculty Timetable Update

The same temporary change should appear in the faculty timetable.

```text
Approved Change
       ↓
Temporary Timetable Record
       ↓
Faculty Requests Timetable
       ↓
TimetableService
       ↓
Load Master + Temporary Data
       ↓
Apply Change
       ↓
Faculty Timetable
```

Example:

```text
Faculty A:

10:00 - 11:00
[Free / Period Given Away]
```

```text
Faculty B:

10:00 - 11:00
Data Structures
[Substitute]
```

For a borrowed period:

```text
Faculty B:

10:00 - 11:00
OOP
[Borrowed]
```

The exact UI representation can be finalized during UI design.

---

# 36. Notification Flow

Timetable events can generate notifications.

Possible events:

```text
Timetable Published
Timetable Updated
Temporary Period Approved
Temporary Period Rejected
Exam Timetable Published
```

Flow:

```text
Timetable Event
      ↓
NotificationService
      │
      ├──────────────┬──────────────┐
      ↓              ↓              ↓
    In-App          Email        WhatsApp
      │              │              │
      └──────────────┼──────────────┘
                     ↓
              Relevant Users
```

---

# 37. Timetable Publication Flow

When Admin creates or modifies the master timetable:

```text
Admin
   ↓
Create / Update Timetable
   ↓
Validate
   ↓
Save
   ↓
Publish / Activate
   ↓
Notification Event
   ↓
Students / Faculty
```

The exact publication model can be:

```text
DRAFT
PUBLISHED
ARCHIVED
```

if versioned timetable management is required.

---

# 38. Timetable Versioning

A future extension can support timetable versions.

```text
Timetable
   │
   ├── Version 1
   ├── Version 2
   └── Version 3
```

This can help preserve historical schedules.

For the initial mini project, a simpler active master timetable can be used while maintaining separate temporary-change records.

---

# 39. Exam Timetable Separation

The exam timetable is a separate module from the regular class timetable.

```text
                    TIMETABLE SYSTEM
                           │
              ┌────────────┴────────────┐
              ↓                         ↓
       REGULAR TIMETABLE           EXAM TIMETABLE
              │                         │
       ┌──────┴──────┐                  │
       ↓             ↓                  ↓
    Student        Faculty          Student / Faculty
```

Regular timetable:

```text
Daily Classes
Subjects
Faculty
Rooms
Periods
```

Exam timetable:

```text
Exam Date
Exam Time
Subject
Class
Room
Exam Type
```

---

# 40. Exam Timetable Flow

```text
Admin
   ↓
Exam Timetable Management
   ↓
Select Class
   ↓
Select Subject
   ↓
Set Date
   ↓
Set Time
   ↓
Set Room
   ↓
Validate
   ↓
Save
   ↓
Publish
   ↓
Students / Faculty
```

The detailed exam timetable workflow is documented separately in the Admin and future Examination flow documents.

---

# 41. Faculty Availability

Before approving or creating a temporary timetable change, the system should check faculty availability.

```text
Requested Period
       ↓
Find Faculty Schedule
       ↓
Faculty Already Teaching?
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
CONFLICT  AVAILABLE
```

For a substitute:

```text
Substitute Faculty
       ↓
Check Same Date + Period
       ↓
Available?
```

For a borrowed period:

```text
Borrowing Faculty
       ↓
Check Same Date + Period
       ↓
Available?
```

---

# 42. Class Availability

For borrowed periods, the selected class must also be validated.

```text
Borrow Request
       ↓
Selected Class
       ↓
Check Class Schedule
       ↓
Class Occupied?
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
CONFLICT  VALID
```

The exact business rule for whether an existing period can be borrowed will be finalized during requirements and database design.

---

# 43. Room Availability

Temporary changes involving room changes must also validate room availability.

```text
Temporary Change
       ↓
Room Required?
       │
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
Check Room Continue
Availability
   │
   ↓
Conflict?
```

---

# 44. Complete Temporary Change Validation

```text
                     REQUEST
                        │
                        ↓
                  Validate User
                        │
                        ↓
                 Validate Request
                        │
                        ↓
                  Check Class
                        │
                        ↓
                 Check Faculty
                        │
                        ↓
                   Check Room
                        │
                        ↓
                 Check Period
                        │
                        ↓
                  Check Date
                        │
                        ↓
                Any Conflict?
                   ┌────┴────┐
                   ↓         ↓
                  YES        NO
                   │         │
                   ↓         ↓
                Reject     Send Request
                              │
                              ↓
                       Other Faculty
                              │
                       ┌──────┴──────┐
                       ↓             ↓
                    ACCEPT         REJECT
                       │             │
                       ↓             ↓
                 Apply Change     Close Request
                       │
                       ↓
                Notify Students
```

---

# 45. Period Request Repository

Period requests should have their own Repository.

```text
PeriodRequestService
       ↓
PeriodRequestRepository
       │
       ├── createRequest()
       ├── findById()
       ├── findSentRequests()
       ├── findReceivedRequests()
       ├── updateStatus()
       ├── saveReplyNote()
       └── findHistory()
       ↓
JDBC
       ↓
MySQL
```

This keeps period-request data access separate from general timetable data access.

---

# 46. Temporary Timetable Repository

Temporary timetable changes can have a dedicated Repository.

```text
TemporaryTimetableService
       ↓
TemporaryTimetableRepository
       │
       ├── create()
       ├── findActiveChanges()
       ├── findByDate()
       ├── findByClass()
       ├── findByFaculty()
       └── deactivateExpired()
       ↓
JDBC
       ↓
MySQL
```

The exact separation between `TimetableRepository` and `TemporaryTimetableRepository` can be finalized during the repository design phase.

---

# 47. Complete Substitute Flow

```text
                         FACULTY A
                             │
                             ↓
                     Faculty Calendar
                             │
                             ↓
                      Select Own Period
                             │
                             ↓
                    Request Substitute
                             │
                             ↓
                       Select Faculty B
                             │
                             ↓
                       Optional Note
                             │
                             ↓
                   PeriodRequestServlet
                             │
                             ↓
                   PeriodRequestService
                             │
                             ↓
                    Conflict Validation
                             │
                             ↓
                   PeriodRequestRepository
                             │
                             ↓
                            MySQL
                             │
                             ↓
                     NotificationService
                             │
                             ↓
                         FACULTY B
                             │
                    ┌────────┴────────┐
                    ↓                 ↓
                 ACCEPT             REJECT
                    │                 │
                    ↓                 ↓
             Temporary Change      Closed
                    │
                    ↓
            Student Timetable
                    │
                    ↓
              Faculty Timetable
```

---

# 48. Complete Borrow Flow

```text
                         FACULTY B
                             │
                             ↓
                     Faculty Calendar
                             │
                             ↓
                 Select Another Period
                             │
                             ↓
                      Borrow Period
                             │
                             ↓
                     Select Own Subject
                             │
                             ↓
                        Select Class
                             │
                             ↓
                      Optional Note
                             │
                             ↓
                   PeriodRequestServlet
                             │
                             ↓
                   PeriodRequestService
                             │
                             ↓
                    Conflict Validation
                             │
                             ↓
                   PeriodRequestRepository
                             │
                             ↓
                            MySQL
                             │
                             ↓
                     NotificationService
                             │
                             ↓
                         FACULTY A
                             │
                    ┌────────┴────────┐
                    ↓                 ↓
                 ACCEPT             REJECT
                    │                 │
                    ↓                 ↓
             Temporary Change      Closed
                    │
                    ↓
            Student Timetable
                    │
                    ↓
              Faculty Timetable
```

---

# 49. Complete Student Timetable View

```text
                          STUDENT
                             │
                             ↓
                       Timetable Page
                             │
                             ↓
                    TimetableServlet
                             │
                             ↓
                    TimetableService
                             │
             ┌───────────────┼───────────────┐
             ↓               ↓               ↓
       Student Class    Master Timetable  Temporary Changes
             │               │               │
             └───────────────┼───────────────┘
                             ↓
                    Calculate Effective
                       Timetable
                             │
                             ↓
                        Timetable JSP
                             │
                             ↓
                           Student
```

---

# 50. Complete Faculty Timetable View

```text
                          FACULTY
                             │
                             ↓
                      Timetable Page
                             │
                             ↓
                   TimetableServlet
                             │
                             ↓
                   TimetableService
                             │
             ┌───────────────┼───────────────┐
             ↓               ↓               ↓
        Faculty ID      Master Timetable  Temporary Changes
             │               │               │
             └───────────────┼───────────────┘
                             ↓
                    Calculate Effective
                       Timetable
                             │
                             ↓
                       Timetable JSP
                             │
                             ↓
                           Faculty
```

---

# 51. Complete Admin Timetable Flow

```text
                            ADMIN
                              │
                              ↓
                    Timetable Management
                              │
                              ↓
                     Select Academic Data
                              │
                              ↓
                       Create / Edit Entry
                              │
             ┌────────────────┼────────────────┐
             ↓                ↓                ↓
           Class           Subject           Faculty
             │                │                │
             └────────────────┼────────────────┘
                              ↓
                             Room
                              │
                              ↓
                      Conflict Validation
                              │
                       ┌──────┴──────┐
                       ↓             ↓
                    CONFLICT        VALID
                       │             │
                       ↓             ↓
                    Error           Save
                                      │
                                      ↓
                               Master Timetable
                                      │
                    ┌─────────────────┼─────────────────┐
                    ↓                 ↓                 ↓
                 Student           Faculty            Admin
```

---

# 52. Timetable Notifications

Notifications should be generated for meaningful timetable events.

```text
Timetable Event
      │
      ├── Master Timetable Published
      ├── Master Timetable Updated
      ├── Substitute Approved
      ├── Borrow Request Approved
      ├── Period Request Rejected
      └── Temporary Change Created
      │
      ↓
NotificationService
      │
      ├── In-App
      ├── Email
      └── WhatsApp
```

---

# 53. Timetable Notification Example

When a borrowed period is approved:

```text
Borrow Request Approved
        ↓
Temporary Timetable Created
        ↓
NotificationService
        │
        ├──────────────┬──────────────┐
        ↓              ↓              ↓
     Student         Faculty        Faculty
        │              │              │
        ↓              ↓              ↓
     In-App           In-App         In-App
     Email            Email          Email
     WhatsApp         WhatsApp       WhatsApp
```

The exact recipients depend on the event.

---

# 54. Timetable Access Authorization

### Student

```text
Student
   ↓
Request Timetable
   ↓
Get Own Class
   ↓
Return Class Timetable
```

### Faculty

```text
Faculty
   ↓
Request Timetable
   ↓
Get Own Faculty ID
   ↓
Return Teaching Timetable
```

### Admin

```text
Admin
   ↓
Request Timetable
   ↓
Permission Check
   ↓
Return Required Timetable
```

---

# 55. Timetable Security Rules

The Timetable Module must follow these rules:

```text
1. Authenticate user.
2. Validate role.
3. Validate requested resource.
4. Validate academic period.
5. Validate class.
6. Validate faculty.
7. Validate subject.
8. Validate room.
9. Check timetable conflicts.
10. Use PreparedStatement.
11. Do not expose database credentials.
12. Do not trust client-side authorization.
```

---

# 56. Timetable Database Relationships

Conceptually:

```text
Academic Year
      │
      ↓
Semester
      │
      ↓
Department
      │
      ↓
Class
      │
      ├──────────────→ Subject
      │
      └──────────────→ Timetable
                            │
             ┌──────────────┼──────────────┐
             ↓              ↓              ↓
          Faculty          Room           Period
             │
             ↓
       Temporary Change
             │
             ↓
       Period Request
```

Exact foreign keys and normalization will be designed in the Database Design document.

---

# 57. Conceptual Regular Timetable Record

A regular timetable entry may contain:

```text
Timetable ID
Academic Year ID
Semester ID
Class ID
Subject ID
Faculty ID
Room ID
Day
Period ID
Start Time
End Time
Status
Created At
Updated At
```

---

# 58. Conceptual Period Request Record

A period request may contain:

```text
Request ID
Request Type
Requester Faculty ID
Receiver Faculty ID
Original Timetable ID
Class ID
Original Subject ID
Requested Subject ID
Date
Period ID
Optional Request Note
Optional Reply Note
Status
Created At
Responded At
```

For a substitute request:

```text
Requested Subject = Original Subject
```

For a borrowed request:

```text
Requested Subject = Borrowing Faculty's Subject
```

---

# 59. Timetable Request and Repository Flow

```text
Faculty Calendar
       ↓
PeriodRequestServlet
       ↓
PeriodRequestService
       ↓
PeriodRequestRepository
       ↓
MySQL
       ↓
Request Created
       ↓
NotificationService
       ↓
Receiving Faculty
       ↓
Accept / Reject
       ↓
PeriodRequestService
       ↓
TemporaryTimetableRepository
       ↓
MySQL
       ↓
Temporary Change Active
```

---

# 60. Error Handling

Possible timetable exceptions include:

```text
TimetableConflictException
FacultyUnavailableException
RoomUnavailableException
ClassScheduleConflictException
InvalidPeriodException
InvalidSubjectException
InvalidFacultyException
PeriodRequestException
UnauthorizedTimetableAccessException
DatabaseException
```

Flow:

```text
Timetable Operation
       ↓
Service
       ↓
Exception
       ↓
Servlet
       ↓
Error Handler
       ↓
JSP
       ↓
User
```

Example:

```text
Admin attempts to assign Faculty A
to two classes at the same time.
       ↓
Faculty Conflict Detected
       ↓
TimetableConflictException
       ↓
Controller
       ↓
Display:
"Faculty is already assigned during
this period."
```

---

# 61. Complete Timetable Lifecycle

```text
                         MASTER TIMETABLE
                                │
                                ↓
                           Admin Creates
                                │
                                ↓
                         Conflict Validation
                                │
                                ↓
                              Saved
                                │
             ┌──────────────────┼──────────────────┐
             ↓                  ↓                  ↓
          Student            Faculty             Admin
             │                  │                  │
             ↓                  ↓                  ↓
        Class View         Teaching View        Manage
             │                  │
             └──────────────────┼──────────────────┘
                                ↓
                       Faculty Period Request
                                │
                    ┌───────────┴───────────┐
                    ↓                       ↓
                Substitute               Borrow
                    │                       │
                    ↓                       ↓
               Other Faculty           Other Faculty
                    │                       │
                ┌───┴───┐               ┌───┴───┐
                ↓       ↓               ↓       ↓
             ACCEPT   REJECT          ACCEPT   REJECT
                │       │               │       │
                ↓       ↓               ↓       ↓
          Temporary    Closed      Temporary   Closed
           Change                  Change
                │                       │
                └───────────┬───────────┘
                            ↓
                    Student + Faculty
                      Timetable Update
                            │
                            ↓
                       Notification
                            │
                            ↓
                         Expiration
                            │
                            ↓
                      Master Timetable
                         Restored
```

---

# 62. Timetable Design Rules

The following rules will be maintained during implementation:

1. The Admin controls the master timetable.
2. Students view the timetable associated with their class.
3. Faculty members view their teaching timetable.
4. The same master schedule should provide consistent student and faculty views.
5. Class conflicts must be prevented.
6. Faculty conflicts must be prevented.
7. Room conflicts must be prevented.
8. Subject/class/faculty relationships must be validated.
9. Temporary changes must not permanently overwrite the master timetable.
10. Substitute periods keep the original subject.
11. Substitute periods temporarily change the faculty.
12. Borrowed periods use the borrowing faculty's subject.
13. Borrowed periods temporarily change the faculty and subject.
14. Faculty requests require appropriate authorization.
15. Receiving faculty can accept or reject requests.
16. Reply notes are optional.
17. Approved changes must appear in student and faculty timetables.
18. Temporary changes must expire according to their effective date/period.
19. Relevant users should receive timetable notifications.
20. Exam timetables remain logically separate from the regular timetable.
21. JSP must not directly access MySQL.
22. Servlets must not contain complex business logic.
23. Services must contain timetable business rules.
24. Repositories must handle timetable data access.
25. JDBC must handle database communication.
26. Server-side authorization must always be enforced.

---

# 63. Final Timetable Module Flow

```text
                         TIMETABLE MODULE
                                │
                                ↓
                         MASTER TIMETABLE
                                │
                                ↓
                              ADMIN
                                │
             ┌──────────────────┼──────────────────┐
             ↓                  ↓                  ↓
           Class             Subject            Faculty
             │                  │                  │
             └──────────────────┼──────────────────┘
                                ↓
                               Room
                                │
                                ↓
                      Conflict Validation
                                │
                       ┌────────┴────────┐
                       ↓                 ↓
                    CONFLICT            VALID
                       │                 │
                       ↓                 ↓
                     Error              Save
                                         │
                                         ↓
                                  Master Schedule
                                         │
                       ┌─────────────────┼─────────────────┐
                       ↓                 ↓                 ↓
                    STUDENT           FACULTY            ADMIN
                       │                 │                 │
                       ↓                 ↓                 ↓
                 Class Timetable   Teaching Timetable   Management
                       │                 │
                       └─────────────────┼─────────────────┘
                                         ↓
                               Period Management
                                         │
                         ┌───────────────┴───────────────┐
                         ↓                               ↓
                   SUBSTITUTE                        BORROW
                         │                               │
                         ↓                               ↓
                  Same Subject                    Own Subject
                  New Faculty                    New Faculty
                         │                               │
                         └───────────────┬───────────────┘
                                         ↓
                                  Faculty Approval
                                         │
                              ┌──────────┴──────────┐
                              ↓                     ↓
                           ACCEPT                 REJECT
                              │                     │
                              ↓                     ↓
                       Temporary Change          Closed
                              │
                 ┌────────────┴────────────┐
                 ↓                         ↓
              Student                   Faculty
              Timetable                 Timetable
                 │                         │
                 └────────────┬────────────┘
                              ↓
                         Notifications
                              │
                              ↓
                           Expiration
                              │
                              ↓
                       Master Timetable
```

This document defines the complete current **Timetable Module** and provides the foundation for the **Timetable UI, Timetable Servlet, Timetable Service, Timetable Repository, Period Request Module, Temporary Timetable Module, Calendar Integration, Notification Integration, and Database Design** phases.
