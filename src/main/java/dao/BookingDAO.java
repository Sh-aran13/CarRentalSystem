package dao;
import model.Booking;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class BookingDAO {
    public void createBooking(Booking b) throws SQLException {
        String sql = "INSERT INTO bookings (user_id,car_id,start_date,end_date,total_cost) VALUES (?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, b.getUser_id());
            ps.setInt(2, b.getCar_id());
            ps.setDate(3, b.getStart_date());
            ps.setDate(4, b.getEnd_date());
            ps.setDouble(5, b.getTotal_cost());
            ps.executeUpdate();
        }
    }

    public List<Booking> userBookings(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setCar_id(rs.getInt("car_id"));
                b.setStart_date(rs.getDate("start_date"));
                b.setEnd_date(rs.getDate("end_date"));
                b.setTotal_cost(rs.getDouble("total_cost"));
                list.add(b);
            }
        }
        return list;
    }

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY booking_id ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking b = new Booking();
                b.setBooking_id(rs.getInt("booking_id"));
                b.setUser_id(rs.getInt("user_id"));
                b.setCar_id(rs.getInt("car_id"));
                b.setStart_date(rs.getDate("start_date"));
                b.setEnd_date(rs.getDate("end_date"));
                b.setTotal_cost(rs.getDouble("total_cost"));
                list.add(b);
            }
        }
        return list;
    }

    // ---------- NEW CODE BELOW ----------

    /** Returns booking for booking_id or null if not found */
    public Booking findById(long bookingId) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking b = new Booking();
                    b.setBooking_id(rs.getInt("booking_id"));
                    b.setUser_id(rs.getInt("user_id"));
                    b.setCar_id(rs.getInt("car_id"));
                    b.setStart_date(rs.getDate("start_date"));
                    b.setEnd_date(rs.getDate("end_date"));
                    b.setTotal_cost(rs.getDouble("total_cost"));
                    return b;
                }
            }
        }
        return null;
    }
    public Booking getLastBookingForUserAndCar(int userId, int carId) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE user_id = ? AND car_id = ? ORDER BY booking_id DESC LIMIT 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, carId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking b = new Booking();
                    b.setBooking_id(rs.getInt("booking_id"));
                    b.setUser_id(rs.getInt("user_id"));
                    b.setCar_id(rs.getInt("car_id"));
                    b.setStart_date(rs.getDate("start_date"));
                    b.setEnd_date(rs.getDate("end_date"));
                    b.setTotal_cost(rs.getDouble("total_cost"));
                    return b;
                }
            }
        }
        return null;
    }
    public void updatePaymentStatus(long bookingId, String status) throws SQLException {
        String sql = "UPDATE bookings SET payment_status = ? WHERE booking_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, bookingId);
            ps.executeUpdate();
        }
    }

}
