<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Register</title>
<style>
body {
  font-family: 'Segoe UI', Arial, sans-serif;
  margin: 0;
  padding: 0;
  background: #13374f;
  color: #fff;
  min-height: 100vh;
  overflow: hidden;
  position: relative;
}
/* Animated Waves Background */
.bg-waves {
  position: fixed;
  width: 100vw;
  height: 100vh;
  top: 0; left: 0;
  z-index: -2;
  overflow: hidden;
}
.wave {
  position: absolute;
  left: 0;
  width: 200vw;
  height: 260px;
  opacity: 0.32;
  filter: blur(1px);
  animation: waveAction 16s linear infinite alternate;
  background: radial-gradient(circle at 24% 60%, #09ffd1 0 32%, transparent 35%),
              radial-gradient(circle at 85% 40%, #3846f2 0 28%, transparent 36%);
}
.wave.wave2 {
  top: 130px;
  opacity: 0.21;
  animation: waveAction2 22s linear infinite alternate;
  background: radial-gradient(circle at 80% 31%, #1f6dfb 0 25%, transparent 32%),
              radial-gradient(circle at 34% 76%, #11f3ee 0 18%, transparent 24%);
}
.wave.wave3 {
  top: 260px;
  opacity: 0.13;
  animation: waveAction3 28s linear infinite alternate;
  background: radial-gradient(circle at 38% 80%, #fff 0 15%, transparent 27%);
}
@keyframes waveAction {
  from { left: 0; top: 48px; }
  40% { left: -25vw; top: 70px; }
  100% { left: -14vw; top: 32px;}
}
@keyframes waveAction2 {
  from { left: 0; top: 130px;}
  60% { left: -13vw; top: 100px;}
  100% { left: -6vw; top: 170px;}
}
@keyframes waveAction3 {
  from { left: 0; top: 260px;}
  100% { left: -28vw; top: 220px;}
}

/* Subtle Sparkle Overlay */
body::after {
  content: '';
  position: fixed;
  inset: 0;
  z-index: -1;
  pointer-events: none;
  background-image:
    radial-gradient(circle, #17f3ee77 1px, transparent 1px),
    radial-gradient(circle, #1f6dfb88 1.5px, transparent 1px),
    radial-gradient(circle, #09ffd1aa .8px, transparent 1px);
  background-size: 100px 100px, 170px 160px, 190px 180px;
  background-position: 10px 30px, 40px 80px, 180px 160px;
  animation: sparkleMove 18s linear infinite;
}
@keyframes sparkleMove {
  0%    {background-position: 10px 30px, 40px 80px, 180px 160px;}
  100%  {background-position: 80px 90px, 100px 220px, 360px 230px;}
}

/* Centered Card */
.form-card {
  background: rgba(24,44,61,0.965);
  border-radius: 22px;
  box-shadow: 0 8px 40px #09ffd1be, 0 4px 28px #3846f2b6;
  max-width: 380px;
  margin: 60px auto 0 auto;
  padding: 42px 22px 28px;
  animation: cardIn 1.1s cubic-bezier(.68, .03, .18, 1.1);
}
@media (max-width: 480px) {
  .form-card {max-width: 97vw; padding: 12px 2vw 14px;}
}
@keyframes cardIn {
  from { transform: scale(.98) translateY(-48px); opacity: 0;}
  70%  { box-shadow: 0 30px 80px #09ffd120, 0 6px 28px #3846f2bb;}
  to   { transform: scale(1) translateY(0); opacity: 1;}
}

h2 {
  text-align: center;
  margin-bottom: 26px;
  font-size: 2.1rem;
  letter-spacing: 1.5px;
  color: #22ffe2;
  animation: headerGlow 1.8s infinite alternate;
}
@keyframes headerGlow {
  from { text-shadow: 0 0 15px #09ffd1, 0 0 20px #3846f2;}
  to { text-shadow: 0 0 24px #fff, 0 0 34px #3846f2;}
}
/* Floating Label Animation */
.mb-3 {
  position: relative;
  margin-bottom: 1.6rem;
}
.mb-3 label {
  position: absolute;
  left: 14px;
  top: 12px;
  font-size: 1rem;
  color: #9bf7f7;
  pointer-events: none;
  transition: all 0.18s;
  background: transparent;
  z-index: 2;
  padding: 0 4px;
}
input:focus + label,
input:not(:placeholder-shown) + label,
select:focus + label,
select:not(:placeholder-shown) + label {
  top: -10px; left: 8px;
  font-size: .92rem; color: #32ffd7;
  background: linear-gradient(90deg, #0934ff18 33%, transparent 90%);
  letter-spacing: 0.5px;
  font-weight: 600;
}
input, select {
  background: rgba(19, 30, 52, 0.99);
  color: #fff;
  border: 1.6px solid #09ffd1;
  border-radius: 8px;
  padding: 14px 13px 12px 13px;
  width: 100%;
  font-size: .99rem;
  outline: none;
  box-sizing: border-box;
  margin-top: 0.7rem;
  transition: border-color 0.19s, box-shadow 0.18s;
  animation: inputPop 1.19s cubic-bezier(.42,.19,.31,1.22);
}
@keyframes inputPop {
  from {opacity: 0; transform: scale(.98);}
  to   {opacity: 1; transform: scale(1);}
}
input:focus, select:focus {
  border-color: #3846f2;
  box-shadow: 0 0 7px #22ffe2, 0 0 12px #3846f2;
}

button[type="submit"] {
  width: 100%;
  background: linear-gradient(90deg,#3846f2 40%,#09ffd1 100%);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 14px 0;
  font-weight: 600;
  margin-top: 8px;
  font-size: 1.08rem;
  box-shadow: 0 2px 16px #09ffd150, 0 0 0 #09ffd1;
  transition: background 0.22s, transform 0.22s, box-shadow 0.22s;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  animation: fadeBtnIn 1.12s cubic-bezier(.43,.19,.31,1.14);
}
@keyframes fadeBtnIn {
  from {opacity: 0; transform: translateY(20px);}
  to {opacity: 1; transform: translateY(0);}
}
button[type="submit"]::after {
  content: '';
  position: absolute;
  left: -24%;
  top: 0;
  width: 68%;
  height: 100%;
  background: linear-gradient(90deg,rgba(255,255,255,0.15),rgba(255,255,255,0));
  opacity: 0.8;
  transform: skewX(-22deg);
  animation: btnShine 2.9s linear infinite;
  pointer-events: none;
}
@keyframes btnShine {
  0% {left: -56%;}
  80%{left: 112%;}
  100%{left: 80%;}
}
button[type="submit"]:hover {
  background: linear-gradient(108deg,#09ffd1 31%,#3846f2 100%);
  transform: translateY(-2px) scale(1.045);
  box-shadow: 0 7px 23px #3846f278;
}
a {
  display: block;
  color: #22ffe2;
  margin-top: 22px;
  font-size: 17px;
  text-align: center;
  text-decoration: underline;
  transition: color 0.2s;
  animation: linkAppear 1.65s cubic-bezier(.43,.19,.31,1.18);
}
@keyframes linkAppear {
  from { opacity:0; transform: scale(.97) translateY(12px);}
  to   { opacity:1; transform: scale(1) translateY(0);}
}
a:hover {
  color: #9bf7f7;
  text-decoration: underline wavy;
}
</style>
</head>
<body>
<div class="bg-waves">
  <div class="wave"></div>
  <div class="wave wave2"></div>
  <div class="wave wave3"></div>
</div>
<div class="form-card">
<h2>User Registration</h2>
<form action="register" method="post" autocomplete="off">
    <div class="mb-3">
        <input type="text" name="name" required placeholder=" " id="nameInput">
        <label for="nameInput">Name</label>
    </div>
    <div class="mb-3">
        <input type="email" name="email" required placeholder=" " id="emailInput">
        <label for="emailInput">Email</label>
    </div>
    <div class="mb-3">
        <input type="password" name="password" required placeholder=" " id="passwordInput">
        <label for="passwordInput">Password</label>
    </div>
    <div class="mb-3">
        <select name="role" required placeholder=" " id="roleSelect">
            <option value="" disabled selected hidden></option>
            <option value="customer">Customer</option>
            <option value="admin">Admin</option>
        </select>
        <label for="roleSelect">Select Role</label>
    </div>
    <button type="submit">Register</button>
</form>
<a href="login.jsp">Already registered? Login here</a>
</div>
</body>
</html>
