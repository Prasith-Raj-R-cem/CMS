package com.cms.service;

import java.time.LocalTime;
import java.util.List;

import com.cms.model.Period;
import com.cms.repository.PeriodRepository;

public class PeriodService {

    private final PeriodRepository periodRepository;

    public PeriodService() {
        this.periodRepository = new PeriodRepository();
    }

    public long createPeriod(Period period) {

        if (period == null) {
            return -1;
        }

        // Period number is required
        if (period.getPeriodNumber() <= 0) {
            return -1;
        }

        // Start time is required
        if (period.getStartTime() == null ||
                period.getStartTime().isBlank()) {
            return -1;
        }

        // End time is required
        if (period.getEndTime() == null ||
                period.getEndTime().isBlank()) {
            return -1;
        }

        try {

            LocalTime startTime =
                    LocalTime.parse(period.getStartTime());

            LocalTime endTime =
                    LocalTime.parse(period.getEndTime());

            // End time must be after start time
            if (!endTime.isAfter(startTime)) {
                return -1;
            }

        } catch (Exception e) {
            return -1;
        }

        period.setStartTime(
                period.getStartTime().trim()
        );

        period.setEndTime(
                period.getEndTime().trim()
        );

        // New periods are ACTIVE
        period.setStatus("ACTIVE");

        return periodRepository.createPeriod(period);
    }

    public List<Period> getAllActivePeriods() {
        return periodRepository.findAllActivePeriods();
    }
}