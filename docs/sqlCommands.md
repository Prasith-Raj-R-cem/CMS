```
use cambus_management;
```

## All users

```
SELECT id, email, password_hash, role, status
            FROM users
            ORDER BY id
```


Core/master data:

SELECT * FROM departments;
SELECT * FROM academic_years;
SELECT * FROM semesters;
SELECT * FROM periods;
SELECT * FROM rooms;
SELECT * FROM subjects;
SELECT * FROM classes;

Users and academic people:

SELECT * FROM users;
SELECT * FROM faculties;
SELECT * FROM students;

Mappings:

SELECT * FROM class_subjects;
SELECT * FROM faculty_subjects;

Timetable:

SELECT * FROM timetables;
SELECT * FROM temporary_timetables;

Assignments:

SELECT * FROM assignments;
SELECT * FROM assignment_attachments;

Exams:

SELECT * FROM exams;
SELECT * FROM exam_timetables;

Notifications / communication:

SELECT * FROM notifications;
SELECT * FROM notification_preferences;
SELECT * FROM announcements;

Teacher period management:

SELECT * FROM period_requests;
Important