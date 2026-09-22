package com.cms.model;

public class FacultyAssignmentSummary {

    private long id;

    private String title;
    private String description;

    private String className;
    private String section;

    private String subjectCode;
    private String subjectName;

    private String deadline;
    private String status;

    private String createdAt;


    // =====================================================
    // ID
    // =====================================================

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }


    // =====================================================
    // TITLE
    // =====================================================

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    // =====================================================
    // DESCRIPTION
    // =====================================================

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    // =====================================================
    // CLASS NAME
    // =====================================================

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }


    // =====================================================
    // SECTION
    // =====================================================

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }


    // =====================================================
    // SUBJECT CODE
    // =====================================================

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }


    // =====================================================
    // SUBJECT NAME
    // =====================================================

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }


    // =====================================================
    // DEADLINE
    // =====================================================

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }


    // =====================================================
    // STATUS
    // =====================================================

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    // =====================================================
    // CREATED AT
    // =====================================================

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}