package com.cms.service;

import java.math.BigDecimal;
import java.util.List;

import com.cms.model.Subject;
import com.cms.repository.SubjectRepository;

public class SubjectService {

    private final SubjectRepository subjectRepository;

    public SubjectService() {
        this.subjectRepository = new SubjectRepository();
    }

    public long createSubject(Subject subject) {

        if (subject == null) {
            return -1;
        }

        if (subject.getSubjectCode() == null ||
                subject.getSubjectCode().isBlank()) {
            return -1;
        }

        if (subject.getSubjectName() == null ||
                subject.getSubjectName().isBlank()) {
            return -1;
        }

        if (subject.getDepartmentId() <= 0) {
            return -1;
        }

        if (subject.getSemesterId() <= 0) {
            return -1;
        }

        if (subject.getCredits() == null ||
                subject.getCredits().compareTo(BigDecimal.ZERO) <= 0) {
            return -1;
        }

        if (subject.getSubjectType() == null ||
                subject.getSubjectType().isBlank()) {
            return -1;
        }

        String subjectType = subject.getSubjectType().trim().toUpperCase();

        if (!subjectType.equals("THEORY") &&
                !subjectType.equals("LAB") &&
                !subjectType.equals("ELECTIVE") &&
                !subjectType.equals("OTHER")) {
            return -1;
        }

        subject.setSubjectCode(
                subject.getSubjectCode().trim().toUpperCase()
        );

        subject.setSubjectName(
                subject.getSubjectName().trim()
        );

        subject.setSubjectType(subjectType);

        // New subjects are created as ACTIVE
        subject.setStatus("ACTIVE");

        return subjectRepository.createSubject(subject);
    }

    public List<Subject> getAllActiveSubjects() {
        return subjectRepository.findAllActiveSubjects();
    }
}