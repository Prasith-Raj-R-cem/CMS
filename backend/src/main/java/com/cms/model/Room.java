package com.cms.model;

public class Room {

    private long id;
    private String roomNumber;
    private String building;
    private String roomType;
    private Integer capacity;
    private String status;

    public Room() {
    }

    public Room(long id,
                String roomNumber,
                String building,
                String roomType,
                Integer capacity,
                String status) {

        this.id = id;
        this.roomNumber = roomNumber;
        this.building = building;
        this.roomType = roomType;
        this.capacity = capacity;
        this.status = status;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}