<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Car Rental System</title>
<style>
html, body {
  width: 100vw; height: 100vh; margin: 0; padding: 0; overflow: hidden;
}
body {
  font-family: 'Segoe UI', 'Montserrat', Arial, sans-serif;
  min-height: 100vh; min-width: 100vw;
  position: relative;
  background: #1F1C2C;
  overflow: hidden;
}
.particle-bg {
  position: absolute;
  width: 100vw;
  height: 100vh;
  top: 0; left: 0;
  z-index: 0;
  overflow: hidden;
  pointer-events: none;
}
.particle {
  position: absolute;
  border-radius: 50%;
  opacity: 0.13;
  filter: blur(40px);
  animation: movePart 17s linear infinite;
}
.p1 { background: #3846f2; width:290px; height:290px; left:7vw; top:6vh; animation-delay: 0s;}
.p2 { background: #22ffe2; width:210px; height:210px; left:72vw; top:17vh; animation-delay: -6s;}
.p3 { background: #fca8ff; width:170px; height:170px; left:42vw; top:63vh; animation-delay: -12s;}
.p4 { background: #09ffd1; width:120px; height:120px; left:85vw; top:70vh; animation-delay: -9s;}
@keyframes movePart {
  0%   {transform: scale(1);}
  35%  {transform: scale(1.21) translateY(-23px);}
  55%  {transform: scale(.89) translateY(13px);}
  100% {transform: scale(1.14);}
}

.center-card {
  padding: 56px 32px 36px;
  background: rgba(36,42,78,0.78);
  border-radius: 27px;
  box-shadow: 0 8px 44px #3846f265, 0 0px 60px 2px #23ffd114, 0 2px 14px #23ffd114;
  max-width: 430px; width:92vw;
  position:absolute; left:50%; top:50%; transform:translate(-50%,-51%);
  z-index: 2;
  display:flex; flex-direction:column; align-items:center;
  border: 2.2px solid #3846f232;
  backdrop-filter: blur(7px);
  animation: cardFadeIn 1.18s cubic-bezier(.63,-0.09,.21,1.09);
}
@keyframes cardFadeIn {
  from { transform: scale(.98) translate(-50%,-64px); opacity:0;}
  80%  { box-shadow: 0 28px 80px #3846f228, 0 4px 45px #23ffd1bb;}
  to   { transform: scale(1) translate(-50%,-51%); opacity:1;}
}

h1 {
  margin: 0 0 26px 0;
  font-size: 2.45rem;
  font-family: 'Montserrat', 'Segoe UI', Arial, sans-serif;
  font-weight: 800;
  letter-spacing: 1.65px;
  background: linear-gradient(90deg, #23ffd1 0%, #3846f2 70%, #fff 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-align: center;
  /* Reduced glow: */
  filter: drop-shadow(0 0 2px #23ffd175) drop-shadow(0 2px 0 #23223a12);
  text-shadow:
    0 1px 0 #3846f233,
    0 2px 6px #21ffd11a;
  /* Subtle dark outline for crispness */
}

@media (max-width: 600px) {
  .center-card {
    max-width: 98vw;
    padding: 19px 2vw 21px;
  }
}

.btn-group {
  margin-top: 36px; width:100%; display:flex; justify-content:center; gap:17px;
}
.animated-btn {
  flex:1; min-width:127px;
  padding: 14px 43px;
  font-size: 1.09rem;
  font-family: 'Montserrat', 'Segoe UI', Arial, sans-serif;
  font-weight: 700;
  color: #fff;
  background: linear-gradient(90deg,#3846f2 42%,#22ffe2 100%);
  border: none;
  border-radius: 15px;
  text-shadow: 0 1px 6px #22ffe266;
  box-shadow: 0 3px 20px #3846f255, 0 4px 10px #22ffe235, 0 2px 10px #fca8ff33;
  cursor: pointer;
  text-decoration: none;
  position:relative;
  overflow:hidden;
  margin: 0 0 2px 0;
  letter-spacing:.08em;
  opacity: 0;
  animation: btnAppear 1.4s cubic-bezier(.46,.18,.22,1.16) forwards;
}
.animated-btn:nth-child(1) {animation-delay: .35s;}
.animated-btn:nth-child(2) {animation-delay: .57s;}
@keyframes btnAppear {
  from {opacity: 0; transform: translateY(34px) scale(.96);}
  to {opacity: 1; transform: translateY(0) scale(1);}
}
.animated-btn:after {
  content: '';
  position: absolute;
  left: -40%;
  top: 0; width: 70%; height: 105%;
  background: linear-gradient(90deg,rgba(255,255,255,0.09),rgba(255,255,255,0));
  opacity: .27;
  transform: skewX(-18deg);
  pointer-events:none;
  animation: btnShine 3.4s linear infinite;
}
@keyframes btnShine {
  0% {left: -30%;}
  85%{left: 100%;}
  100%{left: 85%;}
}
.animated-btn:hover, .animated-btn:focus {
  background: linear-gradient(90deg,#22ffe2 40%,#3846f2 95%);
  box-shadow: 0 8px 24px #09ffd1b2;
  color: #232047;
  transform: scale(1.045);
  z-index:2;
}
@media (max-width: 600px) {
  .center-card {
    max-width: 97vw;
    padding: 18px 2vw 19px;
  }
  .btn-group {flex-direction:column; gap:15px; margin-top:22px;}
  .animated-btn {width:98%; min-width:110px;}
}

</style>
</head>
<body>
  <div class="particle-bg">
    <div class="particle p1"></div>
    <div class="particle p2"></div>
    <div class="particle p3"></div>
    <div class="particle p4"></div>
  </div>
  <div class="center-card">
    <h1>Welcome to<br>Car Rental System</h1>
    <div class="btn-group">
      <a href="login.jsp" class="animated-btn">Login</a>
      <a href="register.jsp" class="animated-btn">Register</a>
    </div>
  </div>
</body>
</html>
