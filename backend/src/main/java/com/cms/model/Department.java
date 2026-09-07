package com.cms.model;

public class Department {

    private long id;
    private String departmentCode;
    private String departmentName;
    private String status;

    public Department() {
    }

    public Department(long id,
                      String departmentCode,
                      String departmentName,
                      String status) {

        this.id = id;
        this.departmentCode = departmentCode;
        this.departmentName = departmentName;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDepartmentCode() {
        return departmentCode;
    }

    public void setDepartmentCode(String departmentCode) {
        this.departmentCode = departmentCode;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}