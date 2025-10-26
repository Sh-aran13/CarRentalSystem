<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
String status = (String) request.getAttribute("status");
String method = (String) request.getAttribute("method");
boolean success = "success".equals(status);
%>
<html>
<head>
<title>Payment Status</title>
<style>
html, body {
  width: 100vw; height: 100vh; margin: 0; padding: 0; overflow: hidden;
}
body {
  min-height:100vh; min-width:100vw;
  font-family: 'Segoe UI', 'Montserrat', Arial, sans-serif;
  display:flex; align-items:center; justify-content:center;
  background: linear-gradient(120deg, #13fdb4 12%, #2495ff 55%, #6a23fd 100%);
  background-size: 200% 200%;
  animation: moveBg 6s ease-in-out infinite alternate;
  overflow: hidden;
}
@keyframes moveBg {
  0% {background-position: 0% 55%;}
  100% {background-position: 100% 45%;}
}
.bubble {
  position: absolute; border-radius: 50%; pointer-events:none;
  opacity:.18; filter: blur(25px);
  animation: bobble 12s linear infinite alternate;
}
.b1 { left:8vw; top:10vh; width:150px;height:150px;background:#2495ff;}
.b2 { right:6vw; top:40vh; width:87px;height:87px;background:#13fdb4;animation-delay:-7s;}
.b3 { left:60vw; bottom:9vh; width:90px;height:90px;background:#6a23fd; animation-delay:-3s;}
.b4 { left:30vw; top:70vh; width:65px;height:65px;background:#fff; opacity:0.13; animation-delay:-5s;}
@keyframes bobble {
  from{transform:scale(1);}
  to{transform:scale(.93) translateY(-16px);}
}

.result-card {
  margin:0 auto;
  background: rgba(255,255,255,0.90);
  border-radius:22px;
  padding: 58px 34px 46px;
  box-shadow:0 8px 38px #3846f240, 0 0px 22px #23ffd114, 0 2px 14px #23ffd114;
  min-width:340px; max-width:97vw;
  text-align:center;
  position: relative;
  z-index:3;
  display:flex;flex-direction:column;align-items:center;
  animation: popInCard 1s cubic-bezier(.64,-0.01,.21,1.05);
}
@keyframes popInCard {
  from{opacity:0;transform:scale(.95) translateY(48px);}
  to{opacity:1;transform:scale(1) translateY(0);}
}

.animated-tick, .animated-cross {
  width:72px; height:72px; display:block; margin:0 auto 12px auto;
}

.success-text {
  font-size: 2.1rem;
  font-weight: 700;
  color: #20bf55;
  letter-spacing:.8px;
  margin-bottom:13px;
  font-family: 'Montserrat', 'Segoe UI', Arial, sans-serif;
  animation: popSuccess 1s cubic-bezier(.58,-0.07,.36,1.17);
}
@keyframes popSuccess {
  from{opacity:0;transform:scale(.85);}
  to{opacity:1;transform:scale(1);}
}
.failed-text {
  font-size: 2.1rem;
  font-weight: 700;
  color: #f43f5e;
  letter-spacing:.8px;
  margin-bottom:13px;
  font-family: 'Montserrat', 'Segoe UI', Arial, sans-serif;
  animation: popFail 1s cubic-bezier(.58,-0.07,.36,1.17);
}
@keyframes popFail {
  from{opacity:0;transform:scale(.85);}
  to{opacity:1;transform:scale(1);}
}
.method-info {
  font-size:1.07rem; margin-bottom:24px; color:#1a283a;font-weight:500;
}
.btn-main {
  font-family: 'Montserrat', 'Segoe UI', Arial, sans-serif;
  display:inline-block;
  padding: 14px 42px;
  border: none;
  margin-top:16px;
  border-radius: 13px;
  font-size: 1.11rem;
  font-weight: 700;
  letter-spacing:.3px;
  color: #fff;
  background: linear-gradient(90deg,#23ffd1 10%,#2495ff 95%);
  box-shadow: 0 6px 23px #23ffd126;
  cursor: pointer; text-decoration: none; transition: background .14s, box-shadow .15s, color .15s;
  animation: btnPop 1.2s cubic-bezier(.43,.19,.31,1.22);
}
@keyframes btnPop {from{opacity:0;transform:scale(.92);} to{opacity:1;transform:scale(1);}}
.btn-main:hover, .btn-main:focus {
  background:linear-gradient(90deg,#2495ff 40%,#13fdb4 100%);
  box-shadow:0 7px 22px #2495ff44;
  color:#22264a;
}
@media(max-width:520px){
  .result-card{padding:28px 3vw 30px; min-width:80vw;}
  .success-text,.failed-text{font-size:1.4rem;}
}

/* SVG tick/cross stroke animations */
svg .circle { stroke-dasharray: 151; stroke-dashoffset: 151; animation: drawCircle .63s ease-out forwards;}
svg .tick { stroke-dasharray: 36; stroke-dashoffset: 36; animation: drawTick .35s .55s cubic-bezier(.43,.19,.31,1.22) forwards;}
svg .cross1 { stroke-dasharray: 22; stroke-dashoffset: 22; animation: drawCross 0.23s .48s cubic-bezier(.43,.19,.31,1.22) forwards;}
svg .cross2 { stroke-dasharray: 22; stroke-dashoffset: 22; animation: drawCross 0.23s .65s cubic-bezier(.43,.19,.31,1.22) forwards;}
@keyframes drawCircle {to{ stroke-dashoffset: 0;}}
@keyframes drawTick {to{ stroke-dashoffset: 0;}}
@keyframes drawCross {to{ stroke-dashoffset: 0;}}
</style>
</head>
<body>
<div class="bubble b1"></div>
<div class="bubble b2"></div>
<div class="bubble b3"></div>
<div class="bubble b4"></div>
<div class="result-card">
    <% if(success){ %>
        <svg class="animated-tick" viewBox="0 0 58 58">
          <circle class="circle" cx="29" cy="29" r="24" fill="none" stroke="#20bf55" stroke-width="5"/>
          <polyline class="tick" fill="none" stroke="#20bf55" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" points="17,32 26,39 41,22"/>
        </svg>
        <div class="success-text">Payment Successful!</div>
        <div class="method-info">Your booking is <strong>confirmed</strong>.<br>(Paid via <%= method %>)</div>
    <% } else { %>
        <svg class="animated-cross" viewBox="0 0 58 58">
          <circle class="circle" cx="29" cy="29" r="24" fill="none" stroke="#f43f5e" stroke-width="5"/>
          <line class="cross1" fill="none" stroke="#f43f5e" stroke-width="4" stroke-linecap="round" x1="19" y1="19" x2="39" y2="39"/>
          <line class="cross2" fill="none" stroke="#f43f5e" stroke-width="4" stroke-linecap="round" x1="39" y1="19" x2="19" y2="39"/>
        </svg>
        <div class="failed-text">Payment Failed.</div>
        <div class="method-info">Your booking is <strong>pending</strong>.<br>Please try again or use a different method.</div>
    <% } %>
    <a href="<%=request.getContextPath()%>/customer/myBookings.jsp" class="btn-main">View My Bookings</a>
</div>
</body>
</html>
