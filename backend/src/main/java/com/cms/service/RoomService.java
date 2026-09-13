package com.cms.service;

import java.util.List;

import com.cms.model.Room;
import com.cms.repository.RoomRepository;

public class RoomService {

    private final RoomRepository roomRepository;

    public RoomService() {
        this.roomRepository = new RoomRepository();
    }

    public long createRoom(Room room) {

        if (room == null) {
            return -1;
        }

        // Room number is required
        if (room.getRoomNumber() == null ||
                room.getRoomNumber().isBlank()) {
            return -1;
        }

        // Room type is required
        if (room.getRoomType() == null ||
                room.getRoomType().isBlank()) {
            return -1;
        }

        // Validate capacity only when provided
        if (room.getCapacity() != null &&
                room.getCapacity() <= 0) {
            return -1;
        }

        // Clean room number
        room.setRoomNumber(
                room.getRoomNumber().trim()
        );

        // Building is optional
        if (room.getBuilding() != null) {
            room.setBuilding(
                    room.getBuilding().trim()
            );
        }

        // Normalize room type
        room.setRoomType(
                room.getRoomType().trim().toUpperCase()
        );

        // New rooms are ACTIVE
        room.setStatus("ACTIVE");

        return roomRepository.createRoom(room);
    }

    public List<Room> getAllActiveRooms() {
        return roomRepository.findAllActiveRooms();
    }
}