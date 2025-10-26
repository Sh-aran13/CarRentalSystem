<%@ page import="java.util.*,dao.CarDAO,model.Car,model.User" %>
<%
CarDAO dao = new CarDAO();
List<Car> cars = dao.listAvailable();  // All cars marked 'Available' by admin
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>
<html>
<head>
<title>Available Cars</title>
<style>
body {
  margin: 0; padding: 0;
  min-height: 100vh;
  font-family: 'Segoe UI', Arial, sans-serif;
  color: #fff;
  background: linear-gradient(132deg, #38e2ff 0%, #37fa93 40%, #fafe4a 75%, #ffb761 90%, #ff4c91 100%);
  background-size: 350% 350%;
  animation: tropicBG 20s cubic-bezier(.71,0,.32,1) infinite alternate;
  display: flex; flex-direction: column; align-items: center; justify-content: flex-start;
  overflow-x: hidden; position: relative;
}
@keyframes tropicBG {
  0%   { background-position: 0% 100%; }
  38%  { background-position: 70% 30%; }
  59%  { background-position: 100% 0%; }
  100% { background-position: 0% 100%; }
}
/* Floating blobs for depth */
.bg-blob {
  position: fixed;
  border-radius: 50%;
  pointer-events: none;
  z-index: 0;
  filter: blur(48px);
  opacity: 0.14;
  animation: blobFloat 22s ease-in-out infinite alternate;
}
.bg-blob.one { width:29vw;height:31vw;left:-12vw;top:6vh;background:#38e2ff; animation-delay:0s;}
.bg-blob.two { width:19vw;height:23vw;right:-8vw;top:13vh;background:#fafe4a;animation-delay:-5s;}
.bg-blob.three { width:11vw;height:13vw;left:50vw;bottom:-5vw;background:#ffb761;animation-delay:-9s;}
.bg-blob.four { width:19vw;height:15vw;right:13vw;bottom:2vw;background:#ff4c91;animation-delay:-11s;}
@keyframes blobFloat { 0%{transform:scale(1);}  60%{transform:scale(1.1)translateY(-19px);} 100%{transform:scale(.9)translateY(9px);}}
h2 {
  margin: 62px 0 32px 0;
  text-align: center; font-size: 2.3rem;
  font-weight: bold; letter-spacing: 2.3px;
  color: #21284c;
  text-shadow: 0 0 24px #fafe4aa9, 0 2px 24px #38e2ffa0;
  animation: h2Glow 2.2s infinite alternate;
}
@keyframes h2Glow {
  0%   {text-shadow:0 0 18px #37fa93,0 0 25px #38e2ff;}
  70%  {text-shadow:0 0 41px #fafe4a,0 0 61px #ffb761;}
  100% {text-shadow:0 0 32px #fafe4a,0 0 43px #ffb761;}
}
/* Card glass table effect */
.table-glass {
  width: 98vw; max-width: 940px;
  border-collapse: collapse;
  margin-bottom: 32px;
  border-radius: 22px;
  overflow: hidden;
  backdrop-filter: blur(6px);
  background: rgba(34,49,73,0.92);
  box-shadow: 0 6px 34px #ff4c9175, 0 2px 8px #38e2ff44;
  animation: tableFade 1.14s cubic-bezier(.45,.19,.31,1.14);
}
@keyframes tableFade { from{opacity:0;transform:scale(.98);} to{opacity:1;transform:scale(1);} }
thead {
  background: linear-gradient(90deg, #38e2ff 33%, #37fa93 68%, #fafe4a 99%);
}
thead th {
  color: #22284c; text-transform: uppercase; letter-spacing: 0.8px;
  padding: 16px 2px; font-size: 1.08rem; border-bottom: 2px solid #fafe4a;
}
tbody tr { transition: box-shadow .30s, transform .22s; }
tbody tr:hover {
  background: linear-gradient(90deg,#b7f2ff 0%,#38e2ff 55%,#fafe4a 95%);
  color: #232047; transform: scale(1.016);
  box-shadow: 0 0 25px #38e2ffc0;
}
tbody td {
  padding: 13px 11px; text-align: center; font-size: 1.08rem;
  border-bottom: 1px solid #cccccc1a; color: #eafdff; font-weight: 500;
  transition: color 0.21s;
}
tbody tr:hover td { color: #22284c; }
form {
  display: flex; flex-direction: column; gap: 8px;
  align-items: stretch; background: rgba(19,30,52,0.90);
  padding: 15px 7px; border-radius: 12px; animation: inForm 1.27s cubic-bezier(.43,.19,.31,1.14);
}
@keyframes inForm { from{opacity:0;transform:translateY(22px);} to{opacity:1;transform:translateY(0);} }
input[type="date"] {
  background: #232047; color: #fff; border: 1.6px solid #37fa93;
  border-radius: 8px; padding: 8px; font-size: 1rem;
  transition: border-color 0.17s, box-shadow 0.15s;
}
input[type="date"]:focus {
  border-color: #38e2ff;
  box-shadow: 0 0 8px #38e2ffcc;
}
/* ANIMATED BUTTON */
.book-btn {
  background: linear-gradient(90deg,#38e2ff 4%,#37fa93 70%,#ff4c91 100%);
  color: #fff; border: none; border-radius: 48px;
  font-weight: bold; padding: 10px 38px; margin-top: 2px;
  box-shadow: 0 2px 18px #38e2ff80;
  font-size: 1.12rem; position: relative; overflow: hidden; cursor: pointer;
  transition: background 0.16s, color .16s, transform .13s, box-shadow .16s;
  animation: bookPulse 1.65s infinite alternate;
}
@keyframes bookPulse {
  0%   {filter:brightness(.97) saturate(1); transform:scale(1);}
  80%  {filter:brightness(1.11) saturate(1.08); transform:scale(1.045);}
  100% {filter:brightness(.97) saturate(1); transform:scale(1);}
}
.book-btn::after {
  content: '';
  position: absolute; left: -38%; top: 0; width: 80%; height: 100%;
  background: linear-gradient(93deg,rgba(255,255,255,0.18),rgba(255,255,255,0));
  opacity: .34;
  transform: skewX(-19deg); pointer-events:none;
  animation: btnShine 2.5s linear infinite;
}
@keyframes btnShine {
  0% {left: -60%;}
  85%{left: 120%;}
  100%{left: 90%;}
}
.book-btn:hover {
  background: linear-gradient(90deg,#fafe4a 0%,#37fa93 100%);
  color: #232047; box-shadow: 0 9px 28px #fafe4acc;
  transform: scale(1.07);
}
.btn-info {
  display: block; background: linear-gradient(90deg,#35323d 8%,#ff4c91 100%);
  color: #fff; border: none; border-radius: 8px; padding: 12px 36px;
  font-size: 1.08rem; margin: 23px auto 0 auto; transition: background 0.21s, transform 0.18s, box-shadow 0.17s;
  text-decoration: none; box-shadow: 0 1px 18px #ff4c9180; position: relative;
  animation: btnReveal 1.13s;
}
@keyframes btnReveal {
  from { opacity: 0; transform: scale(.97) translateY(12px);}
  to   { opacity: 1; transform: scale(1) translateY(0);}
}
.btn-info:hover {
  background: linear-gradient(90deg,#37fa93 18%,#ffb761 83%);
  box-shadow: 0 7px 22px #37fa9380;
  transform: translateY(-2px) scale(1.05);
}
@media (min-width: 650px) {
  form {flex-direction: row; align-items: flex-start;}
}
@media (max-width: 680px) {
  .table-glass{max-width:100vw;}
  h2{font-size:1.45rem;}
}
</style>
</head>
<body>
<div class="bg-blob one"></div>
<div class="bg-blob two"></div>
<div class="bg-blob three"></div>
<div class="bg-blob four"></div>

    <h2>Available Cars</h2>
    <table class="table-glass">
        <thead>
            <tr>
                <th>ID</th><th>Make</th><th>Model</th><th>Year</th>
                <th>Daily Rate</th><th>Book</th>
            </tr>
        </thead>
        <tbody>
        <% for(Car c : cars){ %>
        <tr>
            <td><%= c.getCar_id() %></td>
            <td><%= c.getMake() %></td>
            <td><%= c.getModel() %></td>
            <td><%= c.getYear() %></td>
            <td>&#8377;<%= c.getDaily_rate() %></td>
            <td>
                <form action="<%= request.getContextPath() %>/bookCar" method="post">
                    <input type="hidden" name="user_id" value="<%= user.getUser_id() %>">
                    <input type="hidden" name="car_id" value="<%= c.getCar_id() %>">
                    <input type="hidden" name="daily_rate" value="<%= c.getDaily_rate() %>">
                    <input type="date" name="start_date" required>
                    <input type="date" name="end_date" required>
                    <button type="submit" class="book-btn">Book</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="myBookings.jsp" class="btn-info">View My Bookings</a>
</body>
</html>
