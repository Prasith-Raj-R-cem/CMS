package com.cms.model;

public class Faculty {

    private long id;
    private long userId;
    private String employeeId;
    private long departmentId;
    private String status;
    private String createdAt;
    private String updatedAt;

    public Faculty() {
    }

    public Faculty(long id,
                   long userId,
                   String employeeId,
                   long departmentId,
                   String status,
                   String createdAt,
                   String updatedAt) {

        this.id = id;
        this.userId = userId;
        this.employeeId = employeeId;
        this.departmentId = departmentId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(long departmentId) {
        this.departmentId = departmentId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
}