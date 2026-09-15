package com.cms.model;

public class AssignmentSummary {

    private long id;
    private String title;

    private String subjectCode;
    private String subjectName;

    private String className;
    private String section;

    private String deadline;


    // =====================================================
    // CONSTRUCTOR
    // =====================================================

    public AssignmentSummary() {
    }


    public AssignmentSummary(
            long id,
            String title,
            String subjectCode,
            String subjectName,
            String className,
            String section,
            String deadline
    ) {

        this.id = id;
        this.title = title;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.className = className;
        this.section = section;
        this.deadline = deadline;
    }


    // =====================================================
    // GETTERS AND SETTERS
    // =====================================================

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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


    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }


    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }


    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }
}