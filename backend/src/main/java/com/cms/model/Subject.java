package com.cms.model;

import java.math.BigDecimal;

public class Subject {

    private long id;
    private String subjectCode;
    private String subjectName;
    private long departmentId;
    private long semesterId;
    private BigDecimal credits;
    private String subjectType;
    private String status;

    public Subject() {
    }

    public Subject(long id,
                   String subjectCode,
                   String subjectName,
                   long departmentId,
                   long semesterId,
                   BigDecimal credits,
                   String subjectType,
                   String status) {

        this.id = id;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.departmentId = departmentId;
        this.semesterId = semesterId;
        this.credits = credits;
        this.subjectType = subjectType;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
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

    public BigDecimal getCredits() {
        return credits;
    }

    public void setCredits(BigDecimal credits) {
        this.credits = credits;
    }

    public String getSubjectType() {
        return subjectType;
    }

    public void setSubjectType(String subjectType) {
        this.subjectType = subjectType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}