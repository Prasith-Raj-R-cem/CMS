package com.cms.model;

public class Semester {

    private long id;
    private long academicYearId;
    private int semesterNumber;
    private String semesterName;
    private String status;

    public Semester() {
    }

    public Semester(long id,
                    long academicYearId,
                    int semesterNumber,
                    String semesterName,
                    String status) {

        this.id = id;
        this.academicYearId = academicYearId;
        this.semesterNumber = semesterNumber;
        this.semesterName = semesterName;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getAcademicYearId() {
        return academicYearId;
    }

    public void setAcademicYearId(long academicYearId) {
        this.academicYearId = academicYearId;
    }

    public int getSemesterNumber() {
        return semesterNumber;
    }

    public void setSemesterNumber(int semesterNumber) {
        this.semesterNumber = semesterNumber;
    }

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}