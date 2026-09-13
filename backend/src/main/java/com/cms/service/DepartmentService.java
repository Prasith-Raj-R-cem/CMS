package com.cms.service;

import java.util.List;

import com.cms.model.Department;
import com.cms.repository.DepartmentRepository;

public class DepartmentService {

    private final DepartmentRepository departmentRepository;

    public DepartmentService() {
        this.departmentRepository = new DepartmentRepository();
    }

    public long createDepartment(Department department) {

        if (department == null) {
            return -1;
        }

        if (department.getDepartmentCode() == null ||
            department.getDepartmentCode().isBlank()) {
            return -1;
        }

        if (department.getDepartmentName() == null ||
            department.getDepartmentName().isBlank()) {
            return -1;
        }

        department.setDepartmentCode(
                department.getDepartmentCode().trim().toUpperCase());

        department.setDepartmentName(
                department.getDepartmentName().trim());

        department.setStatus("ACTIVE");

        return departmentRepository.createDepartment(department);
    }

    public List<Department> getAllActiveDepartments() {

        return departmentRepository.findAllActiveDepartments();
    }
}