package controller;
import dao.BookingDAO;
import model.Booking;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AdminBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            BookingDAO dao = new BookingDAO();
            List<Booking> bookings = dao.getAllBookings(); // method shown below
            req.setAttribute("bookings", bookings);
            req.getRequestDispatcher("/admin/bookings.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("<h2 style='color:red'>Internal error: " + e.getMessage() + "</h2>");
        }
    }
}
