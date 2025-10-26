<%@ page import="java.util.*,dao.BookingDAO,model.Booking,model.User" %>
<%
User user = (User)session.getAttribute("user");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
BookingDAO dao = new BookingDAO();
List<Booking> bookings = dao.userBookings(user.getUser_id());
%>
<html>
<head>
<title>My Bookings</title>
<style>
body {
  font-family: 'Segoe UI', Arial, sans-serif;
  margin: 0; padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
}
h2 { text-align: center; color: white; margin-bottom: 30px; letter-spacing:1.2px;}
table {
  width: 100%; max-width: 900px; margin: 0 auto;
  background: white; border-radius: 14px;
  box-shadow: 0 8px 32px rgba(0,0,0,0.12);
  border-collapse: collapse; overflow: hidden;
  font-size:1.09rem;
}
thead { background: linear-gradient(135deg, #667eea, #764ba2); }
thead th { color: white; padding: 15px; text-align: left; letter-spacing:.7px;}
tbody td { padding: 12px 10px; border-bottom: 1px solid #ebeafd; }
tbody tr:hover { background: #f7f7ff; }
.status { padding: 5px 13px; border-radius: 20px; font-size: 0.95rem; font-weight: 600; }
.status.pending { background: #fef3c7; color: #92400e; }
.status.success { background: #d1fae5; color: #065f46; }
.status.failed { background: #fee2e2; color: #991b1b; }
@media (max-width:740px){
  table{font-size:.87rem;}
  thead th,tbody td{padding:8px 4px;}
}
</style>
</head>
<body>
<h2>My Bookings</h2>
<table>
<thead>
  <tr>
    <th>Booking ID</th><th>Car ID</th><th>Start Date</th>
    <th>End Date</th><th>Total Cost</th><th>Payment Status</th>
  </tr>
</thead>
<tbody>
<% for(Booking b : bookings) { 
   String statusClass = b.getPayment_status() != null ? b.getPayment_status() : "pending";
%>
  <tr>
    <td><%= b.getBooking_id() %></td>
    <td><%= b.getCar_id() %></td>
    <td><%= b.getStart_date() %></td>
    <td><%= b.getEnd_date() %></td>
    <td>&#8377;<%= b.getTotal_cost() %></td>
    <td><span class="status <%= statusClass %>"><%= statusClass.toUpperCase() %></span></td>
  </tr>
<% } %>
</tbody>
</table>
</body>
</html>
