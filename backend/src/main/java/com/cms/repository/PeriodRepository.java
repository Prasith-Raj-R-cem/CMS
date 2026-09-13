package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Period;
import com.cms.util.DatabaseConnection;

public class PeriodRepository {

    public long createPeriod(Period period) {

        String sql = """
                INSERT INTO periods
                (period_number, start_time, end_time, status)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, period.getPeriodNumber());
            statement.setString(2, period.getStartTime());
            statement.setString(3, period.getEndTime());
            statement.setString(4, period.getStatus());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected != 1) {
                return -1;
            }

            try (ResultSet resultSet = statement.getGeneratedKeys()) {

                if (resultSet.next()) {
                    return resultSet.getLong(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    public List<Period> findAllActivePeriods() {

        List<Period> periods = new ArrayList<>();

        String sql = """
                SELECT id,
                       period_number,
                       start_time,
                       end_time,
                       status
                FROM periods
                WHERE status = 'ACTIVE'
                ORDER BY period_number
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Period period = new Period();

                period.setId(
                        resultSet.getLong("id")
                );

                period.setPeriodNumber(
                        resultSet.getInt("period_number")
                );

                period.setStartTime(
                        resultSet.getString("start_time")
                );

                period.setEndTime(
                        resultSet.getString("end_time")
                );

                period.setStatus(
                        resultSet.getString("status")
                );

                periods.add(period);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return periods;
    }
}