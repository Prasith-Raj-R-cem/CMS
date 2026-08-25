package com.cms.model;

public class User{
    // data
    private int id;
    private String email;
    private String passwordHash;
    private Role role;
    private String status;

    public User(){}

    public User(
        int id,
        String email,
        String passwordHash,
        Role role,
        String status
    ){
        this.id = id;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.status = status;
    }   

    public int getId(){
        return id;
    }
    public void setId(int id){
        this.id = id;
    }

    public String getEmail(){
        return email;
    }
    public void setEmail(String email){
        this.email = email;
    }

    public String getPasswordHash(){
        return passwordHash;
    }
    public void setPasswordHash(String passwordHash){
        this.passwordHash = passwordHash;
    }

    public Role getRole(){
        return role;
    }
    public void setRole(Role role){
        this.role = role;
    }

    public String getStatus(){
        return status;
    }
    public void setStatus(String status){
        this.status = status;
    }
}