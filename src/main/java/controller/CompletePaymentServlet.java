package controller;

import dao.BookingDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class CompletePaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String status = request.getParameter("status"); // "success" or "failed"
        String method = request.getParameter("method"); // "UPI" or "NetBanking"

        try {
            if (bookingId != null && status != null) {
                new BookingDAO().updatePaymentStatus(Long.parseLong(bookingId), status);
                request.setAttribute("status", status);
                request.setAttribute("method", method);
                request.getRequestDispatcher("/customer/paymentResult.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/payment.jsp?error=missing");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer/payment.jsp?error=system");
        }
    }
}
