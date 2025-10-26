<%@ page import="model.Car" %>
<%
Car car = (Car) request.getAttribute("car");
if (car == null) {
    out.println("<h2 style='color:red'>No car data found for editing. Please check database and servlet.</h2>");
    return;
}
%>
<html>
<head>
<title>Edit Car</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<style>
body {
  margin: 0; padding: 0; min-height: 100vh;
  font-family: 'Segoe UI', Arial, sans-serif;
  background: linear-gradient(130deg,#232047 0%,#3846f2 35%,#09ffd1 85%,#18122b 100%);
  background-size: 250% 250%;
  animation: darkAnimBG 18s ease-in-out infinite alternate;
  display: flex; justify-content: center; align-items: center;
  position: relative; overflow: hidden;
}
@keyframes darkAnimBG {
  0%   {background-position: 0% 90%;}
  30%  {background-position: 80% 25%;}
  55%  {background-position: 80% 80%;}
  100% {background-position: 0% 90%;}
}
/* Neon blobs */
.neon-blob {
  position: fixed; border-radius: 50%; pointer-events: none;
  filter: blur(48px); opacity: 0.12; z-index: 0;
  animation: neonMove 17s ease-in-out infinite alternate;
}
.neon-blob.one   { width:33vw; height:30vw; left:-14vw; top:6vh; background:#3846f2; animation-delay: 0s;}
.neon-blob.two   { width:23vw; height:23vw; right:-7vw; top:17vh; background:#09ffd1; animation-delay: -6s;}
.neon-blob.three { width:18vw; height:16vw; left:22vw; bottom:-9vw; background:#232047; animation-delay: -12s;}
.neon-blob.four  { width:14vw; height:17vw; right:19vw; bottom:2vh; background:#00ffaa; animation-delay: -18s;}
@keyframes neonMove {
  0%   {transform: scale(1) translateY(0);}
  66%  {transform: scale(1.13) translateY(-30px);}
  100% {transform: scale(.97) translateY(19px);}
}
/* Card */
.dark-card {
  background: rgba(32,38,54, 0.93);
  border-radius: 22px;
  width: 370px;
  max-width: 96vw;
  margin: 0 auto;
  box-shadow:
    0 13px 38px #3846f2ad,
    0 2px 14px #09ffd142,
    0 0 0 2px #09ffd1 inset;
  padding: 44px 32px 32px 32px;
  border: 2.5px solid #3846f2bb;
  backdrop-filter: blur(9px);
  position: relative;
  transition: box-shadow 0.19s, border-color 0.16s;
  animation: cardFade 1.32s cubic-bezier(.62,.01,.31,1.13);
}
@media (max-width:540px){.dark-card{width:99vw; padding:16px 2vw 14px;}}
@keyframes cardFade {
  from { opacity:0; transform:translateY(40px) scale(.97);}
  to   { opacity:1; transform:translateY(0) scale(1);}
}
.dark-card:before {
  content:"";
  position:absolute; left:1%; top:2%; right:1%; bottom:2%;
  border-radius:22px;
  z-index:-1;
  background: linear-gradient(120deg,#3846f2 8%,#00ffaa 92%);
  opacity:.16; filter: blur(12px);
}
h2 {
  text-align:center;
  margin-bottom:42px;
  font-size:2.25rem;
  color:#09ffd1;
  letter-spacing:2.7px;
  text-shadow:0 0 17px #3846f2ba,0 2px 12px #18122b;
  font-weight: 700;
  animation: headerPulse 2s ease-in-out infinite alternate;
}
@keyframes headerPulse {
  0%{text-shadow:0 0 8px #3846f2a0,0 2px 19px #09ffd1;}
  100%{text-shadow:0 0 24px #09ffd1,0 2px 22px #3846f2;}
}
label {
  font-weight: 500; color: #09ffd1; letter-spacing: .7px;
  margin-bottom: 7px; display: inline-block;
}
.form-control, .form-select {
  border-radius: 13px; border: 2px solid #3846f262; background: rgba(44,49,68,0.98);
  color: #eafdff; transition: border-color 0.17s, box-shadow 0.19s;
}
.form-control:focus, .form-select:focus {
  border-color: #09ffd1; box-shadow: 0 0 14px #09ffd162;
}
/* Button group: center buttons side by side */
.button-group-center {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 18px;
  margin-top: 28px;
  margin-bottom: 0;
  width: 100%;
}
.btn-success, .btn-secondary {
  min-width: 110px;
  font-size: 1rem;
  padding: 10px 0;
}
.btn-success {
  background: linear-gradient(90deg,#3846f2 15%,#09ffd1 98%);
  border-radius: 9px; border: none; font-weight: 600; letter-spacing: .07em;
  box-shadow: 0 2px 12px #3846f282;
  transition: background 0.15s,box-shadow .19s;
}
.btn-success:hover {
  background: linear-gradient(90deg,#09ffd1 24%,#3846f2 98%);
  color: #fff; box-shadow: 0 5px 19px #3846f2ba; transform: scale(1.03);
}
.btn-secondary {
  border-radius: 9px; font-weight: 500; box-shadow: 0 2px 12px #3846f2ba;
  background: linear-gradient(90deg,#3846f2 9%,#232047 93%);
  border: none; color: #fff;
  transition: background 0.15s, box-shadow 0.15s;
}
.btn-secondary:hover {
  color: #3846f2; background: linear-gradient(90deg,#09ffd1 66%,#3846f2 99%);
  box-shadow: 0 6px 19px #09ffd190;
}
/* Stacked on small screens */
@media (max-width:480px){
  .button-group-center {flex-direction:column; gap:14px;}
  .dark-card {padding:12px 2vw 8px;}
}
</style>
</head>
<body>
<div class="neon-blob one"></div>
<div class="neon-blob two"></div>
<div class="neon-blob three"></div>
<div class="neon-blob four"></div>
<div class="dark-card">
    <h2>Edit Car Details</h2>
    <form action="<%= request.getContextPath() %>/adminCars" method="post">
        <input type="hidden" name="car_id" value="<%= car.getCar_id() %>" />

        <div class="mb-3">
            <label>Make</label>
            <input type="text" name="make" class="form-control"
                   value="<%= car.getMake() != null ? car.getMake() : "" %>" required>
        </div>

        <div class="mb-3">
            <label>Model</label>
            <input type="text" name="model" class="form-control"
                   value="<%= car.getModel() != null ? car.getModel() : "" %>" required>
        </div>

        <div class="mb-3">
            <label>Year</label>
            <input type="number" name="year" class="form-control" value="<%= car.getYear() %>" required>
        </div>

        <div class="mb-3">
            <label>Daily Rate</label>
            <input type="number" name="rate" step="0.01" class="form-control" value="<%= car.getDaily_rate() %>" required>
        </div>

        <div class="mb-3">
            <label>Status</label>
            <select name="status" class="form-select" required>
                <option value="Available" <%= "Available".equals(car.getStatus()) ? "selected" : "" %>>Available</option>
                <option value="Rented" <%= "Rented".equals(car.getStatus()) ? "selected" : "" %>>Rented</option>
            </select>
        </div>
        <div class="button-group-center">
          <button type="submit" class="btn btn-success">Update Car</button>
          <a href="<%= request.getContextPath() %>/adminCars" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>
