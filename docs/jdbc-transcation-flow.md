```
StudentService
      │
      │ Connection A
      │
      ├───────────────┐
      ↓               ↓
 UserService    StudentRepository
      ↓               ↓
 UserRepository      students
      ↓
    users

```

```
Connection
   │
   └── Transaction try
          │
          ├── Create User
          ├── Create Student
          │
          ├── COMMIT
          │
          └── Exception
                ↓
             ROLLBACK
```