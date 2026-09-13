package com.cms.service;

import java.util.List;

import com.cms.model.Semester;
import com.cms.repository.SemesterRepository;

public class SemesterService {

    private final SemesterRepository semesterRepository;

    public SemesterService() {
        this.semesterRepository = new SemesterRepository();
    }

    public long createSemester(Semester semester) {

        if (semester == null) {
            return -1;
        }

        if (semester.getAcademicYearId() <= 0) {
            return -1;
        }

        if (semester.getSemesterNumber() <= 0) {
            return -1;
        }

        if (semester.getSemesterName() == null ||
                semester.getSemesterName().isBlank()) {
            return -1;
        }

        semester.setSemesterName(
                semester.getSemesterName().trim()
        );

        // New semesters are created as ACTIVE
        semester.setStatus("ACTIVE");

        return semesterRepository.createSemester(semester);
    }

    public List<Semester> getAllActiveSemesters() {
        return semesterRepository.findAllActiveSemesters();
    }
}