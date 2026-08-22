# Campus Management System — Syllabus Mapping

## Table of Contents
- [Module 1 - Java Fundamentals](#module-1)
- [Module 2 - OOP Concepts](#module-2)
- [Module 3 - Packages & Interfaces](#module-3)
- [Module 4 - Swing](#module-4)
- [Complete Project → Syllabus Mapping
](#complete-syllabus-mapping)



## Module 1

| Syllabus topic                | Where we use it                                     |
| :----------------------------- | --------------------------------------------------- |
| Simple Java program structure | `Main.java`                                         |
| Variables & data types        | All model/service classes                           |
| Wrapper classes               | Data processing and database values                 |
| Casting / autoboxing          | Database/result processing where appropriate        |
| Arrays                        | Timetable slots, subject data, result processing    |
| Strings                       | Names, emails, descriptions, questions              |
| Operators                     | Attendance, marks, calculations                     |
| Conditional statements        | Authentication, permissions, statuses               |
| Iteration                     | Student lists, timetable entries, notifications     |
| Jump statements               | Validation/processing logic where appropriate       |
| Methods                       | All classes                                         |
| Command-line arguments        | Application configuration/testing where appropriate |
| Classes                       | All domain objects                                  |
| Abstract classes              | `User` / shared domain behavior where appropriate   |
| Interfaces                    | Repository and notification contracts               |

Example

```User
 ├── Student
 ├── Faculty
 └── Admin 
 ```

→ [Back to top](#campus-management-system--syllabus-mapping)


## Module 2

### 1. Encapsulation

```private String email;

public String getEmail() {
    return email;
}

public void setEmail(String email) {
    this.email = email;
}
```
### 2. Inheritance
``` 
                User
                 │
       ┌─────────┼─────────┐
       ↓         ↓         ↓
   Student    Faculty    Admin
```

### 3. Polymorphism

#### Method overriding

For example, different user types can implement role-specific behavior.

#### Method overloading

```
createAssignment(...)
createAssignment(..., file)
createAssignment(..., file, deadline)
```
#### Notification system
```
NotificationService
        │
 ┌──────┼──────────┐
 ↓      ↓          ↓
Email  WhatsApp   App
```
### 4. Abstraction

```
abstract User
       │
 ┌─────┼─────┐
Student Faculty Admin

        AND

NotificationService
```

### 5. super, this, final

In most of the codes.

→ [Back to top](#campus-management-system--syllabus-mapping)

## Module 3

### Proper package structure

```
com.campus
│
├── model
├── view
├── controller
├── service
├── repository
├── notification
├── exception
├── util
└── config
```

Example:

```
UserRepository
AssignmentRepository
TimetableRepository
NotificationService
```

### Exception Handling

#### Custom exceptions

```
DatabaseException
UserNotFoundException
InvalidLoginException
AssignmentNotFoundException
TimetableConflictException
PeriodRequestException
```

This project will demonstrate

* try
* catch
* finally
* throw
* throws
* custom exceptions
* multiple catch
* checked exceptions
* unchecked exceptions

##### Example scenario

If two teachers are accidentally assigned to the same period:

```
Admin
 ↓
Create timetable
 ↓
Conflict detected
 ↓
TimetableConflictException
 ↓
User-friendly error
```
### Design Patterns

#### Singleton

Controlled database connection

```
DatabaseConnection
        ↓
JDBC
        ↓
MySQL
```

#### Adapter

Notification system

```
                 NotificationService
                         │
                Adapter Interface
                         │
          ┌──────────────┼──────────────┐
          ↓              ↓              ↓
    Email Adapter   WhatsApp Adapter   App Adapter
```

### SOLID Principles

Architecture will deliberately support SOLID.

```
Swing View
    ↓
Controller
    ↓
Service
    ↓
Repository
    ↓
JDBC
    ↓
MySQL
```

Example

AssignmentService handles assignment-related business logic.

It shouldn't also be responsible for drawing Swing components or executing raw UI logic.

→ [Back to top](#campus-management-system--syllabus-mapping)

## Module 4

### Frontend technology - Swing

```
JFrame
JPanel
JLabel
JButton
JTextField
JPasswordField
JTable
JComboBox
JTextArea
JOptionPane
```

Structure

```
LoginFrame
     │
     ├── JLabel
     ├── JTextField
     ├── JPasswordField
     └── JButton
```

### MVC

```
Swing View
     ↓
Controller
     ↓
Service
     ↓
Repository
     ↓
Database
```

### Event Handling

```
Student clicks
"View Assignment"
        ↓
ActionListener
        ↓
Controller
        ↓
AssignmentService
        ↓
Database
        ↓
Display assignment
```

### JDBC

```
JDBC
 │
 ├── Connection
 ├── PreparedStatement
 ├── ResultSet
 ├── SQLException
 └── CRUD
```

Example

```
Admin
 ↓
Create timetable
 ↓
Controller
 ↓
Service
 ↓
Repository
 ↓
PreparedStatement
 ↓
MySQL
```

#### CREATE

Adding:

* Students
* Faculty
* Subjects
* Assignments
* Timetable
* Period requests

#### READ

Retrieving:

* Student timetable
* Assignments
* Notifications
* Attendance
* Results

#### UPDATE

Updating:

* Assignment
* Timetable
* Attendance
* Period request status

#### DELETE

* Deleting appropriate records where required.

## Complete Syllabus Mapping

| Project component                     | Concepts demonstrated                                 |
| ------------------------------------- | ----------------------------------------------------- |
| `User`, `Student`, `Faculty`, `Admin` | Classes, objects, encapsulation, inheritance          |
| `User` hierarchy                      | Abstraction, inheritance                              |
| Notification interface                | Interfaces, abstraction                               |
| Email/WhatsApp/App implementations    | Polymorphism, Adapter                                 |
| Service layer                         | SOLID                                                 |
| Repository layer                      | Interfaces, abstraction, separation of responsibility |
| `DatabaseConnection`                  | Singleton                                             |
| Login                                 | Methods, conditions, exception handling               |
| Timetable                             | Classes, collections/arrays, CRUD, JDBC               |
| Assignment system                     | OOP, JDBC, Swing, event handling                      |
| Calendar                              | Swing components, event handling                      |
| Period borrowing                      | OOP, custom exceptions, JDBC                          |
| Timetable conflict                    | Custom exception                                      |
| Attendance                            | JDBC, CRUD, calculations                              |
| Results                               | JDBC, calculations, OOP                               |
| SGPA/CGPA                             | Methods, loops, arithmetic                            |
| Notifications                         | Interfaces, polymorphism, Adapter                     |
| Swing screens                         | Swing + MVC                                           |
| Buttons/forms                         | Event handling                                        |
| MySQL                                 | Database application                                  |
| Repository → JDBC                     | JDBC architecture                                     |
| Error handling                        | Exceptions                                            |
| Package structure                     | Packages                                              |
| Overall architecture                  | MVC + SOLID                                           |

→ [Back to top](#campus-management-system--syllabus-mapping)
