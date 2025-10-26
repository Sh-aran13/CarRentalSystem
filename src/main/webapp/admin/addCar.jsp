<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Add Car</title>
<style>
body {
  font-family: 'Segoe UI', Arial, sans-serif;
  margin: 0;
  padding: 0;
  min-height: 100vh;
  color: #fff;
  overflow: hidden;
  position: relative;
  background: #13374f;
}
/* Waves Animation Layers */
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
  width: 250vw;
  height: 300px;
  opacity: 0.38;
  filter: blur(1px);
  animation: waveAction 18s linear infinite alternate;
  background: radial-gradient(circle at 20% 70%, #09ffd1 0 24%, transparent 24%),
              radial-gradient(circle at 80% 35%, #3846f2 0 28%, transparent 33%);
}
.wave.wave2 {
  top: 180px;
  opacity: 0.32;
  animation: waveAction2 24s linear infinite alternate;
  background: radial-gradient(circle at 75% 30%, #1f6dfb 0 25%, transparent 32%),
              radial-gradient(circle at 24% 76%, #17f3ee 0 18%, transparent 24%);
}
.wave.wave3 {
  top: 360px;
  opacity: 0.27;
  animation: waveAction3 34s linear infinite alternate;
  background: radial-gradient(circle at 35% 80%, #fff 0 15%, transparent 22%);
}
@keyframes waveAction {
  from { left: 0; top: 40px; }
  40% { left: -25vw; top: 70px; }
  100% { left: -20vw; top: 32px;}
}
@keyframes waveAction2 {
  from { left: 0; top: 180px;}
  60% { left: -16vw; top: 140px;}
  100% { left: -10vw; top: 200px;}
}
@keyframes waveAction3 {
  from { left: 0; top: 360px;}
  100% { left: -40vw; top: 320px;}
}

/* Smaller Container */
.container {
  max-width: 380px;
  background: rgba(24,44,61,0.93);
  margin: 52px auto 0 auto;
  border-radius: 18px;
  box-shadow: 0 8px 32px #09ffd1b6, 0 4px 28px #3846f2b6;
  padding: 32px 18px 24px;
  position: relative;
  animation: cardDrop 1.2s cubic-bezier(.64,-0.01,.21,1.05);
}
@media (max-width: 500px) {
  .container {
    max-width: 98vw;
    padding: 16px 3vw 12px;
  }
}
@keyframes cardDrop {
  from { transform: scale(.96) translateY(-48px); opacity: 0;}
  70%  { box-shadow: 0 30px 140px #09ffd120, 0 10px 44px #3846f2bb;}
  to   { transform: scale(1) translateY(0); opacity: 1;}
}
h2 {
  text-align: center;
  margin-bottom: 26px;
  font-size: 1.5rem;
  letter-spacing: 1px;
  position: relative;
  color: #22ffe2;
  animation: fancyGlow 2.1s infinite alternate;
}
@keyframes fancyGlow {
  from { text-shadow: 0 0 16px #22ffe2, 0 0 32px #3846f2a4;}
  to { text-shadow: 0 0 32px #09ffd1, 0 0 48px #3846f2;}
}

.mb-3 {
  position: relative;
  margin-bottom: 1.3rem;
  animation: itemAppear 1s;
}
@keyframes itemAppear {
  from {opacity: 0; transform: scale(.97) translateY(24px);}
  to {opacity: 1; transform: scale(1) translateY(0);}
}
.mb-3 label {
  position: absolute;
  left: 13px;
  top: 13px;
  font-size: .97rem;
  color: #9bf7f7;
  background: transparent;
  pointer-events: none;
  transition: all 0.19s;
  z-index: 2;
  padding: 0 4px;
}
input:focus + label,
input:not(:placeholder-shown) + label {
  top: -11px; left: 7px;
  font-size: .89rem; color: #32ffd7;
  background: linear-gradient(90deg, #0934ff18 33%, transparent 90%);
  letter-spacing: .5px;
  font-weight: 600;
}
input, select {
  background: rgba(19, 30, 52, 0.99);
  color: #fff;
  border: 1.5px solid #09ffd1;
  border-radius: 8px;
  padding: 12px 11px 11px 11px;
  width: 100%;
  font-size: .99rem;
  margin-top: 0.6rem;
  outline: none;
  box-sizing: border-box;
  transition: border-color 0.18s, box-shadow 0.18s;
  animation: inputPop 1.12s cubic-bezier(.42,.19,.31,1.22);
}
@keyframes inputPop {
  from {opacity: 0; transform: scale(.98);}
  to   {opacity: 1; transform: scale(1);}
}
input:focus, select:focus {
  border-color: #3846f2;
  box-shadow: 0 0 8px #22ffe2, 0 0 14px #3846f2;
}
select {margin-top: .6rem;}

button[type="submit"] {
  width: 100%;
  background: linear-gradient(90deg,#3846f2 35%,#09ffd1 90%);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 12px 0;
  font-weight: 600;
  margin-top: 15px;
  font-size: 1.09rem;
  box-shadow: 0 2px 14px #09ffd150, 0 0 0 #09ffd1;
  transition: background 0.22s, transform 0.22s, box-shadow 0.22s;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
button[type="submit"]::after {
  content: '';
  position: absolute;
  left: -25%;
  top: 0;
  width: 70%;
  height: 100%;
  background: linear-gradient(90deg,rgba(255,255,255,0.18),rgba(255,255,255,0));
  opacity: 0.7;
  transform: skewX(-22deg);
  animation: btnShine 2.8s linear infinite;
  pointer-events: none;
}
@keyframes btnShine {
  0% {left: -55%;}
  90%{left: 130%;}
  100%{left: 110%;}
}
button[type="submit"]:hover {
  background: linear-gradient(108deg,#09ffd1 27%,#3846f2 90%);
  transform: translateY(-2px) scale(1.04);
  box-shadow: 0 6px 22px #3846f278;
}
.btn-secondary {
  display: inline-block;
  background: linear-gradient(90deg,#35323d 10%,#3846f2 120%);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 10px 19px;
  font-size: .97rem;
  margin-top: 13px;
  margin-left: 0;
  transition: background 0.19s, transform 0.19s, box-shadow 0.19s;
  text-decoration: none;
  box-shadow: 0 2px 10px #3846f280;
  position: relative;
  animation: backBtnAppear 1.35s;
}
@keyframes backBtnAppear {
  from {opacity: 0; transform: scale(.96) translateY(10px);}
  to {opacity: 1; transform: scale(1) translateY(0);}
}
.btn-secondary:hover {
  background: linear-gradient(90deg,#3846f2 14%,#09ffd1 100%);
  box-shadow: 0 6px 20px #09ffd180;
  transform: translateY(-2px) scale(1.04);
}
</style>
</head>
<body>
<div class="bg-waves">
  <div class="wave"></div>
  <div class="wave wave2"></div>
  <div class="wave wave3"></div>
</div>
<div class="container">
<h2>Add New Car</h2>
<form action="<%= request.getContextPath() %>/adminCars" method="post" autocomplete="off">
    <div class="mb-3">
        <input type="text" name="make" class="form-control" required placeholder=" " id="makeInput">
        <label for="makeInput">Make</label>
    </div>
    <div class="mb-3">
        <input type="text" name="model" class="form-control" required placeholder=" " id="modelInput">
        <label for="modelInput">Model</label>
    </div>
    <div class="mb-3">
        <input type="number" name="year" class="form-control" required placeholder=" " id="yearInput">
        <label for="yearInput">Year</label>
    </div>
    <div class="mb-3">
        <input type="number" step="0.01" name="rate" class="form-control" required placeholder=" " id="rateInput">
        <label for="rateInput">Daily Rate</label>
    </div>
    <div class="mb-3">
        <select name="status" class="form-select" required id="statusSelect">
            <option value="Available" selected>Available</option>
            <option value="Rented">Rented</option>
        </select>
        <label for="statusSelect">Status</label>
    </div>
    <button type="submit">Add Car</button>
</form>
<a href="<%= request.getContextPath() %>/adminCars" class="btn-secondary">Back</a>
</div>
</body>
</html>
