# Notification Flow

## 1. Overview

The Notification Module is responsible for delivering important Campus Management System events to students, faculty, and administrators through multiple communication channels.

The system supports three primary notification channels:

```text
NOTIFICATION
│
├── In-App Notification
├── Email Notification
└── WhatsApp Notification
```

The Notification Module is designed as an independent service so that Assignment, Timetable, Period Management, Examination, and Announcement modules do not need to implement channel-specific delivery logic themselves.

Core responsibilities:

- Create notification events
- Identify recipients
- Select notification channels
- Generate notification content
- Send in-app notifications
- Send email notifications
- Send WhatsApp notifications
- Track delivery status
- Track read status for in-app notifications
- Handle failed delivery
- Retry failed notifications where appropriate
- Store notification history
- Manage notification preferences
- Prevent duplicate notifications
- Protect user data
- Provide a common interface for external notification providers

---

# 2. Notification Architecture

The high-level architecture is:

```text
Assignment / Timetable / Period Request / Exam / Announcement
                              │
                              ↓
                     NotificationService
                              │
                    ┌─────────┼─────────┐
                    ↓         ↓         ↓
                  In-App    Email    WhatsApp
                    │         │         │
                    ↓         ↓         ↓
                 Database   Email     WhatsApp
                           Provider      API
                    │         │         │
                    └─────────┼─────────┘
                              ↓
                         Recipient
```

The source modules generate events.

The Notification Module decides how those events are delivered.

---

# 3. Notification Layered Architecture

The Notification Module follows the project's layered architecture.

```text
User
  ↓
Browser / Application
  ↓
JSP / HTML / JS
  ↓
Servlet
  ↓
Service Layer
  ↓
NotificationService
  ↓
Notification Channel Service
  │
  ├── In-App
  ├── Email
  └── WhatsApp
  ↓
Repository Layer
  ↓
JDBC
  ↓
MySQL
```

External communication:

```text
EmailNotificationService
        ↓
Email Provider / SMTP
        ↓
Email Server
        ↓
Recipient Email
```

```text
WhatsAppNotificationService
        ↓
WhatsApp Business API / Approved Provider
        ↓
WhatsApp
        ↓
Recipient Phone
```

---

# 4. Notification Actors

```text
                     NOTIFICATION SYSTEM
                             │
           ┌─────────────────┼─────────────────┐
           ↓                 ↓                 ↓
        Student           Faculty            Admin
           │                 │                 │
           └─────────────────┼─────────────────┘
                             ↓
                    NotificationService
```

The notification recipient depends on the event.

---

# 5. Notification Sources

The following modules can generate notification events:

```text
Assignment Module
        │
        ├── New Assignment
        ├── Deadline Reminder
        ├── Deadline Changed
        └── Assignment Cancelled

Timetable Module
        │
        ├── Timetable Published
        ├── Timetable Updated
        └── Temporary Timetable Change

Period Management
        │
        ├── Substitute Request
        ├── Borrow Request
        ├── Request Accepted
        ├── Request Rejected
        └── Request Cancelled

Examination Module
        │
        ├── Exam Timetable Published
        └── Exam Timetable Changed

Announcement Module
        │
        └── New Announcement
```

---

# 6. Complete Notification Flow

```text
                         SYSTEM EVENT
                              │
                              ↓
                      Create Notification
                              │
                              ↓
                     NotificationService
                              │
                              ↓
                      Identify Recipients
                              │
                              ↓
                    Check User Preferences
                              │
                              ↓
                    Select Notification Channels
                              │
               ┌──────────────┼──────────────┐
               ↓              ↓              ↓
            In-App          Email         WhatsApp
               │              │              │
               ↓              ↓              ↓
          Save Record      Send Email      Send Message
               │              │              │
               ↓              ↓              ↓
            Database       Provider        WhatsApp API
               │              │              │
               └──────────────┼──────────────┘
                              ↓
                       Delivery Status
                              │
                    ┌─────────┴─────────┐
                    ↓                   ↓
                 SUCCESS              FAILED
                    │                   │
                    ↓                   ↓
                 Update              Retry / Log
                 Status
```

---

# 7. Notification Event Concept

Source modules should not directly call an external email or WhatsApp API.

Instead:

```text
Assignment Created
       ↓
Notification Event
       ↓
NotificationService
```

Example:

```text
AssignmentCreatedEvent
{
    assignmentId
    classId
    subjectId
    facultyId
    deadline
}
```

The exact event class structure will be finalized during implementation.

---

# 8. Notification Service

The central `NotificationService` coordinates notification delivery.

Conceptually:

```text
NotificationService
│
├── createNotification()
├── notifyUser()
├── notifyUsers()
├── notifyClass()
├── notifyFaculty()
├── notifyStudents()
├── send()
└── processNotification()
```

Responsibilities:

```text
Receive Event
    ↓
Determine Recipient
    ↓
Determine Message
    ↓
Determine Channels
    ↓
Create Notification Records
    ↓
Send Through Channels
    ↓
Track Status
```

---

# 9. Channel Abstraction

Notification channels should use a common abstraction.

```text
NotificationChannel
       │
       ├── InAppNotificationChannel
       ├── EmailNotificationChannel
       └── WhatsAppNotificationChannel
```

Conceptually:

```text
send(Notification notification)
```

Each channel implements its own delivery mechanism.

This prevents the core application from depending directly on a specific provider.

---

# 10. In-App Notification Flow

In-app notifications are stored in the application's database.

```text
System Event
     ↓
NotificationService
     ↓
Create Notification
     ↓
NotificationRepository
     ↓
JDBC
     ↓
MySQL
     ↓
Student / Faculty Opens App
     ↓
NotificationServlet
     ↓
NotificationRepository
     ↓
Retrieve Notifications
     ↓
Notification Page
```

---

# 11. In-App Notification Example

```text
┌──────────────────────────────────────┐
│ 🔔 New Assignment                    │
│                                      │
│ OOP Assignment 01 has been assigned. │
│ Deadline: 25-09-2026 11:59 PM        │
│                                      │
│ 10 minutes ago                       │
└──────────────────────────────────────┘
```

---

# 12. In-App Read Status

In-app notifications can have:

```text
UNREAD
READ
```

Flow:

```text
Notification Created
       ↓
UNREAD
       ↓
User Opens Notification
       ↓
NotificationServlet
       ↓
NotificationService
       ↓
NotificationRepository
       ↓
Mark as READ
```

---

# 13. Email Notification Flow

```text
System Event
      ↓
NotificationService
      ↓
EmailNotificationService
      ↓
Create Email
      ↓
Email Provider / SMTP
      ↓
Email Server
      ↓
Recipient
```

The application should not contain provider-specific code inside the Assignment or Timetable modules.

---

# 14. Email Notification Example

Subject:

```text
New Assignment - OOP
```

Body:

```text
Hello Student,

A new assignment has been assigned to your class.

Subject:
Object Oriented Programming

Assignment:
OOP Assignment 01

Deadline:
25-09-2026 11:59 PM

Please check the Campus Management System for details.

Regards,
Campus Management System
```

The final email template will be created during the UI/notification implementation phase.

---

# 15. WhatsApp Notification Flow

WhatsApp is a first-class notification channel in this system.

```text
System Event
      ↓
NotificationService
      ↓
WhatsAppNotificationService
      ↓
Create WhatsApp Message
      ↓
Approved WhatsApp Template
      ↓
WhatsApp Business API / Provider
      ↓
WhatsApp
      ↓
Recipient
```

The system should use an official WhatsApp Business-compatible API/provider rather than automating a personal WhatsApp account.

---

# 16. WhatsApp Notification Example

Example message:

```text
Campus Management System

New Assignment

Subject: OOP
Assignment: OOP Assignment 01
Class: S2 CSE

Deadline:
25-09-2026 at 11:59 PM

Open the Campus Management System
to view the assignment.
```

Actual WhatsApp message templates will depend on the selected provider and its template requirements.

---

# 17. WhatsApp API Architecture

The WhatsApp implementation should be isolated.

```text
NotificationService
        ↓
WhatsAppNotificationService
        ↓
WhatsAppProvider Interface
        ↓
WhatsApp Provider Implementation
        ↓
WhatsApp Business API
        ↓
Recipient
```

Conceptually:

```text
WhatsAppProvider
       │
       └── sendMessage()
```

This allows the provider to be replaced later without changing the main application logic.

---

# 18. WhatsApp Provider Abstraction

Possible structure:

```text
notification/
│
├── NotificationChannel.java
│
├── InAppNotificationChannel.java
│
├── EmailNotificationChannel.java
│
├── WhatsAppNotificationChannel.java
│
└── provider/
    └── WhatsAppProvider.java
```

The exact package structure will be finalized during the implementation phase.

---

# 19. WhatsApp Delivery Status

WhatsApp messages can have delivery states such as:

```text
PENDING
SENT
DELIVERED
READ
FAILED
```

The exact statuses depend on the selected API/provider.

Flow:

```text
Message Created
      ↓
PENDING
      ↓
API Request
      ↓
SENT
      ↓
Provider Status Update
      │
      ├── DELIVERED
      ├── READ
      └── FAILED
```

---

# 20. WhatsApp API Response

Conceptually:

```text
Application
    ↓
WhatsApp API
    ↓
API Response
    │
    ├── Success
    │      ↓
    │    Message ID
    │
    └── Failure
           ↓
       Error Code
```

The message ID should be stored when available so delivery status can be tracked.

---

# 21. WhatsApp Webhook / Status Update

If the selected provider supports delivery callbacks/webhooks:

```text
WhatsApp
   ↓
Provider
   ↓
Webhook
   ↓
Application Webhook Endpoint
   ↓
NotificationService
   ↓
NotificationRepository
   ↓
Update Status
```

Example:

```text
PENDING
   ↓
SENT
   ↓
DELIVERED
   ↓
READ
```

If webhooks are not available in the chosen provider configuration, the system can use the provider's supported status mechanism.

---

# 22. WhatsApp Failure Flow

```text
Notification
      ↓
WhatsApp API
      ↓
Failed?
   ┌──┴──┐
   ↓     ↓
 YES     NO
  │       │
  ↓       ↓
Log     Success
Failure
  │
  ↓
Retry Policy
```

Possible failure reasons:

```text
Invalid Number
User Not Available
Template Rejected
Provider Error
Authentication Error
Rate Limit
Network Error
```

The exact error handling depends on the provider.

---

# 23. Retry Flow

Not every failure should be retried.

```text
WhatsApp Failure
      ↓
Classify Error
      │
 ┌────┴───────────────┐
 ↓                    ↓
Temporary           Permanent
 ↓                    ↓
Retry               Do Not Retry
 ↓                    ↓
Attempt Count       Log Failure
 ↓
Success / Final Failure
```

Examples:

```text
Network Timeout
→ Possible Retry

Provider Temporary Error
→ Possible Retry

Invalid Phone Number
→ Do Not Retry Automatically
```

Retry limits must be defined to prevent notification loops.

---

# 24. Notification Preferences

Users can have notification preferences.

Example:

```text
Notification Preferences

In-App        [ON]
Email         [ON]
WhatsApp      [ON]
```

Users may also have event-level preferences if required.

Example:

```text
Assignment Notifications
    In-App     ON
    Email      ON
    WhatsApp   ON

Timetable Notifications
    In-App     ON
    Email      ON
    WhatsApp   OFF
```

The exact preference system will be finalized during requirements and database design.

---

# 25. Notification Preference Flow

```text
System Event
      ↓
Find Recipient
      ↓
Load Notification Preferences
      ↓
Determine Enabled Channels
      ↓
Send Through Enabled Channels
```

Example:

```text
Student Preferences:

In-App = ON
Email = ON
WhatsApp = OFF

Result:

In-App → SEND
Email → SEND
WhatsApp → DO NOT SEND
```

---

# 26. WhatsApp Opt-In

WhatsApp notifications should respect the user's consent and the requirements of the selected WhatsApp Business provider.

Conceptually:

```text
User
  ↓
WhatsApp Notification Preference
  ↓
Opt-In / Enable
  ↓
Store Preference
  ↓
NotificationService
  ↓
WhatsApp Allowed
```

If WhatsApp notifications are disabled:

```text
WhatsApp = OFF
      ↓
NotificationService
      ↓
Do Not Send WhatsApp
```

The system should not attempt to bypass user preferences or provider requirements.

---

# 27. Recipient Selection

The NotificationService determines who should receive each event.

Examples:

### New Assignment

```text
Assignment
   ↓
Class
   ↓
Students in Class
   ↓
Recipients
```

### Substitute Request

```text
Request
   ↓
Receiving Faculty
   ↓
Recipient
```

### Borrow Request

```text
Request
   ↓
Original Faculty
   ↓
Recipient
```

### Timetable Change

```text
Temporary Change
   ↓
Affected Class
   ↓
Students
```

---

# 28. Notification Recipient Flow

```text
Event
 ↓
Identify Target
 ↓
Find Users
 ↓
Check Active Accounts
 ↓
Check Preferences
 ↓
Create Notifications
```

Inactive accounts should not receive normal application notifications.

---

# 29. Assignment Notification Flow

## New Assignment

```text
Faculty
   ↓
Create Assignment
   ↓
AssignmentService
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Assignment Created
   ↓
NotificationService
   ↓
Students in Class
   │
   ├── In-App
   ├── Email
   └── WhatsApp
```

---

# 30. Assignment Deadline Reminder

```text
Assignment
   ↓
Deadline Approaching
   ↓
Notification Process
   ↓
Check Reminder Rule
   ↓
Find Students
   ↓
Check Preferences
   ↓
Send
```

Possible channels:

```text
In-App
Email
WhatsApp
```

The exact reminder timing will be defined later.

---

# 31. Assignment Deadline Change

```text
Faculty
   ↓
Change Deadline
   ↓
AssignmentService
   ↓
Update Database
   ↓
Update Calendar
   ↓
NotificationService
   ↓
Relevant Students
   ↓
In-App / Email / WhatsApp
```

---

# 32. Timetable Notification Flow

```text
Admin
   ↓
Publish / Update Timetable
   ↓
TimetableService
   ↓
Save
   ↓
NotificationService
   ↓
Affected Students / Faculty
   │
   ├── In-App
   ├── Email
   └── WhatsApp
```

Only affected users should be targeted where possible.

---

# 33. Temporary Timetable Change Notification

```text
Period Request
      ↓
ACCEPTED
      ↓
Temporary Timetable Created
      ↓
NotificationService
      │
      ├── Students in Class
      ├── Original Faculty
      └── New / Substitute Faculty
```

The exact recipient list depends on whether the change is a substitute or borrow operation.

---

# 34. Substitute Request Notification

```text
Faculty A
   ↓
Create Substitute Request
   ↓
PeriodRequestService
   ↓
PENDING
   ↓
NotificationService
   ↓
Faculty B
   │
   ├── In-App
   ├── Email
   └── WhatsApp
```

---

# 35. Substitute Request Response Notification

```text
Faculty B
   ↓
Accept / Reject
   ↓
PeriodRequestService
   ↓
Update Status
   ↓
NotificationService
   ↓
Faculty A
```

Example:

```text
Your substitute request has been accepted.

Date: 25-09-2026
Period: 3
Faculty: Faculty B
```

---

# 36. Borrow Request Notification

```text
Faculty B
   ↓
Create Borrow Request
   ↓
PeriodRequestService
   ↓
PENDING
   ↓
NotificationService
   ↓
Faculty A
   │
   ├── In-App
   ├── Email
   └── WhatsApp
```

---

# 37. Borrow Request Response Notification

```text
Faculty A
   ↓
Accept / Reject
   ↓
PeriodRequestService
   ↓
NotificationService
   ↓
Faculty B
```

If accepted:

```text
Temporary Timetable Created
        ↓
Notify Affected Students
```

---

# 38. Exam Timetable Notification

```text
Admin
   ↓
Create Exam Timetable
   ↓
Validate
   ↓
Publish
   ↓
NotificationService
   ↓
Students / Faculty
   │
   ├── In-App
   ├── Email
   └── WhatsApp
```

Example:

```text
Exam Timetable Published

Class: S2 CSE

Mathematics:
25-09-2026
10:00 AM

Physics:
29-09-2026
10:00 AM
```

---

# 39. Announcement Notification

```text
Admin
   ↓
Create Announcement
   ↓
Select Audience
   ↓
Publish
   ↓
NotificationService
   ↓
Target Users
   │
   ├── In-App
   ├── Email
   └── WhatsApp
```

Target audience may be:

```text
All Students
All Faculty
Department
Class
Semester
Selected Users
```

---

# 40. Notification Template System

Notification messages should use templates instead of hard-coded strings scattered throughout the application.

```text
NotificationTemplate
       │
       ├── Event Type
       ├── Channel
       ├── Title
       ├── Body
       └── Variables
```

Example:

```text
Event:
ASSIGNMENT_CREATED

Template:

New Assignment: {assignmentTitle}

Subject: {subjectName}
Deadline: {deadline}
```

The same event can have different templates for different channels.

---

# 41. Channel-Specific Templates

```text
ASSIGNMENT_CREATED
       │
       ├── In-App Template
       ├── Email Template
       └── WhatsApp Template
```

Example:

```text
In-App:
New OOP assignment added.

Email:
Subject: New OOP Assignment

WhatsApp:
Campus Management System:
New OOP assignment...
```

This allows each channel to use an appropriate format.

---

# 42. Notification Database

A conceptual notification record may contain:

```text
Notification ID
User ID
Event Type
Title
Message
Channel
Status
Read Status
Created At
Sent At
Delivered At
Read At
Retry Count
Provider Message ID
Error Code
```

Exact fields will be finalized during database design.

---

# 43. Notification Channel Table

A separate channel configuration may be useful.

Conceptually:

```text
Notification Channel
--------------------
Channel ID
Channel Name
Enabled
Provider
Created At
Updated At
```

Example:

```text
IN_APP
EMAIL
WHATSAPP
```

The final database design will determine whether this requires a separate table.

---

# 44. User Notification Preference Data

Conceptually:

```text
Preference ID
User ID
In-App Enabled
Email Enabled
WhatsApp Enabled
Updated At
```

If event-specific preferences are implemented:

```text
User ID
Event Type
In-App Enabled
Email Enabled
WhatsApp Enabled
```

---

# 45. Notification Repository

Possible Repository structure:

```text
repository/
│
├── NotificationRepository.java
└── NotificationPreferenceRepository.java
```

Possible operations:

```text
NotificationRepository
    → create()
    → findByUser()
    → findUnread()
    → markAsRead()
    → updateStatus()
    → updateDeliveryStatus()
    → findFailed()
    → updateRetryCount()

NotificationPreferenceRepository
    → findByUser()
    → save()
    → update()
```

---

# 46. Notification Service Structure

Possible structure:

```text
service/
│
├── NotificationService.java
└── notification/
    │
    ├── InAppNotificationService.java
    ├── EmailNotificationService.java
    └── WhatsAppNotificationService.java
```

Provider abstraction:

```text
notification/
└── provider/
    └── WhatsAppProvider.java
```

The exact package names can be refined during implementation.

---

# 47. Notification Servlet

The Notification Servlet handles user-facing notification operations.

Possible responsibilities:

```text
View Notifications
Mark Notification Read
Mark All Read
View Notification Details
View Preferences
Update Preferences
```

Flow:

```text
Student / Faculty
       ↓
Notification Page
       ↓
NotificationServlet
       ↓
NotificationService
       ↓
NotificationRepository
       ↓
JDBC
       ↓
MySQL
```

Notification sending itself should generally be handled by the service/event flow rather than by a user-facing JSP directly.

---

# 48. Asynchronous Notification Concept

Sending email and WhatsApp messages can take longer than a normal database operation.

A scalable design can use:

```text
System Event
      ↓
Notification Queue
      ↓
Notification Worker
      ↓
Channel Service
      ↓
Email / WhatsApp
```

For the 20-day mini-project MVP, a simpler synchronous or lightweight scheduled approach can be used if required.

The architecture should still keep the channel logic isolated so asynchronous processing can be added later.

---

# 49. Notification Queue Concept

Future architecture:

```text
Application
    ↓
NotificationService
    ↓
Notification Queue
    ↓
Worker
    ↓
┌──────────────┬──────────────┐
↓              ↓              ↓
In-App        Email        WhatsApp
```

This prevents slow external APIs from blocking normal application requests.

---

# 50. Scheduled Notification Flow

Deadline reminders require scheduled processing.

```text
Scheduler
   ↓
Find Upcoming Deadlines
   ↓
Find Eligible Users
   ↓
Check Preferences
   ↓
Create Notification
   ↓
Send
```

Example:

```text
Assignment Deadline
        ↓
Reminder Window
        ↓
Scheduler
        ↓
NotificationService
        ↓
Email / WhatsApp / In-App
```

The exact scheduler implementation will be chosen during backend implementation.

---

# 51. Duplicate Notification Prevention

The system should avoid sending the same notification repeatedly.

Conceptually:

```text
Event
  ↓
Generate Unique Event Reference
  ↓
Check Existing Notification
  ↓
Already Processed?
   ┌──┴──┐
   ↓     ↓
 YES    NO
  │      │
  ↓      ↓
Skip    Create
```

Example:

```text
Assignment ID + Event Type + User ID
```

can form part of a unique notification key.

The exact idempotency design will be finalized later.

---

# 52. Notification Failure Handling

```text
Notification
      ↓
Send
      ↓
Success?
  ┌───┴───┐
  ↓       ↓
 YES      NO
  │        │
  ↓        ↓
SUCCESS  FAILED
           │
           ↓
      Classify Error
           │
      ┌────┴────┐
      ↓         ↓
 Temporary   Permanent
      │         │
      ↓         ↓
   Retry     Log Failure
      │
      ↓
Retry Limit
      │
 ┌────┴────┐
 ↓         ↓
Success   Final Failure
```

---

# 53. Notification Retry Rules

Retry should be controlled.

```text
Maximum Attempts
Retry Delay
Error Type
Provider Response
```

Example conceptual flow:

```text
Attempt 1
   ↓
Failure
   ↓
Wait
   ↓
Attempt 2
   ↓
Failure
   ↓
Wait
   ↓
Attempt 3
   ↓
Final Failure
```

The exact retry count and timing will be defined during implementation.

---

# 54. Notification Logging

Important notification operations should be logged.

Possible information:

```text
Notification ID
User ID
Channel
Event Type
Status
Provider Message ID
Error
Created Time
Sent Time
```

Logs should not expose passwords, API keys, access tokens, or other secrets.

---

# 55. WhatsApp Security

WhatsApp integration must follow these rules:

```text
1. Never expose API credentials in JSP.
2. Never expose API credentials in browser JavaScript.
3. Store secrets in environment/server configuration.
4. Validate recipient phone numbers.
5. Respect user opt-in/preferences.
6. Use approved WhatsApp Business-compatible APIs.
7. Use approved templates where required.
8. Do not send unauthorized messages.
9. Store only necessary provider identifiers.
10. Do not log authentication tokens.
```

---

# 56. Email Security

```text
1. Do not expose SMTP credentials.
2. Store credentials in server configuration.
3. Validate recipient addresses.
4. Prevent unauthorized mass sending.
5. Do not log passwords or tokens.
6. Handle provider errors safely.
```

---

# 57. In-App Security

```text
1. User must be authenticated.
2. User can access only their own notifications.
3. Admin access must be authorized.
4. Notification IDs must be validated.
5. Read-status updates must belong to the logged-in user.
```

---

# 58. Notification Authorization

```text
User
 ↓
Request Notification
 ↓
Session Validation
 ↓
Get Logged-in User ID
 ↓
Find Notification
 ↓
Notification Belongs to User?
 ┌────┴────┐
 ↓         ↓
YES        NO
 │          │
 ↓          ↓
ALLOW      DENY
```

---

# 59. Complete Assignment Notification Example

```text
Faculty
   ↓
Create Assignment
   ↓
AssignmentService
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Assignment Created
   ↓
NotificationService
   ↓
Find Students in Class
   ↓
Check Preferences
   │
   ├──────────────┬──────────────┐
   ↓              ↓              ↓
 In-App          Email        WhatsApp
   │              │              │
   ↓              ↓              ↓
 MySQL         Provider       WhatsApp API
   │              │              │
   └──────────────┼──────────────┘
                  ↓
               Students
```

---

# 60. Complete Substitute Notification Example

```text
Faculty A
   ↓
Create Substitute Request
   ↓
PeriodRequestService
   ↓
MySQL
   ↓
NotificationService
   ↓
Faculty B
   │
   ├── In-App
   ├── Email
   └── WhatsApp
   ↓
Faculty B Accepts
   ↓
Temporary Timetable Created
   ↓
NotificationService
   ├── Faculty A
   ├── Faculty B
   └── Affected Students
```

---

# 61. Complete Borrow Notification Example

```text
Faculty B
   ↓
Create Borrow Request
   ↓
PeriodRequestService
   ↓
MySQL
   ↓
NotificationService
   ↓
Faculty A
   │
   ├── In-App
   ├── Email
   └── WhatsApp
   ↓
Faculty A Accepts
   ↓
Temporary Timetable Created
   ↓
NotificationService
   ├── Faculty A
   ├── Faculty B
   └── Affected Students
```

---

# 62. Complete Timetable Notification Example

```text
Admin
   ↓
Update Timetable
   ↓
TimetableService
   ↓
TimetableRepository
   ↓
MySQL
   ↓
Timetable Updated
   ↓
Find Affected Users
   ↓
NotificationService
   │
   ├── In-App
   ├── Email
   └── WhatsApp
   ↓
Students / Faculty
```

---

# 63. Complete Notification Lifecycle

```text
                        SYSTEM EVENT
                             │
                             ↓
                    NotificationService
                             │
                             ↓
                     Identify Recipients
                             │
                             ↓
                   Check Preferences
                             │
                             ↓
                    Generate Templates
                             │
                ┌────────────┼────────────┐
                ↓            ↓            ↓
             In-App         Email       WhatsApp
                │            │            │
                ↓            ↓            ↓
             Database      Provider      API
                │            │            │
                ↓            ↓            ↓
             UNREAD        SENT         SENT
                │            │            │
                ↓            ↓            ↓
              READ       Delivered    Delivered
                                          │
                                          ↓
                                        READ
```

---

# 64. Notification Status Model

A notification record should distinguish between creation, delivery, and read state.

Possible delivery status:

```text
PENDING
SENT
DELIVERED
FAILED
```

In-app read state:

```text
UNREAD
READ
```

For WhatsApp, provider-specific states may additionally include:

```text
READ
```

The exact provider status mapping will be implemented according to the selected API.

---

# 65. Notification Dashboard for Admin

Admin may have a notification monitoring page.

```text
Admin
   ↓
Notification Management
   ↓
Notification Dashboard
```

Possible statistics:

```text
Total Notifications
Sent
Delivered
Failed
Pending
Unread In-App
WhatsApp Failures
Email Failures
```

This is primarily a monitoring feature and should not expose sensitive message data unnecessarily.

---

# 66. Notification Flow With Repository Layer

```text
                    SOURCE MODULE
                         │
             ┌───────────┼───────────┐
             ↓           ↓           ↓
         Assignment   Timetable   Period Request
             │           │           │
             └───────────┼───────────┘
                         ↓
                NotificationService
                         │
                         ↓
              NotificationRepository
                         │
                         ↓
                        JDBC
                         │
                         ↓
                       MySQL
                         │
                         ↓
                 Notification Record
                         │
              ┌──────────┼──────────┐
              ↓          ↓          ↓
           In-App      Email     WhatsApp
              │          │          │
              ↓          ↓          ↓
           Database   Provider    WhatsApp API
```

---

# 67. Package Structure

A possible professional package structure:

```text
src/
└── main/
    └── java/
        ├── controller/
        │   ├── NotificationServlet.java
        │   └── NotificationPreferenceServlet.java
        │
        ├── service/
        │   ├── NotificationService.java
        │   └── notification/
        │       ├── InAppNotificationService.java
        │       ├── EmailNotificationService.java
        │       └── WhatsAppNotificationService.java
        │
        ├── repository/
        │   ├── NotificationRepository.java
        │   └── NotificationPreferenceRepository.java
        │
        ├── model/
        │   ├── Notification.java
        │   └── NotificationPreference.java
        │
        └── provider/
            └── WhatsAppProvider.java
```

The actual project package naming can be adjusted to match the final repository structure.

---

# 68. JSP Structure

Possible JSP pages:

```text
src/main/webapp/
│
├── student/
│   └── notifications.jsp
│
├── faculty/
│   └── notifications.jsp
│
├── admin/
│   └── notifications.jsp
│
└── common/
    └── notification-panel.jsp
```

A common notification component can be reused where appropriate.

---

# 69. Notification Request Flow

For viewing notifications:

```text
User
   ↓
notifications.jsp
   ↓
NotificationServlet
   ↓
NotificationService
   ↓
NotificationRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Notifications
   ↓
JSP
   ↓
User
```

---

# 70. Mark Notification Read

```text
User
   ↓
Click Notification
   ↓
NotificationServlet
   ↓
NotificationService
   ↓
Verify Ownership
   ↓
NotificationRepository
   ↓
UPDATE notification
SET read_status = 'READ'
   ↓
MySQL
   ↓
Return
```

---

# 71. Notification Preferences Flow

```text
User
   ↓
Notification Settings
   ↓
NotificationPreferenceServlet
   ↓
NotificationPreferenceService
   ↓
NotificationPreferenceRepository
   ↓
MySQL
   ↓
Save Preferences
```

Example:

```text
In-App       ON
Email        ON
WhatsApp     OFF
```

---

# 72. End-to-End Notification Example

### Scenario: Faculty creates an assignment

```text
Faculty
   ↓
Create Assignment
   ↓
AssignmentServlet
   ↓
AssignmentService
   ↓
AssignmentRepository
   ↓
MySQL
   ↓
Assignment Created
   ↓
NotificationService
   ↓
Find Students
   ↓
Check Preferences
   ↓
Create Notification Records
   │
   ├──────────────┬──────────────┐
   ↓              ↓              ↓
 In-App          Email        WhatsApp
   │              │              │
   ↓              ↓              ↓
 MySQL         Email API      WhatsApp API
   │              │              │
   └──────────────┼──────────────┘
                  ↓
               Student
```

---

# 73. End-to-End Period Request Example

### Scenario: Faculty requests a substitute

```text
Faculty A
   ↓
Faculty Calendar
   ↓
Request Substitute
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
Validation
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
PENDING
   ↓
NotificationService
   ↓
Faculty B
   ├── In-App
   ├── Email
   └── WhatsApp
   ↓
Faculty B Accepts
   ↓
TemporaryTimetableService
   ↓
TemporaryTimetableRepository
   ↓
MySQL
   ↓
NotificationService
   ├── Faculty A
   ├── Faculty B
   └── Students
```

---

# 74. End-to-End Exam Example

### Scenario: Admin publishes exam timetable

```text
Admin
   ↓
Exam Timetable
   ↓
Publish
   ↓
ExamService
   ↓
ExamRepository
   ↓
MySQL
   ↓
Exam Timetable Published
   ↓
NotificationService
   ↓
Find Affected Students / Faculty
   ↓
Check Preferences
   │
   ├── In-App
   ├── Email
   └── WhatsApp
```

---

# 75. Notification Event Types

A centralized event list may contain:

```text
ASSIGNMENT_CREATED
ASSIGNMENT_DEADLINE_REMINDER
ASSIGNMENT_DEADLINE_CHANGED
ASSIGNMENT_CANCELLED

TIMETABLE_PUBLISHED
TIMETABLE_UPDATED
TEMPORARY_TIMETABLE_CHANGED

SUBSTITUTE_REQUEST_CREATED
SUBSTITUTE_REQUEST_ACCEPTED
SUBSTITUTE_REQUEST_REJECTED

BORROW_REQUEST_CREATED
BORROW_REQUEST_ACCEPTED
BORROW_REQUEST_REJECTED

EXAM_TIMETABLE_PUBLISHED
EXAM_TIMETABLE_CHANGED

ANNOUNCEMENT_PUBLISHED
```

The final list can be extended as new modules are added.

---

# 76. Notification Design Rules

The following rules will be maintained:

1. Notification logic must be centralized.
2. Assignment, Timetable, Period Management, and Exam modules should not directly implement email or WhatsApp APIs.
3. In-app notifications must be stored in the database.
4. Email delivery must use a dedicated service/provider.
5. WhatsApp delivery must use an official WhatsApp Business-compatible API/provider.
6. WhatsApp API credentials must never be exposed to the browser.
7. User notification preferences must be respected.
8. WhatsApp opt-in/provider requirements must be respected.
9. Notification delivery status should be tracked.
10. Failed notifications should be logged.
11. Temporary failures may be retried.
12. Permanent failures should not be retried indefinitely.
13. Duplicate notifications should be prevented.
14. In-app notifications should support read/unread status.
15. Users should only access their own notifications.
16. Notification templates should be separated from business logic.
17. Channel-specific formatting should be supported.
18. Sensitive data should not be unnecessarily included in notifications.
19. API keys, tokens, passwords, and credentials must never be logged.
20. Notification history should be preserved where required.
21. External provider failures must not corrupt the primary academic transaction.
22. The notification system should be designed so asynchronous delivery can be added later.
23. Notification preferences should be stored separately from the core academic records.
24. The Repository Layer must handle database operations.
25. The Service Layer must handle notification business logic.
26. JDBC must handle database communication.

---

# 77. Final Notification Flow

```text
                         CAMPUS EVENT
                              │
       ┌──────────────────────┼──────────────────────┐
       ↓                      ↓                      ↓
   Assignment             Timetable            Period Request
       │                      │                      │
       └──────────────────────┼──────────────────────┘
                              ↓
                    NotificationService
                              │
                              ↓
                       Find Recipients
                              │
                              ↓
                     Check Preferences
                              │
                              ↓
                     Generate Templates
                              │
               ┌──────────────┼──────────────┐
               ↓              ↓              ↓
            IN-APP          EMAIL         WHATSAPP
               │              │              │
               ↓              ↓              ↓
            MySQL         Email Provider   WhatsApp API
               │              │              │
               ↓              ↓              ↓
            UNREAD          SENT           SENT
               │              │              │
               ↓              ↓              ↓
             READ         Delivered       Delivered
                                              │
                                              ↓
                                            READ
```

---

# 78. Final System-Level Notification Architecture

```text
                              CAMPUS MANAGEMENT SYSTEM
                                         │
          ┌──────────────────────────────┼──────────────────────────────┐
          ↓                              ↓                              ↓
      Assignment                     Timetable                    Period Management
          │                              │                              │
          └──────────────────────────────┼──────────────────────────────┘
                                         ↓
                                Notification Event
                                         │
                                         ↓
                               NotificationService
                                         │
                         ┌───────────────┼───────────────┐
                         ↓               ↓               ↓
                      In-App           Email          WhatsApp
                         │               │               │
                         ↓               ↓               ↓
                    Notification      Provider       WhatsApp
                    Repository                       Business API
                         │               │               │
                         ↓               ↓               ↓
                       MySQL          Recipient       Recipient
                         │
                         ↓
                       Status
                         │
              ┌──────────┴──────────┐
              ↓                     ↓
           Success                Failure
              │                     │
              ↓                     ↓
        Update Status          Retry / Log
```

This document defines the complete current **Notification Module**, including **In-App, Email, and WhatsApp notifications**, and provides the foundation for the Notification UI, Servlet, Service, Repository, WhatsApp API integration, email integration, calendar/timetable notifications, assignment notifications, period-request notifications, database design, and future asynchronous notification processing.
