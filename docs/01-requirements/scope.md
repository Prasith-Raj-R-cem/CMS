# Project Scope

<div style="text-align: justify;">

## 1. Introduction

The Campus Management System is a centralized academic management application designed to organize and simplify important academic activities within a college. The system will provide separate functionalities for students, faculty members, and administrators.

The initial version of the system will be developed as a Java Swing desktop application using Java, JDBC, and MySQL. The architecture will be designed in a modular manner so that the system can be extended to web and mobile platforms in future versions.

## 2. In-Scope Features

### 2.1 Student Module

The student module will provide students with access to their academic information and activities.

Features include:

* Student login and authentication
* Student profile
* Student dashboard
* Class timetable
* Examination timetable
* Academic calendar
* Assignment and project deadlines
* Notebook submission deadlines
* Assignment question viewing
* Question text viewing
* Uploaded question/image/document viewing
* Academic notifications
* Attendance information
* Internal marks and academic results
* SGPA and CGPA information
* Faculty announcements

### 2.2 Faculty Module

The faculty module will provide tools for managing teaching and academic activities.

Features include:

* Faculty login and authentication
* Faculty profile
* Faculty dashboard
* Personal teaching timetable
* Assignment creation
* Assignment question text
* Question image/document upload
* Assignment submission date and time
* Assignment editing and management
* Attendance management
* Marks entry
* Academic announcements
* Period substitution requests
* Period borrowing requests
* Accepting or rejecting period requests
* Optional reply notes for requests
* Faculty notifications

### 2.3 Admin Module

The administrator module will provide centralized management of academic data.

Features include:

* Admin login
* Admin dashboard
* Student management
* Faculty management
* Department management
* Class/division management
* Subject management
* Academic year management
* Class timetable management
* Faculty timetable management
* Examination timetable management
* Academic announcements
* Result management and verification
* Monitoring of temporary timetable changes
* Period request management

### 2.4 Timetable Management

The system will support both regular and temporary timetable information.

The regular timetable will include:

* Class
* Subject
* Faculty
* Day
* Period
* Time
* Room

The system will also support temporary timetable changes caused by:

* Faculty substitution
* Faculty period borrowing

When a period is borrowed, the student timetable will temporarily display the borrowing faculty member's subject and faculty.

When a substitute faculty member takes a period, the original subject will remain unchanged while the assigned faculty member will temporarily change.

### 2.5 Assignment and Deadline Management

Faculty members will be able to create academic tasks such as:

* Assignments
* Projects
* Notebook submissions
* Other academic submissions

Each task can contain:

* Title
* Subject
* Description
* Question text
* Uploaded image/document
* Class
* Submission date
* Submission time
* Faculty information

Students will be able to view these tasks through their dashboard and calendar.

### 2.6 Notification System

The system will provide notifications for important academic events.

The notification architecture will support:

* In-application notifications
* Email notifications
* WhatsApp notifications

Notifications may be generated for:

* New assignments
* Upcoming deadlines
* Assignment deadlines
* Examination dates
* Period requests
* Accepted or rejected period requests
* Announcements

The initial implementation may prioritize in-application notifications and email, while WhatsApp integration can be completed when the required API/service configuration is available.

### 2.7 Attendance and Results

Faculty members will be able to record attendance and academic marks.

Students will be able to view:

* Attendance percentage
* Subject-wise marks
* Semester results
* SGPA
* CGPA

Administrators will be able to manage and verify academic results.

## 3. Technical Scope

The initial project will use the following technologies and concepts:

### Programming Language

* Java

### User Interface

* Java Swing
* JFrame
* JPanel
* JLabel
* JButton
* JTextField
* JTable
* JComboBox
* JTextArea
* Other required Swing components

### Architecture

* MVC
* Service Layer
* Repository Layer

### Database

* MySQL

### Database Connectivity

* JDBC
* SQL
* PreparedStatement
* ResultSet
* CRUD operations

### Object-Oriented Concepts

* Encapsulation
* Inheritance
* Polymorphism
* Abstraction
* Interfaces

### Additional Java Concepts

* Packages
* Exception handling
* Custom exceptions
* SOLID principles
* Singleton design pattern
* Adapter design pattern
* Event handling

## 4. Out-of-Scope for the Initial Version

The following features are considered future enhancements rather than mandatory components of the initial academic version:

* Native Android application
* Native iOS application
* Web-based frontend
* Dedicated desktop software using another GUI framework
* Advanced AI-based academic assistance
* Online fee payment
* Advanced analytics and dashboards
* Parent portal
* Advanced chat/messaging system
* Automated integration with official university systems
* Advanced cloud infrastructure
* Large-scale multi-college deployment

These features may be considered in future versions without changing the core purpose of the system.

## 5. Future Expansion

The system will be designed with future expansion in mind.

The long-term architecture can evolve from:

```text
Java Swing Application
        ↓
Service Layer
        ↓
JDBC
        ↓
MySQL
```

into a centralized backend architecture:

```text
Web Application
       │
Desktop Application
       │
Mobile Application
       │
       ↓
Central Backend API
       ↓
Database
```

This will allow multiple types of clients to use the same academic data and business logic.

## 6. Scope Boundary

The primary goal of the mini-project is to demonstrate a functional campus management system while applying the Java and database concepts specified in the course syllabus.

The project will prioritize:

1. Correct system design
2. Proper object-oriented implementation
3. MVC architecture
4. Database integration using JDBC
5. Reliable CRUD operations
6. Role-based functionality
7. Proper exception handling
8. Demonstration of required design patterns
9. A functional and usable interface
10. A foundation suitable for future expansion
</div>