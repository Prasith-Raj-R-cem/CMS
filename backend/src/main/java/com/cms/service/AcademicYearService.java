package com.cms.service;

import java.time.LocalDate;
import java.util.List;

import com.cms.model.AcademicYear;
import com.cms.repository.AcademicYearRepository;

public class AcademicYearService {

    private final AcademicYearRepository academicYearRepository;

    public AcademicYearService() {
        this.academicYearRepository =
                new AcademicYearRepository();
    }


    // Create Academic Year
    public long createAcademicYear(
            AcademicYear academicYear) {

        if (academicYear == null) {
            return -1;
        }

        if (academicYear.getYearName() == null ||
            academicYear.getYearName().isBlank()) {

            return -1;
        }

        if (academicYear.getStartDate() == null ||
            academicYear.getStartDate().isBlank()) {

            return -1;
        }

        if (academicYear.getEndDate() == null ||
            academicYear.getEndDate().isBlank()) {

            return -1;
        }


        // Validate date format
        try {

            LocalDate startDate =
                    LocalDate.parse(
                            academicYear.getStartDate());

            LocalDate endDate =
                    LocalDate.parse(
                            academicYear.getEndDate());


            // End date must be after start date
            if (!endDate.isAfter(startDate)) {
                return -1;
            }

        } catch (Exception e) {

            return -1;
        }


        academicYear.setYearName(
                academicYear.getYearName().trim());

        academicYear.setStatus("ACTIVE");


        return academicYearRepository
                .createAcademicYear(academicYear);
    }


    // Get all active Academic Years
    public List<AcademicYear>
    getAllActiveAcademicYears() {

        return academicYearRepository
                .findAllActiveAcademicYears();
    }
}