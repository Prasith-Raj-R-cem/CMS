package com.cms.model;

public class Timetable {

    private long id;
    private long classId;
    private long subjectId;
    private long facultyId;
    private long periodId;
    private Long roomId;
    private long academicYearId;
    private long semesterId;
    private String dayOfWeek;
    private String status;
    private String createdAt;
    private String updatedAt;

    public Timetable() {
    }

    public Timetable(
            long id,
            long classId,
            long subjectId,
            long facultyId,
            long periodId,
            Long roomId,
            long academicYearId,
            long semesterId,
            String dayOfWeek,
            String status,
            String createdAt,
            String updatedAt) {

        this.id = id;
        this.classId = classId;
        this.subjectId = subjectId;
        this.facultyId = facultyId;
        this.periodId = periodId;
        this.roomId = roomId;
        this.academicYearId = academicYearId;
        this.semesterId = semesterId;
        this.dayOfWeek = dayOfWeek;
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

    public long getClassId() {
        return classId;
    }

    public void setClassId(long classId) {
        this.classId = classId;
    }

    public long getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(long subjectId) {
        this.subjectId = subjectId;
    }

    public long getFacultyId() {
        return facultyId;
    }

    public void setFacultyId(long facultyId) {
        this.facultyId = facultyId;
    }

    public long getPeriodId() {
        return periodId;
    }

    public void setPeriodId(long periodId) {
        this.periodId = periodId;
    }

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public long getAcademicYearId() {
        return academicYearId;
    }

    public void setAcademicYearId(long academicYearId) {
        this.academicYearId = academicYearId;
    }

    public long getSemesterId() {
        return semesterId;
    }

    public void setSemesterId(long semesterId) {
        this.semesterId = semesterId;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
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