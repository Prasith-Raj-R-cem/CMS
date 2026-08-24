package com.cms;

import org.mindrot.jbcrypt.BCrypt;

public class TestPasswordHash {

    public static void main(String[] args) {

        String password = "admin123";

        String storedHash =
                "$2a$12$kaMFwbrsndshfc0wJlUXF.eXRUREbvSPDIDNQz8yYwJrh0ZG9ELDG";

        boolean result =
                BCrypt.checkpw(password, storedHash);

        System.out.println(
                "BCrypt verification: " + result
        );
    }
}