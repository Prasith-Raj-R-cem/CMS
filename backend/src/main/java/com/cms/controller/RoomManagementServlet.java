package com.cms.controller;

import java.io.IOException;
import java.util.List;

import com.cms.model.Room;
import com.cms.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
        "/admin/rooms",
        "/admin/rooms/create"
})
public class RoomManagementServlet extends HttpServlet {

    private RoomService roomService;

    @Override
    public void init() {
        roomService = new RoomService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/rooms".equals(path)) {

            List<Room> rooms =
                    roomService.getAllActiveRooms();

            request.setAttribute("rooms", rooms);

            request.getRequestDispatcher("/rooms.jsp")
                    .forward(request, response);

        } else if ("/admin/rooms/create".equals(path)) {

            request.getRequestDispatcher("/create-room.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String path = request.getServletPath();

        if ("/admin/rooms/create".equals(path)) {

            try {

                String roomNumber =
                        request.getParameter("roomNumber");

                String building =
                        request.getParameter("building");

                String roomType =
                        request.getParameter("roomType");

                String capacityParameter =
                        request.getParameter("capacity");

                Integer capacity = null;

                if (capacityParameter != null &&
                        !capacityParameter.isBlank()) {

                    capacity =
                            Integer.parseInt(capacityParameter);
                }

                Room room = new Room();

                room.setRoomNumber(roomNumber);
                room.setBuilding(building);
                room.setRoomType(roomType);
                room.setCapacity(capacity);

                long generatedId =
                        roomService.createRoom(room);

                if (generatedId > 0) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/rooms"
                    );

                } else {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Unable to create room"
                    );
                }

            } catch (NumberFormatException e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid capacity"
                );

            } catch (Exception e) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid room data"
                );
            }
        }
    }
}