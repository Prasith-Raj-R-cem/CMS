```
use cambus_management;
```

## All users

```
SELECT id, email, password_hash, role, status
            FROM users
            ORDER BY id
```