package controller;
import dao.BookingDAO;
import dao.CarDAO;
import model.Booking;
import java.io.*;
import java.sql.Date;
import java.time.temporal.ChronoUnit;
import javax.servlet.*;
import javax.servlet.http.*;

public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            int userId = Integer.parseInt(req.getParameter("user_id"));
            int carId = Integer.parseInt(req.getParameter("car_id"));
            Date start = Date.valueOf(req.getParameter("start_date"));
            Date end = Date.valueOf(req.getParameter("end_date"));
            double rate = Double.parseDouble(req.getParameter("daily_rate"));

            long days = ChronoUnit.DAYS.between(start.toLocalDate(), end.toLocalDate()) + 1;
            double total = days * rate;

            Booking b = new Booking();
            b.setUser_id(userId);
            b.setCar_id(carId);
            b.setStart_date(start);
            b.setEnd_date(end);
            b.setTotal_cost(total);

            BookingDAO bookingDao = new BookingDAO();
            bookingDao.createBooking(b);
            new CarDAO().updateStatus(carId, "Rented");

            Booking createdBooking = bookingDao.getLastBookingForUserAndCar(userId, carId);
            res.sendRedirect(req.getContextPath() + "/CustomerPaymentServlet?bookingId=" + createdBooking.getBooking_id());

        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Booking failed! Try again.");
        }
    }
}
