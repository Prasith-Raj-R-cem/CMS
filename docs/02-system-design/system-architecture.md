# System Architecture

## 1. Overview

The Campus Management System is a web-based academic management application designed to centralize and simplify academic activities for students, faculty members, and administrators.

The system will be developed using Java as the primary programming language, with HTML, CSS, and JavaScript for the frontend, JSP for the presentation layer, Java Servlets for request handling, JDBC for database connectivity, and MySQL for persistent data storage.

The application will follow a layered **MVC architecture with a Service Layer and Repository Layer**.

The architecture is designed to provide clear separation of responsibilities between the user interface, request handling, business logic, data access, and database.

---

## 2. Technology Stack

| Component | Technology |
|---|---|
| Programming Language | Java |
| Frontend | HTML, CSS, JavaScript |
| Presentation Layer | JSP |
| Controller | Java Servlets |
| Application Server | Apache Tomcat |
| Architecture | MVC + Service + Repository |
| Database Connectivity | JDBC |
| Database | MySQL |
| Query Language | SQL |
| Version Control | Git + GitHub |

---

## 3. High-Level Architecture

```text
                         ┌──────────────────────┐
                         │         USER         │
                         │ Student / Faculty /  │
                         │        Admin         │
                         └──────────┬───────────┘
                                    │
                                    ↓
                         ┌──────────────────────┐
                         │       BROWSER        │
                         │    HTML + CSS + JS   │
                         └──────────┬───────────┘
                                    │
                                    ↓
                         ┌──────────────────────┐
                         │         JSP          │
                         │     VIEW LAYER       │
                         └──────────┬───────────┘
                                    │
                                    ↓
                         ┌──────────────────────┐
                         │       SERVLET        │
                         │   CONTROLLER LAYER   │
                         └──────────┬───────────┘
                                    │
                                    ↓
                         ┌──────────────────────┐
                         │       SERVICE        │
                         │   BUSINESS LOGIC     │
                         └──────────┬───────────┘
                                    │
                                    ↓
                         ┌──────────────────────┐
                         │     REPOSITORY       │
                         │    DATA ACCESS       │
                         └──────────┬───────────┘
                                    │
                                    ↓
                         ┌──────────────────────┐
                         │        JDBC          │
                         │ DATABASE CONNECTIVITY │
                         └──────────┬───────────┘
                                    │
                                    ↓
                         ┌──────────────────────┐
                         │        MySQL         │
                         │       DATABASE       │
                         └──────────────────────┘
```

---

## 4. MVC Architecture

The application will follow the Model-View-Controller pattern.

```text
                       MVC ARCHITECTURE
                              │
             ┌────────────────┼────────────────┐
             ↓                ↓                ↓
           MODEL             VIEW          CONTROLLER
             │                │                │
             ↓                ↓                ↓
       Java Classes          JSP            Servlets
             │                │                │
             │          HTML/CSS/JS            │
             │                │                │
             └────────────────┼────────────────┘
                              │
                         Application
```

### 4.1 Model

The Model represents the application's data and domain objects.

Examples:

```text
User
Student
Faculty
Admin
Department
AcademicClass
Subject
Timetable
Exam
Assignment
AssignmentFile
Attendance
Mark
Result
Notification
Announcement
PeriodRequest
```

The Model layer will demonstrate:

- Classes and objects
- Encapsulation
- Inheritance
- Abstraction
- Polymorphism
- Interfaces

### 4.2 View

The View is responsible for presenting information to users.

The View will use:

- JSP
- HTML
- CSS
- JavaScript

Examples:

```text
login.jsp

student/
├── dashboard.jsp
├── timetable.jsp
├── assignments.jsp
├── calendar.jsp
├── attendance.jsp
├── results.jsp
└── notifications.jsp

faculty/
├── dashboard.jsp
├── timetable.jsp
├── assignments.jsp
├── attendance.jsp
├── period-requests.jsp
└── notifications.jsp

admin/
├── dashboard.jsp
├── users.jsp
├── timetable.jsp
├── exam-timetable.jsp
└── results.jsp
```

The View should be responsible primarily for presentation.

It should **not directly execute SQL queries or contain database connection code**.

### 4.3 Controller

The Controller receives HTTP requests from the browser and determines which operation should be performed.

Java Servlets will act as the Controllers.

Examples:

```text
LoginServlet
LogoutServlet

StudentServlet
FacultyServlet
AdminServlet

AssignmentServlet
TimetableServlet
ExamTimetableServlet

AttendanceServlet
ResultServlet

PeriodRequestServlet
NotificationServlet
AnnouncementServlet
```

The Controller is responsible for:

- Receiving HTTP requests
- Reading request parameters
- Performing basic input validation
- Calling the appropriate Service
- Handling the response
- Forwarding data to JSP
- Redirecting users
- Handling application-level errors

The Controller should not contain complex business logic or direct SQL queries.

---

## 5. Service Layer

The Service Layer contains the business logic of the application.

Examples:

```text
AuthService
StudentService
FacultyService
AdminService
AssignmentService
TimetableService
ExamService
AttendanceService
ResultService
PeriodRequestService
NotificationService
AnnouncementService
```

The Service Layer is responsible for:

- Business rules
- Validation
- Processing application operations
- Coordinating multiple repositories
- Applying authorization rules where appropriate
- Handling application-level exceptions

Example:

```text
AssignmentServlet
       ↓
AssignmentService
       ↓
Validate Assignment
       ↓
Validate Deadline
       ↓
Validate Class
       ↓
AssignmentRepository
```

The Service Layer prevents business logic from being placed inside JSP pages or Servlets.

---

## 6. Repository Layer

The Repository Layer is responsible for accessing and managing persistent data.

The official architecture term used in this project is **Repository Layer**.

Examples:

```text
UserRepository
StudentRepository
FacultyRepository
DepartmentRepository
ClassRepository
SubjectRepository
TimetableRepository
ExamRepository
AssignmentRepository
AttendanceRepository
ResultRepository
NotificationRepository
AnnouncementRepository
PeriodRequestRepository
```

Repositories will provide operations such as:

```text
CREATE
READ
UPDATE
DELETE
```

The Repository Layer will communicate with MySQL through JDBC.

Example:

```text
AssignmentService
       ↓
AssignmentRepository
       ↓
JDBC
       ↓
MySQL
```

The Repository Layer should contain data-access operations rather than business rules.

---

## 7. JDBC Layer

JDBC provides communication between the Java application and MySQL.

The database interaction flow is:

```text
Service
   ↓
Repository
   ↓
JDBC
   ↓
Connection
   ↓
PreparedStatement
   ↓
SQL Query
   ↓
MySQL
   ↓
ResultSet
   ↓
Repository
```

The project will use JDBC concepts including:

- Connection
- Driver
- PreparedStatement
- ResultSet
- SQLException
- Transactions where required
- CRUD operations

Parameterized `PreparedStatement` queries will be used instead of directly concatenating user input into SQL queries.

---

## 8. Database Layer

MySQL will provide persistent storage for the application.

The database will contain information related to:

```text
Users
Students
Faculty
Departments
Classes
Subjects
Academic Years
Semesters
Timetables
Examinations
Assignments
Assignment Files
Attendance
Marks
Results
Notifications
Announcements
Period Requests
```

The exact tables, relationships, primary keys, foreign keys, constraints, and indexes will be designed during the **Database Design phase**.

---

## 9. Complete Request Flow

A normal request through the application will follow:

```text
                         USER
                           │
                           ↓
                        BROWSER
                           │
                           │ HTTP Request
                           ↓
                       JSP / HTML
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
                           │ Result
                           ↓
                       REPOSITORY
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
                           │ HTTP Response
                           ↓
                        BROWSER
                           │
                           ↓
                          USER
```

This request-response structure will be followed throughout the application.

---

## 10. Example — Login Flow

The authentication process will follow:

```text
User
 ↓
login.jsp
 ↓
LoginServlet
 ↓
AuthService
 ↓
UserRepository
 ↓
JDBC
 ↓
MySQL
 ↓
Verify Credentials
```

If credentials are invalid:

```text
MySQL
 ↓
Invalid Credentials
 ↓
UserRepository
 ↓
AuthService
 ↓
LoginServlet
 ↓
login.jsp
 ↓
Display Error
```

If credentials are valid:

```text
MySQL
 ↓
Valid Credentials
 ↓
UserRepository
 ↓
AuthService
 ↓
LoginServlet
 ↓
Create HTTP Session
 ↓
Identify User Role
 ↓
Redirect to Dashboard
```

---

## 11. Role-Based Access

The system will support three primary roles:

```text
STUDENT
FACULTY
ADMIN
```

After authentication, the user's role will be stored in the session.

```text
                         LOGIN
                           │
                           ↓
                    Authenticate User
                           │
                           ↓
                      Identify Role
                           │
              ┌────────────┼────────────┐
              ↓            ↓            ↓
           STUDENT      FACULTY       ADMIN
              │            │            │
              ↓            ↓            ↓
         Student JSP   Faculty JSP   Admin JSP
```

Server-side role verification will be performed before accessing protected functionality.

The system will not rely only on hiding buttons or links from users.

---

## 12. HTTP Session Management

After successful authentication, an HTTP session will be created.

The session may contain information such as:

```text
User ID
Username
Role
```

The general flow is:

```text
Successful Login
      ↓
Create Session
      ↓
Store User Information
      ↓
Access Protected Pages
```

When the user logs out:

```text
Logout
   ↓
LogoutServlet
   ↓
Invalidate Session
   ↓
Redirect to Login
```

---

## 13. Assignment Architecture

The assignment module will follow the layered architecture.

```text
Faculty
   ↓
assignment.jsp
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
```

After successful creation:

```text
Assignment Created
       │
       ├───────────────┐
       ↓               ↓
Academic Calendar   Notification
       │               │
       ↓               ↓
Deadline Added      Students
```

Assignment information may include:

```text
Assignment ID
Title
Description
Subject
Class
Faculty
Question Text
File Reference
Submission Date
Submission Time
Created Date
```

---

## 14. Timetable Architecture

The timetable module will allow administrators to create and manage the regular timetable.

```text
Admin
 ↓
timetable.jsp
 ↓
TimetableServlet
 ↓
TimetableService
 ↓
Validate Timetable
 ↓
TimetableRepository
 ↓
JDBC
 ↓
MySQL
```

The system will validate possible conflicts before saving a timetable entry.

Once saved:

```text
                     MySQL
                       │
          ┌────────────┼────────────┐
          ↓            ↓            ↓
       Student       Faculty       Admin
          │            │            │
          ↓            ↓            ↓
      View Class   View Teaching  Manage
      Timetable     Timetable     Timetable
```

---

## 15. Period Management Architecture

The system supports two different types of period requests.

### 15.1 Substitute Period

A faculty member can request another faculty member to take their period.

```text
Faculty A
   ↓
Faculty Calendar
   ↓
Select Own Period
   ↓
Select Faculty B
   ↓
Add Optional Note
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
NotificationService
   ↓
Faculty B
```

If accepted:

```text
Faculty B Accepts
       ↓
Temporary Timetable Change
       ↓
Faculty = Faculty B
Subject = Original Subject
       ↓
Student Timetable Updated
```

### 15.2 Borrowed Period

A faculty member can request another faculty member's period to teach their own subject.

```text
Faculty B
   ↓
Faculty Calendar
   ↓
Select Faculty A's Period
   ↓
Select Own Subject
   ↓
Select Class
   ↓
Add Optional Note
   ↓
Send Request
   ↓
PeriodRequestService
   ↓
PeriodRequestRepository
   ↓
MySQL
   ↓
Notify Faculty A
```

If accepted:

```text
Faculty A Accepts
       ↓
Temporary Timetable Change
       ↓
Subject = Faculty B's Subject
Faculty = Faculty B
       ↓
Student Timetable Updated
```

---

## 16. Notification Architecture

The notification system will use an interface-based design.

```text
                  NotificationService
                          │
             ┌────────────┼────────────┐
             ↓            ↓            ↓
       AppNotification  EmailAdapter  WhatsAppAdapter
```

The application can generate notifications for events such as:

```text
New Assignment
Upcoming Deadline
Exam Timetable
Timetable Change
Substitute Request
Borrow Period Request
Request Accepted
Request Rejected
Announcement
```

The notification service will allow additional notification providers to be added in the future without changing the core business logic.

---

## 17. File Upload Architecture

Faculty members will be able to upload assignment question files such as images and documents.

The upload flow will be:

```text
Faculty
   ↓
Assignment JSP
   ↓
AssignmentServlet
   ↓
File Validation
   ↓
File Storage
   ↓
AssignmentRepository
   ↓
MySQL
```

The system will validate:

- File type
- File size
- File name
- User permission

The database will store appropriate file metadata or references rather than unnecessarily storing large files directly in regular relational records.

---

## 18. Exception Handling

The system will use Java exception handling throughout the application.

Possible custom exceptions include:

```text
DatabaseException
InvalidLoginException
UserNotFoundException
AssignmentNotFoundException
TimetableConflictException
PeriodRequestException
ValidationException
UnauthorizedAccessException
```

The general error flow is:

```text
Repository
    ↓
Database / Data Error
    ↓
Exception
    ↓
Service
    ↓
Controller
    ↓
Error Handling
    ↓
JSP Error Message
    ↓
User
```

Technical details such as SQL queries, stack traces, and database credentials must not be displayed to normal users.

---

## 19. Design Patterns

The project will demonstrate the design patterns required by the syllabus while using them for meaningful purposes.

### 19.1 Singleton Pattern

A centralized database connection/configuration manager may use the Singleton pattern.

```text
Application
    │
    ↓
DatabaseConnectionManager
    │
    ↓
JDBC
    │
    ↓
MySQL
```

The purpose is to centralize database connection management and avoid uncontrolled creation of connection-management objects.

### 19.2 Adapter Pattern

The notification system can use Adapter implementations for external notification providers.

```text
                NotificationService
                       │
          ┌────────────┼────────────┐
          ↓            ↓            ↓
     App Adapter   Email Adapter  WhatsApp Adapter
```

The Adapter pattern allows external services with different APIs to be accessed through a common application-level interface.

---

## 20. SOLID Principles

The architecture will apply SOLID principles throughout the project.

### Single Responsibility Principle

Each layer and class should have a clear responsibility.

```text
Servlet
→ Handles HTTP requests

Service
→ Handles business logic

Repository
→ Handles data access

JSP
→ Handles presentation
```

### Open/Closed Principle

The system should allow new functionality to be added without unnecessary modification to existing stable components.

The notification architecture is an example.

### Liskov Substitution Principle

Classes implementing common abstractions should be usable wherever those abstractions are expected.

### Interface Segregation Principle

Interfaces should remain focused on specific responsibilities.

### Dependency Inversion Principle

Higher-level business logic should depend on abstractions where appropriate rather than being tightly coupled to concrete implementations.

---

## 21. Security Architecture

The system will implement basic security measures including:

- Password hashing
- PreparedStatement for database queries
- HTTP session management
- Server-side authorization
- Input validation
- File upload validation
- Access control
- Session invalidation during logout
- Protection of sensitive configuration information

Passwords must never be stored as plain text.

JSP pages must never contain direct database credentials or database connection code.

---

## 22. Separation of Responsibilities

The following responsibilities are strictly separated:

```text
┌─────────────────────────────────────────┐
│ JSP / HTML / CSS / JavaScript           │
│ Presentation                            │
└───────────────────┬─────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ Servlet                                 │
│ HTTP Request / Response Handling        │
└───────────────────┬─────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ Service                                 │
│ Business Logic                          │
└───────────────────┬─────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ Repository                              │
│ Data Access                             │
└───────────────────┬─────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ JDBC                                    │
│ Database Connectivity                   │
└───────────────────┬─────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│ MySQL                                   │
│ Persistent Data                         │
└─────────────────────────────────────────┘
```

No layer should unnecessarily take over the responsibility of another layer.

---

## 23. Example: Complete Assignment Request

When a faculty member creates an assignment, the complete request flow is:

```text
Faculty
   ↓
Browser
   ↓
assignment.jsp
   ↓
HTTP POST Request
   ↓
AssignmentServlet
   ↓
AssignmentService
   │
   ├── Validate Input
   ├── Validate Deadline
   ├── Validate Class
   └── Validate Subject
   ↓
AssignmentRepository
   ↓
JDBC
   ↓
MySQL
   ↓
Assignment Created
   │
   ├───────────────┐
   ↓               ↓
Calendar       NotificationService
   │               │
   ↓               ↓
Deadline        Student
Added           Notifications
```

---

## 24. Example: Complete Period Borrow Request

```text
Faculty B
   ↓
Browser
   ↓
faculty-calendar.jsp
   ↓
Select Faculty A's Period
   ↓
period-request.jsp
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   │
   ├── Validate Period
   ├── Validate Faculty
   ├── Check Conflicts
   └── Create Request
   ↓
PeriodRequestRepository
   ↓
JDBC
   ↓
MySQL
   ↓
NotificationService
   ↓
Faculty A
   ↓
Accept / Reject
   ↓
PeriodRequestServlet
   ↓
PeriodRequestService
   ↓
Temporary Timetable Update
   ↓
Student Timetable
```

---

## 25. Future Expansion

The initial system is a web application, but the architecture is designed to support future platforms.

### Current Version

```text
Browser
   ↓
HTML + CSS + JavaScript
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
```

### Future Architecture

The application can later introduce a REST API:

```text
                    Central Backend
                          │
             ┌────────────┼────────────┐
             ↓            ↓            ↓
          Website      Desktop       Mobile
             │            │            │
             └────────────┼────────────┘
                          ↓
                       REST API
                          ↓
                    Service Layer
                          ↓
                   Repository Layer
                          ↓
                       Database
```

This will allow the same core business logic and database to support multiple client applications.

---

## 26. Final Architecture

The final architecture of the initial Campus Management System is:

```text
                         CAMPUS MANAGEMENT SYSTEM
                                  │
                                  ↓
                         ┌─────────────────┐
                         │     BROWSER     │
                         └────────┬────────┘
                                  ↓
                     ┌────────────────────────┐
                     │   HTML + CSS + JS      │
                     │    PRESENTATION        │
                     └───────────┬────────────┘
                                 ↓
                     ┌────────────────────────┐
                     │          JSP           │
                     │      VIEW LAYER        │
                     └───────────┬────────────┘
                                 ↓
                     ┌────────────────────────┐
                     │       SERVLETS         │
                     │    CONTROLLER LAYER    │
                     └───────────┬────────────┘
                                 ↓
                     ┌────────────────────────┐
                     │        SERVICE         │
                     │     BUSINESS LOGIC     │
                     └───────────┬────────────┘
                                 ↓
                     ┌────────────────────────┐
                     │      REPOSITORY        │
                     │      DATA ACCESS       │
                     └───────────┬────────────┘
                                 ↓
                     ┌────────────────────────┐
                     │          JDBC          │
                     │ DATABASE CONNECTIVITY  │
                     └───────────┬────────────┘
                                 ↓
                     ┌────────────────────────┐
                     │         MySQL          │
                     │        DATABASE        │
                     └────────────────────────┘
```


