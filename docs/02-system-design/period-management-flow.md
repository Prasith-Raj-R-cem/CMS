# Period Management Flow

## 1. Overview

The Period Management Module handles temporary changes to the regular faculty and student timetable.

It allows faculty members to:

- Request another faculty member to take their period as a substitute.
- Borrow another faculty member's period to teach their own subject.
- Receive period requests.
- Accept or reject requests.
- Add an optional reply note.
- View sent and received requests.
- Track request status.
- View approved changes in the faculty calendar.
- Automatically reflect approved changes in the student timetable.
- Receive notifications through in-app, email, and WhatsApp channels where configured.

The module is closely connected with:

```text
Faculty
   ↓
Faculty Calendar
   ↓
Timetable
   ↓
Period Management
   ↓
Temporary Timetable
   ↓
Student Timetable
   ↓
Notifications
```

---

# 2. Important Period Management Rules

The system supports two different operations.

### Substitute Period

Another faculty member teaches the **same subject** during the requested period.

```text
Original:

Data Structures
Faculty A

Temporary:

Data Structures
Faculty B
[Substitute]
```

### Borrowed Period

Another faculty member uses a period to teach **their own subject**.

```text
Original:

Data Structures
Faculty A

Temporary:

OOP
Faculty B
[Borrowed]
```

Therefore:

```text
SUBSTITUTE
Subject = Original Subject
Faculty = Substitute Faculty


BORROW
Subject = Borrowing Faculty's Subject
Faculty = Borrowing Faculty
```

---

# 3. Architecture

The Period Management Module follows the project's layered architecture.

```text
Faculty
   ↓
Browser
   ↓
JSP / HTML / CSS / JavaScript
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
JDBC
   ↓
MySQL
```

After a request is accepted:

```text
PeriodRequestService
        ↓
TemporaryTimetableService
        ↓
TemporaryTimetableRepository
        ↓
JDBC
        ↓
MySQL
```

Notification flow:

```text
PeriodRequestService
        ↓
NotificationService
        ↓
┌──────────────┬──────────────┬──────────────┐
↓              ↓              ↓
In-App        Email        WhatsApp
```

---

# 4. Actors

```text
                    PERIOD MANAGEMENT
                           │
             ┌─────────────┼─────────────┐
             ↓             ↓             ↓
         Requester      Receiver        Admin
             │             │             │
             ↓             ↓             ↓
        Creates       Accept / Reject   Monitor
        Request       + Reply Note      Requests
```

### Requester

The faculty member who creates the request.

### Receiver

The faculty member who receives the request and decides whether to accept or reject it.

### Admin

Admin can monitor period requests and temporary timetable changes according to system permissions.

---

# 5. Period Management Navigation

Faculty navigation:

```text
Faculty Dashboard
│
├── Calendar
│
├── Timetable
│
└── Period Management
    │
    ├── Request Substitute
    ├── Borrow Period
    ├── Sent Requests
    ├── Received Requests
    └── Request History
```

---

# 6. Complete Period Management Flow

```text
                           FACULTY
                              │
                              ↓
                       Faculty Calendar
                              │
                              ↓
                       Select Period
                              │
                    ┌─────────┴─────────┐
                    ↓                   ↓
              Substitute              Borrow
               Request                Period
                    │                   │
                    ↓                   ↓
             Select Faculty       Select Faculty
                    │                   │
                    ↓                   ↓
             Optional Note       Select Own Subject
                    │                   │
                    └─────────┬─────────┘
                              ↓
                    PeriodRequestServlet
                              │
                              ↓
                    PeriodRequestService
                              │
                              ↓
                      Validate Request
                              │
                        ┌─────┴─────┐
                        ↓           ↓
                     INVALID       VALID
                        │           │
                        ↓           ↓
                     Error      Repository
                                    │
                                    ↓
                                   JDBC
                                    │
                                    ↓
                                  MySQL
                                    │
                                    ↓
                          NotificationService
                                    │
                                    ↓
                           Receiving Faculty
                                    │
                           ┌────────┴────────┐
                           ↓                 ↓
                        ACCEPT             REJECT
                           │                 │
                           ↓                 ↓
                    Reply Note          Reply Note
                           │                 │
                           ↓                 ↓
                  Temporary Change       Closed
                           │
                           ↓
                 Student + Faculty Timetable
                           │
                           ↓
                      Notifications
```

---

# 7. Starting a Period Request

The request begins from the faculty calendar or timetable.

```text
Faculty
   ↓
Calendar
   ↓
Select Period
   ↓
View Period Details
   ↓
Choose Action
```

Available actions:

```text
Request Substitute
Borrow Period
```

The system should only show actions allowed for the selected period and the faculty member's permissions.

---

# 8. Request Substitute Flow

A substitute request is used when the original faculty member cannot take a period and wants another faculty member to teach the same subject.

```text
Faculty A
   ↓
Select Own Period
   ↓
Request Substitute
   ↓
Select Faculty B
   ↓
Optional Request Note
   ↓
Submit
```

Example:

```text
Date:
25-09-2026

Period:
10:00 - 11:00

Class:
S2 CSE

Subject:
Data Structures

Original Faculty:
Faculty A

Requested Substitute:
Faculty B
```

---

# 9. Substitute Request Validation

```text
Substitute Request
        ↓
Check Session
        ↓
Check Requester Role
        ↓
Check Original Period
        ↓
Check Requester Owns Period
        ↓
Check Receiving Faculty
        ↓
Check Faculty Availability
        ↓
Check Date
        ↓
Check Period
        ↓
Check Existing Requests
        ↓
Valid?
   ┌────┴────┐
   ↓         ↓
  NO        YES
   │          │
   ↓          ↓
Error      Create Request
```

---

# 10. Substitute Request Rules

The following rules apply:

```text
1. Requester must be a faculty member.
2. Requester must own the original period.
3. Receiving faculty must be valid.
4. Receiving faculty must be available.
5. Original class must remain the same.
6. Original subject must remain the same.
7. Requested date and period must be valid.
8. Duplicate conflicting requests should be prevented.
9. Request must be stored with PENDING status.
```

---

# 11. Borrow Period Flow

A borrow request is used when a faculty member wants to use another faculty member's period to teach their own subject.

```text
Faculty B
   ↓
Faculty Calendar
   ↓
Select Available / Borrowable Period
   ↓
Borrow Period
   ↓
Select Own Subject
   ↓
Select Valid Class
   ↓
Optional Request Note
   ↓
Submit
```

Example:

```text
Original Period:

10:00 - 11:00
S2 CSE
Data Structures
Faculty A


Borrow Request:

Requester:
Faculty B

Subject:
OOP

Class:
S2 CSE
```

---

# 12. Borrow Request Validation

```text
Borrow Request
       ↓
Check Session
       ↓
Check Requester Role
       ↓
Check Target Period
       ↓
Check Requester's Subject
       ↓
Check Requester Availability
       ↓
Check Class
       ↓
Check Period
       ↓
Check Existing Requests
       ↓
Valid?
  ┌────┴────┐
  ↓         ↓
 NO        YES
  │          │
  ↓          ↓
Error     Create Request
```

---

# 13. Borrow Request Rules

The following rules apply:

```text
1. Requester must be a faculty member.
2. Requester must be authorized to teach the selected subject.
3. Requester must be available during the requested period.
4. The selected class must be valid.
5. The requested period must be valid.
6. The target faculty must exist.
7. Conflicting requests must be prevented.
8. Request must be stored with PENDING status.
```

---

# 14. Request Form

A period request form may contain:

```text
Request Type
Date
Period
Class
Original Subject
Requested Subject
Original Faculty
Receiving Faculty
Request Note
```

Fields depend on request type.

### Substitute

```text
Request Type: SUBSTITUTE
Date
Period
Class
Subject
Original Faculty
Substitute Faculty
Optional Note
```

### Borrow

```text
Request Type: BORROW
Date
Period
Class
Original Faculty
Borrowing Faculty
Borrowing Subject
Optional Note
```

---

# 15. Request Creation Architecture

```text
Faculty
   ↓
period-request.jsp
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
Validation
   ↓
PeriodRequestRepository
   ↓
JDBC
   ↓
MySQL
```

After successful creation:

```text
Request Created
   ↓
Status = PENDING
   ↓
NotificationService
   ↓
Receiving Faculty
```

---

# 16. Request Status

The system should support:

```text
PENDING
ACCEPTED
REJECTED
CANCELLED
EXPIRED
```

Flow:

```text
CREATE
  ↓
PENDING
  │
  ├───────────────┐
  ↓               ↓
ACCEPTED        REJECTED
  │               │
  ↓               ↓
Temporary       Closed
Change
```

---

# 17. Request Notification

When a request is created:

```text
Request Created
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

The notification may contain:

```text
Faculty Name
Request Type
Class
Subject
Date
Period
Request Note
```

---

# 18. Receiving Faculty Request Page

The receiving faculty can see incoming requests.

```text
Faculty
   ↓
Received Requests
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
Pending Requests
   ↓
Faculty
```

Example:

```text
---------------------------------------------
Period Request

From: Faculty A
Type: Substitute
Class: S2 CSE
Subject: Data Structures
Date: 25-09-2026
Period: 3

Note:
"Could you please take my period?"

[ACCEPT] [REJECT]
---------------------------------------------
```

---

# 19. Accept Request Flow

```text
Receiving Faculty
       ↓
Open Request
       ↓
Accept
       ↓
Optional Reply Note
       ↓
PeriodRequestServlet
       ↓
PeriodRequestService
       ↓
Revalidate Availability
       ↓
Update Request Status
       ↓
Create Temporary Timetable
       ↓
NotificationService
       ↓
Requester
       ↓
Student Timetable
```

---

# 20. Reject Request Flow

```text
Receiving Faculty
       ↓
Open Request
       ↓
Reject
       ↓
Optional Reply Note
       ↓
PeriodRequestServlet
       ↓
PeriodRequestService
       ↓
Update Status = REJECTED
       ↓
NotificationService
       ↓
Requester
```

No temporary timetable change should be created for a rejected request.

---

# 21. Accept Request Revalidation

Availability must be checked again when the receiving faculty accepts the request.

This prevents a stale request from creating a conflict.

```text
PENDING REQUEST
       ↓
Faculty Clicks ACCEPT
       ↓
Check Current Faculty Timetable
       ↓
Check Class
       ↓
Check Room
       ↓
Check Other Temporary Changes
       ↓
Still Valid?
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
ACCEPT     Reject /
           Conflict
           Message
```

---

# 22. Optional Reply Note

The receiving faculty can optionally add a note.

```text
Accept / Reject
       ↓
Reply Note (Optional)
       ↓
Submit
       ↓
Save:
- Status
- Reply Note
- Response Time
```

Example:

```text
ACCEPTED

"Sure, I can take the period."
```

or:

```text
REJECTED

"I have another class during this period."
```

The note is optional.

---

# 23. Temporary Timetable Creation

A temporary timetable entry is created only after a request is successfully accepted.

```text
Request Status = ACCEPTED
        ↓
TemporaryTimetableService
        ↓
Create Temporary Record
        ↓
TemporaryTimetableRepository
        ↓
JDBC
        ↓
MySQL
```

---

# 24. Substitute Temporary Change

```text
MASTER:

10:00 - 11:00
S2 CSE
Data Structures
Faculty A


TEMPORARY:

10:00 - 11:00
S2 CSE
Data Structures
Faculty B
SUBSTITUTE
```

The original subject remains unchanged.

---

# 25. Borrow Temporary Change

```text
MASTER:

10:00 - 11:00
S2 CSE
Data Structures
Faculty A


TEMPORARY:

10:00 - 11:00
S2 CSE
OOP
Faculty B
BORROWED
```

The subject changes to the borrowing faculty's subject.

---

# 26. Master Timetable Protection

Temporary changes must never directly overwrite the master timetable.

Correct architecture:

```text
Master Timetable
       │
       ├───────────────┐
       │               │
       ↓               ↓
Regular Schedule   Temporary Change
                       │
                       ↓
                Effective Timetable
```

Incorrect architecture:

```text
Master Timetable
       ↓
Overwrite Original Period
```

The second approach should not be used because it destroys the original schedule.

---

# 27. Effective Timetable Calculation

When a student or faculty requests a timetable:

```text
Timetable Request
       ↓
Load Master Timetable
       ↓
Load Active Temporary Changes
       ↓
Find Matching Date + Period
       ↓
Temporary Change Exists?
       │
   ┌───┴───┐
   ↓       ↓
  YES      NO
   │        │
   ↓        ↓
Apply     Keep Master
Change    Entry
   │        │
   └────┬───┘
        ↓
Effective Timetable
```

---

# 28. Student Timetable Update

After an accepted request:

```text
Request Accepted
       ↓
Temporary Change Created
       ↓
Student Opens Timetable
       ↓
TimetableService
       ↓
Master Timetable
       ↓
Temporary Change
       ↓
Effective Timetable
       ↓
Student
```

Example:

```text
Original:

10:00 - 11:00
Data Structures
Faculty A


Student sees:

10:00 - 11:00
OOP
Faculty B
[Borrowed]
```

---

# 29. Faculty Timetable Update

The faculty view also changes.

### Substitute

```text
Faculty A:

10:00 - 11:00
Period given for substitute
```

```text
Faculty B:

10:00 - 11:00
Data Structures
S2 CSE
[Substitute]
```

### Borrow

```text
Faculty A:

10:00 - 11:00
Period borrowed by Faculty B
```

```text
Faculty B:

10:00 - 11:00
OOP
S2 CSE
[Borrowed]
```

The exact visual representation will be finalized during UI design.

---

# 30. Request History

Faculty members can view their request history.

```text
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
Display History
```

History can include:

```text
Sent Requests
Received Requests
Accepted Requests
Rejected Requests
Cancelled Requests
Expired Requests
```

---

# 31. Sent Request Flow

```text
Faculty
   ↓
Sent Requests
   ↓
RequestRepository
   ↓
MySQL
   ↓
Find Requests Where Requester = Faculty
   ↓
Display
```

Example:

```text
Request #102
Type: SUBSTITUTE
To: Faculty B
Date: 25-09-2026
Period: 3
Status: ACCEPTED
```

---

# 32. Received Request Flow

```text
Faculty
   ↓
Received Requests
   ↓
RequestRepository
   ↓
MySQL
   ↓
Find Requests Where Receiver = Faculty
   ↓
Display
```

---

# 33. Request Cancellation

The requester may be allowed to cancel a request while it is still pending.

```text
Requester
   ↓
Sent Request
   ↓
Cancel
   ↓
PeriodRequestService
   ↓
Check Status
   ↓
Is PENDING?
   ┌────┴────┐
   ↓         ↓
  YES        NO
   │          │
   ↓          ↓
CANCEL      Reject
Request     Cancellation
```

A request that has already created a temporary timetable change should not be cancelled through the normal pending-request mechanism.

Any reversal of an accepted change should follow a separate cancellation/change workflow.

---

# 34. Request Expiration

A request can become expired when its requested period has already passed.

```text
PENDING Request
      ↓
Requested Date/Time
      ↓
Period Passed?
   ┌──┴──┐
   ↓     ↓
 YES    NO
  │      │
  ↓      ↓
EXPIRED Continue
```

Expired requests should not be accepted normally.

---

# 35. Admin Monitoring

Admin can monitor period requests.

```text
Admin
   ↓
Period Request Management
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
Request List
```

Admin can view:

```text
Request ID
Type
Requester
Receiver
Class
Subject
Date
Period
Status
Request Note
Reply Note
Created Time
Response Time
```

---

# 36. Admin Does Not Automatically Approve

The normal flow is:

```text
Faculty A
   ↓
Request
   ↓
Faculty B
   ↓
Accept / Reject
```

Admin monitoring is separate:

```text
Request
   ↓
Stored
   ↓
Admin Can Monitor
```

Administrative approval can be added later if the institution requires it.

---

# 37. Conflict Management

The system must prevent conflicting temporary changes.

Possible conflicts:

```text
Faculty Conflict
Class Conflict
Room Conflict
Duplicate Period Request
Duplicate Temporary Change
Invalid Subject
Invalid Class
Invalid Date
```

---

# 38. Conflict Validation Flow

```text
Request
   ↓
Check Existing Master Timetable
   ↓
Check Existing Temporary Changes
   ↓
Check Faculty
   ↓
Check Class
   ↓
Check Room
   ↓
Check Date + Period
   ↓
Conflict?
  ┌────┴────┐
  ↓         ↓
 YES        NO
  │          │
  ↓          ↓
Reject     Continue
```

---

# 39. Faculty Availability Check

For a substitute request:

```text
Requester:
Faculty A

Receiver:
Faculty B

Requested:
Monday, Period 3

Check:
Faculty B
Monday, Period 3

Available?
```

For a borrow request:

```text
Requester:
Faculty B

Requested:
Monday, Period 3

Check:
Faculty B
Monday, Period 3

Available?
```

---

# 40. Class Availability Check

The system must ensure that the resulting student timetable is valid.

```text
Temporary Change
       ↓
Class
       ↓
Date
       ↓
Period
       ↓
Check Existing Schedule
       ↓
Conflict?
```

If the requested change would create an impossible class schedule, the request should not be accepted.

---

# 41. Room Availability Check

If room allocation is affected:

```text
Temporary Change
       ↓
Room
       ↓
Date
       ↓
Period
       ↓
Check Room Schedule
       ↓
Conflict?
```

The room validation rules will depend on how the master timetable and room assignments are designed.

---

# 42. Period Request Notification Lifecycle

```text
                    REQUEST CREATED
                           │
                           ↓
                    NotificationService
                           │
              ┌────────────┼────────────┐
              ↓            ↓            ↓
           In-App         Email       WhatsApp
              │            │            │
              └────────────┼────────────┘
                           ↓
                    Receiving Faculty
                           │
                    ┌──────┴──────┐
                    ↓             ↓
                 ACCEPT         REJECT
                    │             │
                    ↓             ↓
             Update Request    Update Request
                    │             │
                    └──────┬──────┘
                           ↓
                    NotificationService
                           │
                           ↓
                     Requester Faculty
```

---

# 43. Student Notification

When an approved period changes the student timetable:

```text
Request Accepted
       ↓
Temporary Timetable Created
       ↓
NotificationService
       ↓
Relevant Students
```

Notification example:

```text
Timetable Update

Tomorrow, Period 3:

OOP
Faculty B

This is a temporary timetable change.
```

The final message format will be designed later.

---

# 44. Faculty Notification

When a faculty member's request receives a response:

```text
Request Response
       ↓
NotificationService
       ↓
Requesting Faculty
```

Example:

```text
Your substitute request has been accepted.

Date:
25-09-2026

Period:
3

Faculty:
Faculty B
```

---

# 45. Calendar Integration

The Faculty Calendar should display period management information.

```text
Faculty Calendar
       │
       ├── Regular Period
       ├── Pending Request
       ├── Accepted Substitute
       ├── Accepted Borrow
       └── Temporary Change
```

Selecting a calendar event can show:

```text
Date
Period
Class
Subject
Faculty
Request Type
Request Status
```

---

# 46. Calendar Request Flow

```text
Faculty
   ↓
Calendar
   ↓
Select Period
   ↓
View Details
   ↓
Request Action
   ↓
Period Management
```

This makes the calendar the primary interface for period-level operations.

---

# 47. Period Request Database

A conceptual period request record may contain:

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
Request Note
Reply Note
Status
Created At
Responded At
```

For substitute:

```text
Request Type = SUBSTITUTE
Requested Subject = Original Subject
```

For borrow:

```text
Request Type = BORROW
Requested Subject = Borrowing Faculty Subject
```

---

# 48. Temporary Timetable Database

A conceptual temporary timetable record may contain:

```text
Temporary Change ID
Request ID
Original Timetable ID
Change Type
Class ID
Date
Period ID
Original Faculty ID
Original Subject ID
Temporary Faculty ID
Temporary Subject ID
Room ID
Status
Created At
Expires At
```

Exact normalization and foreign keys will be finalized during database design.

---

# 49. Repository Structure

The module can use dedicated repositories:

```text
repository/
│
├── PeriodRequestRepository.java
├── TemporaryTimetableRepository.java
└── TimetableRepository.java
```

Possible responsibilities:

```text
TimetableRepository
    → Master timetable data

PeriodRequestRepository
    → Request data

TemporaryTimetableRepository
    → Approved temporary changes
```

This separation keeps responsibilities clear.

---

# 50. Service Structure

Possible service classes:

```text
service/
│
├── PeriodRequestService.java
├── TemporaryTimetableService.java
└── TimetableService.java
```

Responsibilities:

```text
PeriodRequestService
    → Request creation
    → Validation
    → Accept / Reject
    → Cancellation
    → Status management

TemporaryTimetableService
    → Create temporary change
    → Find active changes
    → Expiration logic

TimetableService
    → Master timetable
    → Effective timetable calculation
    → Conflict checks
```

---

# 51. Servlet Structure

Possible servlet classes:

```text
servlet/
│
├── PeriodRequestServlet.java
├── TemporaryTimetableServlet.java
└── TimetableServlet.java
```

The Servlet should:

```text
Receive HTTP Request
       ↓
Read Parameters
       ↓
Create Request DTO / Data
       ↓
Call Service
       ↓
Handle Result
       ↓
Forward / Redirect
```

The Servlet should not contain SQL queries.

---

# 52. DTO / Model Structure

Possible model classes:

```text
model/
│
├── PeriodRequest.java
├── TemporaryTimetable.java
├── Timetable.java
└── Period.java
```

DTOs can be introduced when required to transfer data between layers cleanly.

---

# 53. Request Architecture

### Create Request

```text
Faculty
   ↓
JSP
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
JDBC
   ↓
MySQL
```

### Accept Request

```text
Faculty
   ↓
JSP
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
TemporaryTimetableRepository
   ↓
JDBC
   ↓
MySQL
```

### View Effective Timetable

```text
Student / Faculty
   ↓
JSP
   ↓
TimetableServlet
   ↓
TimetableService
   ↓
TimetableRepository
   ↓
TemporaryTimetableRepository
   ↓
JDBC
   ↓
MySQL
```

---

# 54. Error Handling

Possible exceptions:

```text
PeriodRequestNotFoundException
InvalidPeriodRequestException
FacultyUnavailableException
ClassConflictException
RoomConflictException
TimetableConflictException
UnauthorizedPeriodRequestException
RequestAlreadyProcessedException
RequestExpiredException
DatabaseException
```

Flow:

```text
Operation
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

---

# 55. Example: Substitute Request Error

```text
Faculty A
   ↓
Request Substitute
   ↓
Select Faculty B
   ↓
Faculty B already has a class
   ↓
Availability Check
   ↓
Conflict
   ↓
Request Rejected
```

Message:

```text
Faculty B is not available during this period.
```

---

# 56. Example: Borrow Request Error

```text
Faculty B
   ↓
Borrow Period
   ↓
Select OOP
   ↓
Faculty B already teaches another class
   ↓
Availability Check
   ↓
Conflict
   ↓
Request Cannot Be Created
```

---

# 57. Example: Expired Request

```text
Request:
25-09-2026
Period 3

Current Date:
26-09-2026

Request Status:
PENDING

System
   ↓
Requested Period Passed
   ↓
Status = EXPIRED
```

The receiving faculty should no longer be able to accept the request.

---

# 58. Complete Substitute Lifecycle

```text
                         FACULTY A
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
                    Submit Request
                             │
                             ↓
                  PeriodRequestService
                             │
                             ↓
                       Validation
                             │
                             ↓
                         PENDING
                             │
                             ↓
                     Notification
                             │
                             ↓
                         FACULTY B
                             │
                    ┌────────┴────────┐
                    ↓                 ↓
                 ACCEPT             REJECT
                    │                 │
                    ↓                 ↓
             Optional Note      Optional Note
                    │                 │
                    ↓                 ↓
             ACCEPTED            REJECTED
                    │
                    ↓
         Temporary Timetable
              Created
                    │
             ┌──────┴──────┐
             ↓             ↓
          Student        Faculty
          Timetable      Timetable
             │             │
             └──────┬──────┘
                    ↓
                Notification
                    │
                    ↓
                 Expiration
```

---

# 59. Complete Borrow Lifecycle

```text
                         FACULTY B
                             │
                             ↓
                     Select Target Period
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
                       Submit Request
                             │
                             ↓
                  PeriodRequestService
                             │
                             ↓
                       Validation
                             │
                             ↓
                          PENDING
                             │
                             ↓
                      Notification
                             │
                             ↓
                         FACULTY A
                             │
                    ┌────────┴────────┐
                    ↓                 ↓
                 ACCEPT             REJECT
                    │                 │
                    ↓                 ↓
             Optional Note      Optional Note
                    │                 │
                    ↓                 ↓
             ACCEPTED            REJECTED
                    │
                    ↓
         Temporary Timetable
              Created
                    │
             ┌──────┴──────┐
             ↓             ↓
          Student        Faculty
          Timetable      Timetable
             │             │
             └──────┬──────┘
                    ↓
                Notification
                    │
                    ↓
                 Expiration
```

---

# 60. Complete Period Management Flow

```text
                              PERIOD MANAGEMENT
                                      │
                                      ↓
                               Faculty Calendar
                                      │
                                      ↓
                                Select Period
                                      │
                        ┌─────────────┴─────────────┐
                        ↓                           ↓
                 SUBSTITUTE                    BORROW
                  REQUEST                       PERIOD
                        │                           │
                        ↓                           ↓
                Select Faculty              Select Subject
                        │                           │
                        ↓                           ↓
                  Optional Note              Select Class
                        │                           │
                        └─────────────┬─────────────┘
                                      ↓
                            PeriodRequestServlet
                                      │
                                      ↓
                            PeriodRequestService
                                      │
                                      ↓
                              Validate Request
                                      │
                           ┌──────────┴──────────┐
                           ↓                     ↓
                        INVALID                 VALID
                           │                     │
                           ↓                     ↓
                         Error                PENDING
                                                 │
                                                 ↓
                                          Notification
                                                 │
                                                 ↓
                                        Receiving Faculty
                                                 │
                                      ┌──────────┴──────────┐
                                      ↓                     ↓
                                   ACCEPT                 REJECT
                                      │                     │
                                      ↓                     ↓
                                Reply Note              Reply Note
                                      │                     │
                                      ↓                     ↓
                             Temporary Change          Closed
                                      │
                                      ↓
                            Student Timetable
                                      │
                                      ↓
                             Faculty Timetable
                                      │
                                      ↓
                                Notification
                                      │
                                      ↓
                                  Expiration
```

---

# 61. Design Rules

The following rules will be maintained during implementation:

1. Period management is a faculty-focused feature.
2. Requests must originate from authorized faculty users.
3. Substitute requests keep the original subject.
4. Substitute requests temporarily change the faculty.
5. Borrow requests use the borrowing faculty's subject.
6. Borrow requests temporarily change the subject and faculty shown for the period.
7. Requester and receiver must be valid faculty accounts.
8. Faculty availability must be checked.
9. Class conflicts must be checked.
10. Room conflicts must be checked when applicable.
11. Existing temporary changes must be checked.
12. Requests begin with `PENDING` status.
13. Only the receiving faculty can normally accept or reject the request.
14. Reply notes are optional.
15. Accepted requests create temporary timetable records.
16. Rejected requests must not create temporary timetable records.
17. Temporary changes must not overwrite the master timetable.
18. Temporary changes apply only to their specified date and period.
19. Expired requests cannot normally be accepted.
20. Relevant users should receive notifications.
21. Student timetables must reflect approved temporary changes.
22. Faculty timetables must reflect approved temporary changes.
23. Request history should be preserved.
24. JSP must not directly access the database.
25. Servlets must not contain business logic or SQL.
26. Services must contain business rules.
27. Repositories must handle database operations.
28. JDBC must handle database communication.
29. Server-side authorization must always be enforced.
30. The exact database relationships will be finalized in the Database Design phase.

---

# 62. Final Period Management Flow

```text
                         PERIOD MANAGEMENT
                                │
                                ↓
                         FACULTY CALENDAR
                                │
                                ↓
                           SELECT PERIOD
                                │
                    ┌───────────┴───────────┐
                    ↓                       ↓
               SUBSTITUTE                 BORROW
                    │                       │
                    ↓                       ↓
             Same Subject              Own Subject
             New Faculty              New Faculty
                    │                       │
                    └───────────┬───────────┘
                                ↓
                      CREATE REQUEST
                                │
                                ↓
                     SERVER VALIDATION
                                │
                         ┌──────┴──────┐
                         ↓             ↓
                      INVALID         VALID
                         │             │
                         ↓             ↓
                       ERROR         PENDING
                                       │
                                       ↓
                                NOTIFICATION
                                       │
                                       ↓
                              RECEIVING FACULTY
                                       │
                              ┌────────┴────────┐
                              ↓                 ↓
                           ACCEPT             REJECT
                              │                 │
                              ↓                 ↓
                        Reply Note          Reply Note
                              │                 │
                              ↓                 ↓
                       ACCEPTED             REJECTED
                              │                 │
                              ↓                 ↓
                  Temporary Timetable        CLOSED
                        Change
                              │
                 ┌────────────┴────────────┐
                 ↓                         ↓
              STUDENT                   FACULTY
              TIMETABLE                 TIMETABLE
                 │                         │
                 └────────────┬────────────┘
                              ↓
                         NOTIFICATION
                              │
                              ↓
                          EXPIRATION
                              │
                              ↓
                     MASTER TIMETABLE
                          RESTORED
```

This document defines the complete current **Period Management Module** and provides the foundation for the **Period Request UI, Servlet, Service, Repository, Temporary Timetable integration, Faculty Calendar integration, Student Timetable integration, Notification integration, and Database Design** phases.
