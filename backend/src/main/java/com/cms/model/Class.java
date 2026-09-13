package com.cms.model;

public class Class {

    private long id;
    private String className;
    private long departmentId;
    private long semesterId;
    private long academicYearId;
    private String section;
    private String status;

    public Class() {
    }

    public Class(long id,
                 String className,
                 long departmentId,
                 long semesterId,
                 long academicYearId,
                 String section,
                 String status) {

        this.id = id;
        this.className = className;
        this.departmentId = departmentId;
        this.semesterId = semesterId;
        this.academicYearId = academicYearId;
        this.section = section;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(long departmentId) {
        this.departmentId = departmentId;
    }

    public long getSemesterId() {
        return semesterId;
    }

    public void setSemesterId(long semesterId) {
        this.semesterId = semesterId;
    }

    public long getAcademicYearId() {
        return academicYearId;
    }

    public void setAcademicYearId(long academicYearId) {
        this.academicYearId = academicYearId;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}