package dao;

import model.Car;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class CarDAO {

    // Retrieve all cars (Admin View)
    public List<Car> listAll() throws SQLException {
        List<Car> list = new ArrayList<>();
        String sql = "SELECT * FROM cars ORDER BY car_id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Car c = new Car();
                c.setCar_id(rs.getInt("car_id"));
                c.setMake(rs.getString("make"));
                c.setModel(rs.getString("model"));
                c.setYear(rs.getInt("year"));
                c.setDaily_rate(rs.getDouble("daily_rate"));
                c.setStatus(rs.getString("status"));
                list.add(c);
            }
        }
        return list;
    }

    // Retrieve available cars only (Customer view)
    public List<Car> listAvailable() throws SQLException {
        List<Car> list = new ArrayList<>();
        String sql = "SELECT * FROM cars WHERE status = 'Available' ORDER BY car_id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Car c = new Car();
                c.setCar_id(rs.getInt("car_id"));
                c.setMake(rs.getString("make"));
                c.setModel(rs.getString("model"));
                c.setYear(rs.getInt("year"));
                c.setDaily_rate(rs.getDouble("daily_rate"));
                c.setStatus(rs.getString("status"));
                list.add(c);
            }
        }
        return list;
    }

    // Add new car
    public void addCar(Car c) throws SQLException {
        String sql = "INSERT INTO cars (make, model, year, daily_rate, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getMake());
            ps.setString(2, c.getModel());
            ps.setInt(3, c.getYear());
            ps.setDouble(4, c.getDaily_rate());
            ps.setString(5, c.getStatus());
            ps.executeUpdate();
        }
    }

    // Get a single car by ID
    public Car getCarById(int id) throws SQLException {
        String sql = "SELECT * FROM cars WHERE car_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Car c = new Car();
                c.setCar_id(rs.getInt("car_id"));
                c.setMake(rs.getString("make"));
                c.setModel(rs.getString("model"));
                c.setYear(rs.getInt("year"));
                c.setDaily_rate(rs.getDouble("daily_rate"));
                c.setStatus(rs.getString("status"));
                return c;
            }
        }
        return null;
    }

    public void updateCar(Car c) throws SQLException {
        String sql = "UPDATE cars SET make=?, model=?, year=?, daily_rate=?, status=? WHERE car_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getMake());
            ps.setString(2, c.getModel());
            ps.setInt(3, c.getYear());
            ps.setDouble(4, c.getDaily_rate());
            ps.setString(5, c.getStatus());
            ps.setInt(6, c.getCar_id());
            ps.executeUpdate();
        }
    }
    // Update car status (used during booking)
    public void updateStatus(int carId, String status) throws SQLException {
        String sql = "UPDATE cars SET status = ? WHERE car_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, carId);
            ps.executeUpdate();
        }
    }

    // Delete a car by ID
    public void deleteCar(int carId) throws SQLException {
        String sql = "DELETE FROM cars WHERE car_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, carId);
            ps.executeUpdate();
        }
    }
}
