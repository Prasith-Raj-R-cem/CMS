package com.cms.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.cms.model.Room;
import com.cms.util.DatabaseConnection;

public class RoomRepository {

    public long createRoom(Room room) {

        String sql = """
                INSERT INTO rooms
                (room_number, building, room_type, capacity, status)
                VALUES (?, ?, ?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(
                             sql,
                             Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, room.getRoomNumber());
            statement.setString(2, room.getBuilding());
            statement.setString(3, room.getRoomType());

            if (room.getCapacity() == null) {
                statement.setNull(4, java.sql.Types.INTEGER);
            } else {
                statement.setInt(4, room.getCapacity());
            }

            statement.setString(5, room.getStatus());

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


    public List<Room> findAllActiveRooms() {

        List<Room> rooms = new ArrayList<>();

        String sql = """
                SELECT id,
                       room_number,
                       building,
                       room_type,
                       capacity,
                       status
                FROM rooms
                WHERE status = 'ACTIVE'
                ORDER BY room_number
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Room room = new Room();

                room.setId(
                        resultSet.getLong("id")
                );

                room.setRoomNumber(
                        resultSet.getString("room_number")
                );

                room.setBuilding(
                        resultSet.getString("building")
                );

                room.setRoomType(
                        resultSet.getString("room_type")
                );

                int capacity =
                        resultSet.getInt("capacity");

                if (resultSet.wasNull()) {
                    room.setCapacity(null);
                } else {
                    room.setCapacity(capacity);
                }

                room.setStatus(
                        resultSet.getString("status")
                );

                rooms.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }
}