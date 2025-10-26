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
html, body {
  height: 100%; margin: 0; padding: 0; width: 100vw;
  overflow-x: hidden;
}
body {
  min-height: 100vh;
  width: 100vw;
  font-family: 'Segoe UI', Arial, sans-serif;
  background: radial-gradient(circle at 50% 20%, #4facfe 20%, #18122b 65%, #4facfe 100%);
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
}
.sparkle {
  position: fixed;
  width: 8px; height: 8px;
  border-radius: 50%;
  background: linear-gradient(135deg,#fff 70%,#09ffd1 100%);
  opacity: 0.12;
  pointer-events: none;
  animation: sparkleLoop 6s infinite alternate;
  z-index: 1;
}
.sparkle.s1 { top:12vh; left:20vw; animation-delay:0s;}
.sparkle.s2 { top:7vh; left:60vw; animation-delay:2s;}
.sparkle.s3 { top:50vh; left:89vw; animation-delay:3s;}
.sparkle.s4 { top:80vh; left:80vw; animation-delay:4.5s;}
.sparkle.s5 { top:82vh; left:17vw; animation-delay:.8s;}
.sparkle.s6 { top:32vh; left:49vw; animation-delay:2.5s;}
@keyframes sparkleLoop {
  0%   { transform: scale(.5);}
  20%  { opacity:.22;}
  54%  { opacity:.29;}
  100% { transform: scale(1.7); opacity:.08;}
}
.pay-wrapper {
  width: 100vw; height: 100vh;
  display:flex; align-items:center; justify-content:center;
}
.pay-card {
  background: rgba(255,255,255,0.17);
  border-radius: 32px;
  width: 420px; max-width:98vw;
  box-shadow: 0 4px 44px #18122baa, 0 2px 22px #3846f288, 0 2px 8px #09ffd1bb;
  border: 2px solid #23204733;
  padding: 40px 32px 32px;
  position: relative;
  overflow: hidden;
  min-height: 520px;
  display: flex; flex-direction:column; align-items:center;
  justify-content:center;
  top: 0;
  animation: payFadein 1.1s;
}
@keyframes payFadein { from {opacity:0; transform:scale(1.07);} to {opacity:1;transform:scale(1);} }

h2 {
  margin-bottom: 16px;
  font-size: 2.1rem;
  font-weight: bold;
  background: linear-gradient(90deg, #fff 5%, #4facfe 65%, #00f2fe 98%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-align: center;
  letter-spacing: 2px;
  filter: drop-shadow(0 0 8px #09ffd188);
  animation: popTitle 2s infinite alternate;
}
@keyframes popTitle { 0%{letter-spacing:2px;} 100%{letter-spacing:3.5px;} }
.pay-details {
  width:100%; text-align:center; color:#09ffd1; font-size:1.12rem;
  margin-bottom: 4px; font-weight: 600; letter-spacing:.8px;
}
.info-label { color:#3846f2; font-weight:700;}
.qr-container {
  display:flex; flex-direction:column; align-items:center; margin:15px 0 12px 0;
}
.pay-qr {
  border-radius: 20px; padding: 12px; background: white;
  box-shadow: 0 0 28px #4facfea6,0 0 8px #09ffd1c3;
  animation: payGlow 2.8s infinite alternate;
  margin-bottom: 8px;
}
@keyframes payGlow { 0%{box-shadow:0 0 24px #4facfe6a;} 100%{box-shadow:0 0 54px #09ffd1;}}
.payment-tip {
  color: #fff;
  font-size: 1rem;
  margin-bottom:5px;
  font-weight:500;
  letter-spacing: .2px;
  opacity:.93;
}
code {
  display: block;
  background: rgba(35,32,71,0.78);
  color: #09ffd1; font-size:.95rem; padding:8px 10px;
  margin:7px 0 11px 0;
  border-radius: 13px;
  word-break: break-all;
  box-shadow: 0 0 7px #3846f288;
  font-weight:500;
}
.form-row {
  display: flex; justify-content: center; align-items: center;
  gap: 18px; margin-top:18px; width: 100%;
}
.pay-form label {
  color: #21284c; font-weight: 700; font-size:1.05rem; margin-bottom:6px;
  margin-top:0px; display:block;text-align:left;padding-left:3px;
}
.form-label-col {
  width:49%; text-align:left;
}
.pay-form select {
  width: 100%; padding: 10px 8px; border-radius: 14px; border: none;
  background: #232047; color:#fff; font-size:1.1rem;
  box-shadow: 0 1px 8px #3846f230;
  transition: border .18s, outline .18s;
}
.pay-form select:focus, .pay-form select:hover {
  outline:2px solid #09ffd1; border: 1.6px solid #4facfe; box-shadow: 0 0 7px #09ffd188;
}
.button-row {
  display:flex;
  gap: 16px; width:100%; margin-top:15px; justify-content:center;
}
.pay-form button {
  width: 50%;
  background: linear-gradient(90deg, #07fcef 0%, #3846f2 100%);
  color: #fff;
  font-weight:700; padding:14px 0; border-radius:14px; border:none;
  font-size:1.13rem; letter-spacing:.7px; cursor:pointer;
  box-shadow: 0 2px 15px #3846f244;
  transition: background .19s, transform .18s;
}
.pay-form button:hover { background: linear-gradient(90deg, #3846f2 0%, #09ffd1 90%); transform: scale(1.045);}
.btn-secondary {
  display: block; background: linear-gradient(90deg,#35323d 20%,#09ffd1 90%);
  color: #fff; border: none; border-radius: 12px; padding: 13px 35px;
  font-size: 1.13rem; margin: 26px auto 0 auto; text-align:center; text-decoration:none;
  font-weight:500; box-shadow: 0 1px 22px #09ffd188; position: relative;
  animation: fadeIn 1.45s; transition:all .17s;
}
.btn-secondary:hover { background: linear-gradient(90deg,#3846f2 28%,#00f2fe 89%);transform:scale(1.045);}
@media (max-width:600px){
  .pay-card{padding:12px 2vw 20px;min-height: unset;}
  .form-row{flex-direction:column; gap:10px;}
  .button-row{flex-direction:column; gap:10px;}
  .pay-form button{width:100%;}
}
</style>
</head>
<body>
<div class="sparkle s1"></div>
<div class="sparkle s2"></div>
<div class="sparkle s3"></div>
<div class="sparkle s4"></div>
<div class="sparkle s5"></div>
<div class="sparkle s6"></div>
<div class="pay-wrapper">
  <div class="pay-card">
    <h2>Complete Your Payment</h2>
    <% if (booking == null || base64.isEmpty()) { %>
      <p style="color:#ff6b9d; text-align:center;font-weight:bold;">Sorry, unable to generate QR/payment details.</p>
    <% } else { %>
      <div class="pay-details">
        <span class="info-label">Booking ID:</span> <%= booking.getBooking_id() %>
        &nbsp;&nbsp;
        <span class="info-label">Amount:</span> ₹<%= booking.getTotal_cost() %>
      </div>
      <div class="qr-container">
        <img class="pay-qr" src="data:image/png;base64,<%= base64 %>"
             width="180" height="180" alt="UPI QR Code">
        <div class="payment-tip">
          Scan QR with any <b>UPI app</b> (Google Pay, PhonePe, Paytm, etc.) or use the options below:
        </div>
      </div>
      <code><%= upiQR %></code>
      <form class="pay-form" method="post" action="<%=request.getContextPath()%>/completePayment">
        <div class="form-row">
          <div class="form-label-col">
            <label for="method">Payment Type</label>
            <select id="method" name="method" required>
              <option value="" disabled selected>Select</option>
              <option value="UPI">UPI</option>
              <option value="NetBanking">Net Banking</option>
            </select>
          </div>
          <div class="form-label-col">
            <label for="status">Payment Result</label>
            <select id="status" name="status" required>
              <option value="" disabled selected>Select</option>
              <option value="success">I have paid (Success)</option>
              <option value="failed">Payment Failed</option>
            </select>
          </div>
        </div>
        <div class="button-row">
          <button type="submit">Submit Payment</button>
          <button type="reset" style="background:linear-gradient(90deg,#3846f2 0%, #f093fb 100%);">Reset</button>
        </div>
        <input type="hidden" name="bookingId" value="<%= booking.getBooking_id() %>"/>
      </form>
      <a href="<%=request.getContextPath()%>/customer/myBookings.jsp" class="btn-secondary" style="margin-top:24px;">View My Bookings</a>
    <% } %>
  </div>
</div>
</body>
</html>
