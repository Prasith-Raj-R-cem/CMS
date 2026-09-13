package com.cms.service;

import java.util.List;

import com.cms.model.Timetable;
import com.cms.model.TimetableDetails;
import com.cms.repository.TimetableRepository;

public class TimetableService {

    private final TimetableRepository timetableRepository;

    public TimetableService() {
        this.timetableRepository = new TimetableRepository();
    }

    public long createTimetable(Timetable timetable) {

        if (timetable == null) {
            return -1;
        }

        if (!isValidTimetable(timetable)) {
            return -1;
        }

        timetable.setStatus("ACTIVE");

        return timetableRepository.createTimetable(timetable);
    }

    public Timetable findTimetableById(long id) {

        if (id <= 0) {
            return null;
        }

        return timetableRepository.findById(id);
    }

    public List<Timetable> getAllTimetables() {

        return timetableRepository.findAllTimetables();
    }

    public boolean updateTimetable(Timetable timetable) {

        if (timetable == null) {
            return false;
        }

        if (timetable.getId() <= 0) {
            return false;
        }

        if (!isValidTimetable(timetable)) {
            return false;
        }

        Timetable existingTimetable =
                timetableRepository.findById(timetable.getId());

        if (existingTimetable == null) {
            return false;
        }

        return timetableRepository.updateTimetable(timetable);
    }

    public boolean deleteTimetable(long id) {

        if (id <= 0) {
            return false;
        }

        Timetable existingTimetable =
                timetableRepository.findById(id);

        if (existingTimetable == null) {
            return false;
        }

        return timetableRepository.deleteTimetable(id);
    }

    private boolean isValidTimetable(Timetable timetable) {

        if (timetable.getClassId() <= 0) {
            return false;
        }

        if (timetable.getSubjectId() <= 0) {
            return false;
        }

        if (timetable.getFacultyId() <= 0) {
            return false;
        }

        if (timetable.getPeriodId() <= 0) {
            return false;
        }

        if (timetable.getAcademicYearId() <= 0) {
            return false;
        }

        if (timetable.getSemesterId() <= 0) {
            return false;
        }

        if (timetable.getDayOfWeek() == null
                || timetable.getDayOfWeek().isBlank()) {
            return false;
        }

        if (!isValidDay(timetable.getDayOfWeek())) {
            return false;
        }

        return true;
    }

    private boolean isValidDay(String dayOfWeek) {

        return "MONDAY".equals(dayOfWeek)
                || "TUESDAY".equals(dayOfWeek)
                || "WEDNESDAY".equals(dayOfWeek)
                || "THURSDAY".equals(dayOfWeek)
                || "FRIDAY".equals(dayOfWeek)
                || "SATURDAY".equals(dayOfWeek)
                || "SUNDAY".equals(dayOfWeek);
    }

    public List<TimetableDetails> getAllTimetableDetails() {

        return timetableRepository.findAllTimetableDetails();
    }
}