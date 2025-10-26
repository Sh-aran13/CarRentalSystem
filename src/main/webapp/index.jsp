<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Car Rental System</title>
<style>
body {
  margin: 0;
  padding: 0;
  min-height: 100vh;
  font-family: 'Segoe UI', Arial, sans-serif;
  color: #fff;
  position: relative;
  background: linear-gradient(120deg, #3846f2 0%, #09ffd1 85%, #0e1b32 100%);
  animation: bgMove 9s ease-in-out infinite alternate;
  overflow-x: hidden;
}
@keyframes bgMove {
  0% {background-position: 0% 50%;}
  100% {background-position: 100% 50%;}
}
.center-card {
  margin: 13vh auto 0 auto;
  padding: 44px 24px 40px;
  background: rgba(24,44,61,0.89);
  border-radius: 22px;
  box-shadow: 0 8px 38px #3846f278, 0 1px 0 #09ffd117;
  max-width: 430px;
  animation: cardDrop 1.2s cubic-bezier(.64,-0.01,.21,1.05);
}
@media (max-width: 600px) {
  .center-card {
    max-width: 98vw;
    padding: 19px 4vw 18px;
  }
}
@keyframes cardDrop {
  from { transform: scale(.98) translateY(-48px); opacity: 0;}
  70%  { box-shadow: 0 30px 80px #09ffd120, 0 4px 32px #3846f2bb;}
  to   { transform: scale(1) translateY(0); opacity: 1;}
}

h1 {
  margin-top: 0;
  margin-bottom: 20px;
  font-size: 2.2rem;
  font-weight: 700;
  letter-spacing: 2px;
  color: #22ffe2;
  animation: fancyGlow 2s infinite alternate;
}
@keyframes fancyGlow {
  from { text-shadow: 0 0 18px #22ffe2, 0 0 28px #3846f2a4;}
  to { text-shadow: 0 0 40px #09ffd1, 0 0 45px #3846f2;}
}
.btn-group {
  margin-top: 32px;
}
.animated-btn {
  display: inline-block;
  padding: 13px 40px;
  margin: 8px 5px;
  font-size: 1rem;
  font-weight: 600;
  color: #fff;
  background: linear-gradient(90deg,#3846f2 18%,#09ffd1 100%);
  border: none;
  border-radius: 10px;
  box-shadow: 0 2px 18px #3846f236, 0 1px 0 #09ffd120;
  cursor: pointer;
  text-decoration: none;
  transition: background 0.22s, box-shadow 0.28s, transform 0.22s;
  opacity: 0;
  animation: fadeInBtn 1.8s cubic-bezier(.43,.19,.31,1.22) forwards;
  position: relative;
}

.animated-btn:nth-child(1) {animation-delay: 0.4s;}
.animated-btn:nth-child(2) {animation-delay: 0.7s;}

@keyframes fadeInBtn {
  from {opacity: 0; transform: translateY(28px) scale(.96);}
  to {opacity: 1; transform: translateY(0) scale(1);}
}
.animated-btn:hover, .animated-btn:focus {
  background: linear-gradient(90deg,#09ffd1 40%,#3846f2 100%);
  box-shadow: 0 8px 27px #09ffd1a8;
  transform: scale(1.045);
}
.animated-btn::after {
  content: '';
  position: absolute;
  left: -20%;
  top: 0; width: 65%; height: 100%;
  background: linear-gradient(90deg,rgba(255,255,255,0.16),rgba(255,255,255,0));
  opacity: .5;
  transform: skewX(-18deg);
  pointer-events:none;
  animation: btnShine 3.7s linear infinite;
}
@keyframes btnShine {
  0% {left: -50%;}
  85%{left: 110%;}
  100%{left: 89%;}
}

</style>
</head>
<body>
    <div class="center-card">
      <h1>Welcome to Car Rental System</h1>
      <div class="btn-group">
        <a href="login.jsp" class="animated-btn">Login</a>
        <a href="register.jsp" class="animated-btn">Register</a>
      </div>
    </div>
</body>
</html>
