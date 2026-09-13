package com.cms.model;

public class AcademicYear {

    private long id;
    private String yearName;
    private String startDate;
    private String endDate;
    private String status;

    public AcademicYear() {
    }

    public AcademicYear(long id,
                        String yearName,
                        String startDate,
                        String endDate,
                        String status) {

        this.id = id;
        this.yearName = yearName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getYearName() {
        return yearName;
    }

    public void setYearName(String yearName) {
        this.yearName = yearName;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}