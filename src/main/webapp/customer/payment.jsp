<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.nio.file.*, model.Booking" %>
<%
Booking booking = (Booking) request.getAttribute("booking");
String qrPath = (String) request.getAttribute("qrPath");
String upiQR = (String) request.getAttribute("upiQR");

String base64 = "";
if (qrPath != null && new File(qrPath).exists()) {
    base64 = java.util.Base64.getEncoder().encodeToString(Files.readAllBytes(new File(qrPath).toPath()));
}
%>
<html>
<head>
<title>Complete Your Payment</title>
<style>
* {margin:0; padding:0; box-sizing:border-box;}
body {
  min-height: 100vh; font-family: 'Segoe UI', Arial, sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 25%, #f093fb 50%, #4facfe 75%, #00f2fe 100%);
  background-size: 400% 400%;
  animation: gradientShift 18s ease infinite;
  display: flex; justify-content: center; align-items: center;
  position: relative; overflow: hidden;
}
@keyframes gradientShift {
  0%   { background-position: 0% 50%; }
  50%  { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}
.particle {
  position: fixed; border-radius: 50%;
  background: rgba(255,255,255,0.15); pointer-events: none;
  animation: particleFloat 20s infinite ease-in-out;
}
.particle.p1 { width:80px; height:80px; left:10%; top:20%; animation-delay:0s; }
.particle.p2 { width:60px; height:60px; right:15%; top:30%; animation-delay:-5s; }
.particle.p3 { width:100px; height:100px; left:20%; bottom:15%; animation-delay:-10s; }
.particle.p4 { width:50px; height:50px; right:25%; bottom:25%; animation-delay:-15s; }
.particle.p5 { width:70px; height:70px; left:50%; top:10%; animation-delay:-8s; }
@keyframes particleFloat {
  0%, 100% { transform: translateY(0) translateX(0) scale(1); opacity:0.15; }
  25% { transform: translateY(-30px) translateX(20px) scale(1.1); opacity:0.25; }
  50% { transform: translateY(-50px) translateX(-15px) scale(0.9); opacity:0.2; }
  75% { transform: translateY(-20px) translateX(30px) scale(1.05); opacity:0.18; }
}
.pay-card {
  background: rgba(255,255,255,0.12); border-radius: 32px;
  max-width: 420px; width: 95vw; padding: 48px 32px 38px;
  border: 2px solid rgba(255,255,255,0.25);
  backdrop-filter: blur(20px) saturate(180%);
  box-shadow: 0 8px 32px rgba(31,38,135,0.37), 0 20px 60px rgba(102,126,234,0.4);
  position: relative; z-index: 10;
  animation: cardEntrance 0.8s cubic-bezier(0.34, 1.56, 0.64, 1);
  transition: transform 0.3s ease;
}
@keyframes cardEntrance {
  0% { opacity:0; transform: translateY(50px) scale(0.9); }
  100% { opacity:1; transform: translateY(0) scale(1); }
}
h2 {
  text-align:center; margin-bottom:36px; font-size:2.3rem;
  font-weight: 700; letter-spacing:1.5px;
  background: linear-gradient(90deg, #fff 0%, #4facfe 50%, #00f2fe 100%);
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
  animation: titleGlow 3s ease-in-out infinite alternate;
}
@keyframes titleGlow {
  0% { filter: drop-shadow(0 0 10px rgba(79,172,254,0.5)); }
  100% { filter: drop-shadow(0 0 30px rgba(0,242,254,0.8)); }
}
p { font-size: 1.1rem; color: rgba(255,255,255,0.95); margin-bottom: 12px; text-align: center; }
.info-label { color:#4facfe; font-weight:600; text-shadow: 0 0 10px rgba(79,172,254,0.5); }
.qr-container { text-align: center; margin: 28px 0; }
.pay-qr {
  border-radius: 20px; padding: 15px; background: white;
  box-shadow: 0 0 40px rgba(79,172,254,0.6);
  animation: qrPulse 2s ease-in-out infinite;
}
@keyframes qrPulse {
  0%, 100% { box-shadow: 0 0 40px rgba(79,172,254,0.6); }
  50% { box-shadow: 0 0 80px rgba(79,172,254,0.9); }
}
code {
  display: block; background: rgba(35,32,71,0.8); color: #4facfe;
  font-size:0.9rem; padding:12px 10px; margin-top:15px;
  border-radius:12px; word-break:break-all;
  border: 1px solid rgba(79,172,254,0.3);
}
.btn-secondary {
  display: block; margin: 28px auto 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff; border-radius: 50px; font-size:1.05rem; font-weight:600;
  border:none; padding:14px 40px; text-decoration: none;
  box-shadow: 0 4px 15px rgba(102,126,234,0.5);
  transition: all 0.3s ease;
}
.btn-secondary:hover {
  box-shadow: 0 6px 25px rgba(118,75,162,0.7);
  transform: translateY(-3px) scale(1.05);
}
.overlay {
  position: fixed; top:0; left:0; width:100%; height:100%;
  background: rgba(0,0,0,0.85); display: none; justify-content: center; align-items: center;
  z-index: 1000; animation: fadeIn 0.3s ease;
}
@keyframes fadeIn { from{opacity:0;} to{opacity:1;} }
.success-box, .failed-box {
  background: white; border-radius: 24px; padding: 50px 40px;
  text-align: center; max-width: 400px;
  animation: popIn 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
}
@keyframes popIn {
  0% { transform: scale(0.5); opacity:0; }
  100% { transform: scale(1); opacity:1; }
}
.success-icon { font-size: 80px; animation: checkmark 0.8s ease; }
@keyframes checkmark {
  0% { transform: scale(0) rotate(0deg); }
  50% { transform: scale(1.2) rotate(360deg); }
  100% { transform: scale(1) rotate(360deg); }
}
.success-box h3 { color: #10b981; font-size: 2rem; margin: 20px 0; }
.failed-box h3 { color: #ef4444; font-size: 2rem; margin: 20px 0; }
.success-box p, .failed-box p { color: #666; font-size: 1.1rem; margin-bottom: 30px; }
.overlay-btn {
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  color: white; border: none; border-radius: 50px;
  padding: 14px 40px; font-size: 1rem; font-weight: 600;
  cursor: pointer; transition: all 0.3s ease;
}
.overlay-btn:hover { transform: scale(1.05); box-shadow: 0 6px 20px rgba(16,185,129,0.4); }
.retry-btn { background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%); }
.retry-btn:hover { box-shadow: 0 6px 20px rgba(239,68,68,0.4); }
</style>
</head>
<body>
<div class="particle p1"></div>
<div class="particle p2"></div>
<div class="particle p3"></div>
<div class="particle p4"></div>
<div class="particle p5"></div>

<div class="pay-card">
    <h2>Scan &amp; Pay via UPI</h2>
    <% if (booking == null || base64.isEmpty()) { %>
      <p style="color:#ff6b9d;">Sorry, unable to generate QR/payment details.</p>
    <% } else { %>
      <p><span class="info-label">Booking ID:</span> <b><%= booking.getBooking_id() %></b></p>
      <p><span class="info-label">Amount:</span> <b>₹<%= booking.getTotal_cost() %></b></p>
      
      <div class="qr-container">
        <img class="pay-qr" src="data:image/png;base64,<%= base64 %>"
            width="260" height="260" alt="UPI QR Code">
      </div>
      
      <p style="margin-top:15px;">Scan with any <b>UPI app</b><br>(Google Pay, PhonePe, Paytm, etc)</p>
      <code><%= upiQR %></code>
      
      <p style="margin-top:20px; font-size:0.95rem; color:rgba(255,255,255,0.7);">
        ⏳ Checking payment status automatically...
      </p>
    <% } %>
    <a href="<%=request.getContextPath()%>/customer/myBookings.jsp" class="btn-secondary">View My Bookings</a>
</div>

<div class="overlay" id="successOverlay">
  <div class="success-box">
    <div class="success-icon">✅</div>
    <h3>Payment Successful!</h3>
    <p>Your booking has been confirmed.<br>Booking ID: <strong id="successBookingId"></strong></p>
    <button class="overlay-btn" onclick="window.location.href='<%=request.getContextPath()%>/customer/myBookings.jsp'">View My Bookings</button>
  </div>
</div>

<div class="overlay" id="failedOverlay">
  <div class="failed-box">
    <div class="success-icon">❌</div>
    <h3>Payment Failed</h3>
    <p>Your booking is pending payment.<br>Please try again or contact support.</p>
    <button class="overlay-btn retry-btn" onclick="location.reload()">Retry Payment</button>
    <button class="overlay-btn" style="margin-left:10px; background:#6b7280;" onclick="window.location.href='<%=request.getContextPath()%>/customer/myBookings.jsp'">View Bookings</button>
  </div>
</div>

<script>
<% if (booking != null) { %>
const bookingId = <%= booking.getBooking_id() %>;
let checkCount = 0;
const maxChecks = 24;

const statusInterval = setInterval(() => {
  checkCount++;
  
  fetch('<%=request.getContextPath()%>/checkPaymentStatus?bookingId=' + bookingId)
    .then(res => res.json())
    .then(data => {
      if (data.status === 'success') {
        clearInterval(statusInterval);
        showSuccess(bookingId);
      } else if (data.status === 'failed') {
        clearInterval(statusInterval);
        showFailed();
      } else if (checkCount >= maxChecks) {
        clearInterval(statusInterval);
        showFailed();
      }
    })
    .catch(err => console.error('Payment check error:', err));
}, 5000);

function showSuccess(id) {
  document.getElementById('successBookingId').textContent = id;
  document.getElementById('successOverlay').style.display = 'flex';
}

function showFailed() {
  document.getElementById('failedOverlay').style.display = 'flex';
}
<% } %>
</script>
</body>
</html>
