package controller;

import dao.BookingDAO;
import model.Booking;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import org.json.JSONObject;

public class CheckPaymentStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String bookingId = request.getParameter("bookingId");
        
        try {
            BookingDAO dao = new BookingDAO();
            Booking booking = dao.findById(Long.parseLong(bookingId));
            
            // Check payment status from database
            String paymentStatus = booking.getPayment_status(); // "pending", "success", "failed"
            
            JSONObject json = new JSONObject();
            json.put("status", paymentStatus != null ? paymentStatus : "pending");
            json.put("bookingId", bookingId);
            
            out.print(json.toString());
        } catch (Exception e) {
            JSONObject json = new JSONObject();
            json.put("status", "error");
            json.put("message", e.getMessage());
            out.print(json.toString());
        }
    }
}
