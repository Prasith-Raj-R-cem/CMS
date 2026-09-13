package com.cms.service;

import java.time.LocalDateTime;
import java.util.List;

import com.cms.model.Assignment;
import com.cms.repository.AssignmentRepository;

public class AssignmentService {

    private final AssignmentRepository assignmentRepository;

    public AssignmentService() {
        this.assignmentRepository = new AssignmentRepository();
    }


    // =====================================================
    // CREATE ASSIGNMENT
    // =====================================================

    public long createAssignment(Assignment assignment) {

        if (assignment == null) {
            return -1;
        }


        // Title validation

        if (assignment.getTitle() == null
                || assignment.getTitle().isBlank()) {

            return -1;
        }


        // Class validation

        if (assignment.getClassId() <= 0) {
            return -1;
        }


        // Subject validation

        if (assignment.getSubjectId() <= 0) {
            return -1;
        }


        // Faculty validation

        if (assignment.getFacultyId() <= 0) {
            return -1;
        }


        // Deadline validation

        if (assignment.getDeadline() == null
                || assignment.getDeadline().isBlank()) {

            return -1;
        }


        LocalDateTime deadline;

        try {

            deadline =
                    LocalDateTime.parse(
                            assignment.getDeadline()
                    );

        } catch (Exception e) {

            return -1;
        }


        // Deadline must be in the future

        if (!deadline.isAfter(LocalDateTime.now())) {
            return -1;
        }


        // Clean title

        assignment.setTitle(
                assignment.getTitle().trim()
        );


        // Clean description

        if (assignment.getDescription() != null) {

            assignment.setDescription(
                    assignment.getDescription().trim()
            );
        }


        // Every newly created assignment is ACTIVE

        assignment.setStatus("ACTIVE");


        return assignmentRepository.createAssignment(
                assignment
        );
    }


    // =====================================================
    // FIND ASSIGNMENT BY ID
    // =====================================================

    public Assignment findById(long id) {

        if (id <= 0) {
            return null;
        }

        return assignmentRepository.findById(id);
    }


    // =====================================================
    // GET ASSIGNMENTS FOR CLASS
    // =====================================================

    public List<Assignment> getAssignmentsByClass(long classId) {

        if (classId <= 0) {
            return List.of();
        }

        return assignmentRepository.findAssignmentsByClass(
                classId
        );
    }
}