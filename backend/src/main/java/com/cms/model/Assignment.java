package com.cms.model;

public class Assignment {

    private long id;
    private String title;
    private String description;

    private long classId;
    private long subjectId;
    private long facultyId;

    private String deadline;
    private String status;

    private String createdAt;
    private String updatedAt;


    // Empty constructor
    public Assignment() {
    }


    // Full constructor
    public Assignment(
            long id,
            String title,
            String description,
            long classId,
            long subjectId,
            long facultyId,
            String deadline,
            String status,
            String createdAt,
            String updatedAt) {

        this.id = id;
        this.title = title;
        this.description = description;
        this.classId = classId;
        this.subjectId = subjectId;
        this.facultyId = facultyId;
        this.deadline = deadline;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }


    // ID

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }


    // Title

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    // Description

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    // Class ID

    public long getClassId() {
        return classId;
    }

    public void setClassId(long classId) {
        this.classId = classId;
    }


    // Subject ID

    public long getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(long subjectId) {
        this.subjectId = subjectId;
    }


    // Faculty ID

    public long getFacultyId() {
        return facultyId;
    }

    public void setFacultyId(long facultyId) {
        this.facultyId = facultyId;
    }


    // Deadline

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }


    // Status

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    // Created At

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }


    // Updated At

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
}