package com.cms.model;

public class Period {

    private long id;
    private int periodNumber;
    private String startTime;
    private String endTime;
    private String status;

    public Period() {
    }

    public Period(long id,
                  int periodNumber,
                  String startTime,
                  String endTime,
                  String status) {

        this.id = id;
        this.periodNumber = periodNumber;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getPeriodNumber() {
        return periodNumber;
    }

    public void setPeriodNumber(int periodNumber) {
        this.periodNumber = periodNumber;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}