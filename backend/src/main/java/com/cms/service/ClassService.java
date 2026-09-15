package com.cms.service;

import java.util.List;

import com.cms.model.Class;
import com.cms.repository.ClassRepository;

public class ClassService {

    private final ClassRepository classRepository;

    public ClassService() {
        this.classRepository = new ClassRepository();
    }


    // Create class
    public long createClass(Class classData) {

        if (classData == null) {
            return -1;
        }

        if (!isValidClass(classData)) {
            return -1;
        }

        classData.setStatus("ACTIVE");

        return classRepository.createClass(classData);
    }


    // Find class by ID
    public Class findClassById(long id) {

        if (id <= 0) {
            return null;
        }

        return classRepository.findById(id);
    }


    // Get all classes
    public List<Class> getAllClasses() {

        return classRepository.findAllClasses();
    }

    // Get all active classes for dropdown
    public List<Class> getAllActiveClasses() {
    
        return classRepository.findAllActiveClasses();
    }


    // Update class
    public boolean updateClass(Class classData) {

        if (classData == null) {
            return false;
        }

        if (classData.getId() <= 0) {
            return false;
        }

        if (!isValidClass(classData)) {
            return false;
        }

        Class existingClass =
                classRepository.findById(classData.getId());

        if (existingClass == null) {
            return false;
        }

        return classRepository.updateClass(classData);
    }


    // Update class status
    public boolean updateClassStatus(long id, String status) {

        if (id <= 0) {
            return false;
        }

        if (status == null ||
            (!"ACTIVE".equals(status) &&
             !"INACTIVE".equals(status))) {

            return false;
        }

        Class existingClass =
                classRepository.findById(id);

        if (existingClass == null) {
            return false;
        }

        existingClass.setStatus(status);

        return classRepository.updateClass(existingClass);
    }


    // Delete class
    public boolean deleteClass(long id) {

        if (id <= 0) {
            return false;
        }

        Class existingClass =
                classRepository.findById(id);

        if (existingClass == null) {
            return false;
        }

        return classRepository.deleteClass(id);
    }


    // Validate class data
    private boolean isValidClass(Class classData) {

        if (classData.getClassName() == null ||
            classData.getClassName().isBlank()) {

            return false;
        }

        if (classData.getDepartmentId() <= 0) {
            return false;
        }

        if (classData.getSemesterId() <= 0) {
            return false;
        }

        if (classData.getAcademicYearId() <= 0) {
            return false;
        }

        if (classData.getSection() == null ||
            classData.getSection().isBlank()) {

            return false;
        }

        return true;
    }
}