package controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import dao.BookingDAO;
import model.Booking;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.SQLException;

public class CustomerPaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        if (bookingId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing bookingId");
            return;
        }

        Booking booking = null;
        try {
            booking = new BookingDAO().findById(Long.parseLong(bookingId));
        } catch (SQLException | NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Could not retrieve booking");
            return;
        }
        if (booking == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No booking found");
            return;
        }

        User user = (User) request.getSession().getAttribute("user");
        String customerName = (user != null && user.getName() != null) ? user.getName() : "CarRentalCustomer";

        String upiId = "8074328850@axl"; // Replace with your UPI ID
        double amount = booking.getTotal_cost();
        String upiQR = "upi://pay?pa=" + upiId +
                        "&pn=" + customerName +
                        "&am=" + amount +
                        "&cu=INR" +
                        "&tn=CarRental Booking #" + bookingId;

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        int width = 260, height = 260;
        File tempQr = File.createTempFile("qr_" + bookingId, ".png");
        try {
            var bitMatrix = qrCodeWriter.encode(upiQR, BarcodeFormat.QR_CODE, width, height);
            MatrixToImageWriter.writeToPath(bitMatrix, "PNG", tempQr.toPath());
        } catch (WriterException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to generate QR");
            return;
        }

        request.setAttribute("qrPath", tempQr.getAbsolutePath());
        request.setAttribute("booking", booking);
        request.setAttribute("upiQR", upiQR);
        request.getRequestDispatcher("/customer/payment.jsp").forward(request, response);
    }
}
