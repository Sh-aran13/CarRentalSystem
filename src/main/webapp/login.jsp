<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Login</title>
<style>
body {
  font-family: 'Segoe UI', Arial, sans-serif;
  margin: 0;
  padding: 0;
  color: #fff;
  min-height: 100vh;
  background: linear-gradient(130deg, #f9a8d4 0%, #c3f5fa 43%, #bdb4fe 85%, #fffbea 100%);
  background-size: 200% 200%;
  animation: bgMove 14s ease-in-out infinite;
  overflow-x: hidden;
  position: relative;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
@keyframes bgMove {
  0%   { background-position: 0% 50%; }
  25%  { background-position: 50% 100%; }
  50%  { background-position: 100% 50%; }
  75%  { background-position: 50% 0%; }
  100% { background-position: 0% 50%; }
}
.sparkle {
  pointer-events: none;
  position: fixed;
  top: 0; left: 0;
  width: 100vw; height: 100vh;
  z-index: 0;
}
.sparkle-dot {
  position: absolute;
  width: 5px; height: 5px;
  border-radius: 50%;
  opacity: 0.19;
  background: #f9a8d4;
  animation: sparkleMove linear infinite;
}
.sparkle-dot:nth-child(2) {background: #c3f5fa;}
.sparkle-dot:nth-child(3) {background: #bdb4fe;}
@keyframes sparkleMove {
  0%   { transform: translateY(0) scale(1); opacity: 0.19;}
  25%  { transform: translateY(-25px) scale(1.2); opacity: 0.24;}
  50%  { transform: translateY(-10px) scale(0.8); opacity: 0.15;}
  75%  { transform: translateY(10px) scale(1.1); opacity: 0.24;}
  100% { transform: translateY(0) scale(1); opacity: 0.19;}
}
.center-card {
  background: rgba(30,34,46,0.96);
  box-shadow: 0 10px 32px #bdb4fe9a, 0 3px 15px #c3f5fa80;
  padding: 44px 28px 36px;
  border-radius: 19px;
  max-width: 360px;
  width: 100%;
  animation: cardFadeIn 1.25s cubic-bezier(.42,.19,.31,1.22);
  z-index: 1;
  position: relative;
}
@media (max-width: 480px) {
  body {display: block; }
  .center-card {max-width: 98vw; padding: 18px 3vw 16px; margin: 40px auto;}
}
@keyframes cardFadeIn {
  from {opacity: 0; transform: translateY(-48px) scale(.96);}
  to {opacity: 1; transform: translateY(0) scale(1);}
}
h2 {
  text-align: center;
  margin-bottom: 30px;
  font-size: 2.1rem;
  letter-spacing: 1.5px;
  color: #bdb4fe;
  animation: fancyGlow 1.8s infinite alternate;
}
@keyframes fancyGlow {
  from { text-shadow: 0 0 16px #bdb4fe, 0 0 24px #f9a8d4a4;}
  to { text-shadow: 0 0 28px #c3f5fa, 0 0 43px #f9a8d4;}
}
.mb-3 {
  position: relative;
  margin-bottom: 1.7rem;
}
.mb-3 label {
  position: absolute;
  left: 17px;
  top: 16px;
  font-size: 1rem;
  color: #c3f5fa;
  pointer-events: none;
  transition: all 0.18s;
  z-index: 2;
  background: transparent;
  padding: 0 5px;
}
input:focus + label,
input:not(:placeholder-shown) + label {
  top: -12px; left: 7px;
  font-size: 0.93rem; color: #bdb4fe;
  background: linear-gradient(90deg, #f9a8d418 33%, transparent 90%);
  font-weight: 600;
}
input[type="email"], input[type="password"] {
  background: rgba(38,48,60,0.98);
  color: #fff;
  border: 1.7px solid #c3f5fa;
  border-radius: 8px;
  padding: 16px 15px 14px 15px;
  width: 100%;
  font-size: 1rem;
  outline: none;
  box-sizing: border-box;
  margin-top: 0.8rem;
  transition: border-color 0.19s, box-shadow 0.18s;
  animation: inputBounce 1.17s cubic-bezier(.43,.19,.31,1.14);
}
@keyframes inputBounce {
  from {opacity: 0; transform: scale(.98);}
  to   {opacity: 1; transform: scale(1);}
}
input:focus {
  border-color: #bdb4fe;
  box-shadow: 0 0 8px #c3f5fa, 0 0 9px #f9a8d4;
}
button[type="submit"] {
  width: 100%;
  background: linear-gradient(90deg,#c3f5fa 30%,#f9a8d4 98%);
  color: #222;
  border: none;
  border-radius: 8px;
  padding: 13px 0;
  font-weight: 600;
  margin-top: 8px;
  font-size: 1.08rem;
  box-shadow: 0 2px 14px #c3f5fa50, 0 0 0 #bdb4fe;
  transition: background 0.22s, transform 0.22s, box-shadow 0.22s;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  animation: fadeBtnUp 1.3s cubic-bezier(.43,.19,.31,1.14);
}
@keyframes fadeBtnUp {
  from {opacity: 0; transform: translateY(23px);}
  to {opacity: 1; transform: translateY(0);}
}
button[type="submit"]::after {
  content: '';
  position: absolute;
  left: -25%;
  top: 0;
  width: 70%;
  height: 100%;
  background: linear-gradient(90deg,rgba(255,255,255,0.16),rgba(255,255,255,0));
  opacity: .8;
  transform: skewX(-22deg);
  animation: btnShine 3s linear infinite;
  pointer-events: none;
}
@keyframes btnShine {
  0% {left: -40%;}
  85%{left: 110%;}
  100%{left: 70%;}
}
button[type="submit"]:hover {
  background: linear-gradient(108deg,#f9a8d4 27%,#bdb4fe 90%);
  transform: translateY(-2px) scale(1.045);
  box-shadow: 0 7px 24px #bdb4fe78;
}
a {
  display: inline-block;
  color: #bdb4fe;
  margin-top: 20px;
  font-size: 17px;
  text-decoration: underline;
  transition: color 0.2s;
  animation: linkFadeIn 1.7s cubic-bezier(.43,.19,.31,1.14);
}
@keyframes linkFadeIn {
  from { opacity:0; transform: scale(.95) translateY(14px);}
  to   { opacity:1; transform: scale(1) translateY(0);}
}
a:hover {
  color: #c3f5fa;
  text-decoration: underline wavy;
}
</style>
<script>
// On form submit, save loginEmail cookie for 7 days
function setLoginCookie(form) {
  var email = form.email.value;
  if(email){
    document.cookie = "loginEmail=" + encodeURIComponent(email)
                      + "; path=/; max-age=" + (60*60*24) + "; SameSite=Lax";
  }
  // Allow submit to continue
  return true;
}
window.onload = function() {
  // Autofill email field if cookie exists
  var cookies = document.cookie.split(';');
  for (var i=0;i<cookies.length;i++) {
    var c = cookies[i].trim();
    if (c.indexOf("loginEmail=") == 0) {
      var v = decodeURIComponent(c.substring("loginEmail=".length));
      var emailInput = document.getElementById('emailInput');
      if(emailInput && !emailInput.value)
        emailInput.value = v;
    }
  }
};
</script>
</head>
<body>
<div class="sparkle">
  <div class="sparkle-dot" style="top:17%;left:29%;animation-duration:5.1s;"></div>
  <div class="sparkle-dot" style="top:63%;left:88%;animation-duration:7.4s;"></div>
  <div class="sparkle-dot" style="top:49%;left:53%;animation-duration:6.3s;"></div>
  <div class="sparkle-dot" style="top:81%;left:7%;animation-duration:4.7s;"></div>
  <div class="sparkle-dot" style="top:33%;left:76%;animation-duration:5.8s;"></div>
  <div class="sparkle-dot" style="top:14%;left:58%;animation-duration:7.1s;"></div>
</div>
<div class="center-card">
<h2>Login</h2>
<form action="login" method="post" autocomplete="off" onsubmit="return setLoginCookie(this);">
    <div class="mb-3">
        <input type="email" name="email" required placeholder=" " id="emailInput">
        <label for="emailInput">Email</label>
    </div>
    <div class="mb-3">
        <input type="password" name="password" required placeholder=" " id="pwdInput">
        <label for="pwdInput">Password</label>
    </div>
    <button type="submit">Login</button>
</form>
<a href="register.jsp">New user? Register here</a>
</div>
</body>
</html>
