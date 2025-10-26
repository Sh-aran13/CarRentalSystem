<%@ page import="model.User" %>
<%
User user = (User) session.getAttribute("user");
String name = (user != null && user.getName() != null) ? user.getName() : "Customer";
%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer Dashboard</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body {
            height: 100%;
            font-family: 'Segoe UI', 'Poppins', sans-serif;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        /* BACKGROUND */
        body {
            background: linear-gradient(115deg, #ebedef 0%, #28243b 55%, #0d1117 85%);
            position: relative;
        }
        .background-animated {
            position: fixed;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            z-index: 0;
            pointer-events: none;
            overflow: hidden;
        }
        .circle {
            position: absolute;
            border-radius: 50%;
            opacity: 0.14;
            mix-blend-mode: lighten;
            filter: blur(30px);
            animation: floatCircle 18s infinite alternate ease-in-out;
        }
        .circle.circle1 {
            width: 50vw; height: 52vh;
            background: #ffffff;
            left: 5vw; top: 8vh;
            opacity: .11;
            animation-duration: 23s;
        }
        .circle.circle2 {
            width: 37vw; height: 34vh;
            background: #6563ff;
            left: 62vw; top: 18vh;
            opacity: .15;
            animation-delay: -6s;
            animation-duration: 19s;
        }
        .circle.circle3 {
            width: 28vw; height: 30vh;
            background: #07ffd7;
            left: 35vw; top: 70vh;
            opacity: .13;
            animation-delay: -2s;
            animation-duration: 21s;
        }
        .circle.circle4 {
            width: 20vw; height: 22vh;
            background: #31394a;
            left: 75vw; top: 78vh;
            opacity: 0.14;
            animation-delay: -8s;
            animation-duration: 30s;
        }
        @keyframes floatCircle {
            0% { transform: translateY(0) scale(1);}
            30% { transform: translateY(-20px) scale(1.04);}
            60% { transform: translateY(25px) scale(.99);}
            100%{ transform: translateY(0) scale(1);}
        }

        /* WRAPPER */
        .dashboard-wrapper {
            position: relative;
            z-index: 10;
            padding: 40px;
            max-width: 900px;
            width: 90%;
            text-align: center;
            background: rgba(255, 255, 255, 0.10);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.11);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(14px);
        }

        /* HEADER */
        .dashboard-header {
            font-size: 2.5rem;
            font-weight: 700;
            color: #10101c;
            margin-bottom: 50px;
            text-shadow: 0 0 16px rgba(170, 220, 250, 0.19), 0 0 1px #fff;
            opacity: 0;
            animation: headerFadeIn 1.4s 0.47s forwards;
        }
        @keyframes headerFadeIn {
            to { opacity: 1; }
        }

        /* BUTTONS */
        .dashboard-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .btn {
            padding: 14px 30px;
            border: 2px solid transparent;
            border-radius: 8px;
            font-size: 1.01rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(.43,.19,.31,1.14);
            position: relative;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,.13);
        }
        .btn-success {
            background-color: #23b686;
            color: #ffffff;
            border-color: #53efc6;
        }
        .btn-success:hover {
            background: linear-gradient(90deg,#23b686 74%, #ebedef 100%);
            color: #222b28;
            transform: translateY(-3px);
            box-shadow: 0 11px 34px #53efc6a6;
        }
        .btn-info {
            background-color: #3962df;
            color: #ffffff;
            border-color: #a6c2fc;
        }
        .btn-info:hover {
            background: linear-gradient(90deg,#ebedef 14%,#3962df 85%);
            color: #364360;
            box-shadow: 0 9px 32px #3962dfa0;
            transform: translateY(-3px);
        }
        .btn-danger-outline {
            background-color: transparent;
            color: #e54a4c;
            border-color: #e54a4c;
        }
        .btn-danger-outline:hover {
            background: #e54a4c;
            color: #fff;
            transform: scale(1.07);
            box-shadow: 0 9px 34px #e54a4c2d;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(255,255,255,.08);
            transition: opacity .22s;
            opacity: 0;
        }
        .btn:hover::before {
            opacity: 1;
        }

        @media (max-width: 600px) {
            .dashboard-wrapper { padding: 16px; }
            .dashboard-header { font-size: 1.5rem; margin-bottom: 25px; }
            .dashboard-buttons { flex-direction: column; gap: 13px; }
            .btn { width: 100%; }
        }

        /* CONFIRMATION MODAL */
        .confirm-box {
            position: fixed;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: rgba(13, 17, 23, 0.65);
            backdrop-filter: blur(6px);
            opacity: 0;
            visibility: hidden;
            transition: all 0.4s ease;
            z-index: 999;
        }
        .confirm-box.active {
            opacity: 1;
            visibility: visible;
        }
        .confirm-content {
            background: linear-gradient(135deg, #ebedef 0%, #1d2530 90%);
            color: #fff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 12px 34px rgba(0,0,0,0.4);
            text-align: center;
            animation: popupFade 0.4s ease forwards;
        }
        @keyframes popupFade {
            0% { transform: scale(0.6); opacity: 0; }
            60% { transform: scale(1.05); opacity: 1; }
            100% { transform: scale(1); }
        }
        .confirm-buttons {
            margin-top: 25px;
            display: flex;
            justify-content: center;
            gap: 18px;
        }

        /* LOGOUT SUCCESS TOAST */
        .logout-message {
            position: fixed;
            top: 40px;
            right: -300px;
            background: #23b686;
            color: #fff;
            padding: 12px 28px;
            border-radius: 6px;
            box-shadow: 0 8px 22px rgba(0,0,0,0.2);
            font-weight: 600;
            z-index: 1000;
            animation: fadeSlide 2.5s forwards;
        }
        @keyframes fadeSlide {
            0% { right: -300px; opacity: 0; }
            20% { right: 40px; opacity: 1; }
            80% { right: 40px; opacity: 1; }
            100% { right: -300px; opacity: 0; }
        }
    </style>
</head>
<body>

<div class="background-animated">
    <div class="circle circle1"></div>
    <div class="circle circle2"></div>
    <div class="circle circle3"></div>
    <div class="circle circle4"></div>
</div>

<div class="dashboard-wrapper">
    <h2 class="dashboard-header">Welcome, <%= name %>! This is your Customer Dashboard.</h2>
    <div class="dashboard-buttons">
        <a href="<%= request.getContextPath() %>/customer/availableCars.jsp" class="btn btn-success">Available Cars</a>
        <a href="<%= request.getContextPath() %>/customer/myBookings.jsp" class="btn btn-info">My Bookings</a>
        <a href="#" class="btn btn-danger-outline" id="logoutBtn">Logout</a>
    </div>
</div>

<!-- CUSTOM CONFIRM BOX -->
<div id="confirmBox" class="confirm-box">
    <div class="confirm-content">
        <h3>Confirm Logout</h3>
        <p>Are you sure you want to log out?</p>
        <div class="confirm-buttons">
            <button id="confirmYes" class="btn btn-success">Yes</button>
            <button id="confirmNo" class="btn btn-danger-outline">No</button>
        </div>
    </div>
</div>

<script>
const confirmBox = document.getElementById('confirmBox');
const confirmYes = document.getElementById('confirmYes');
const confirmNo = document.getElementById('confirmNo');
const logoutButton = document.getElementById('logoutBtn');

logoutButton.addEventListener('click', (e) => {
    e.preventDefault();
    confirmBox.classList.add('active');
});

confirmYes.addEventListener('click', () => {
    confirmBox.classList.remove('active');
    const messageEl = document.createElement('div');
    messageEl.className = 'logout-message';
    messageEl.textContent = 'Logged out successfully!';
    document.body.appendChild(messageEl);
    setTimeout(() => window.location.href = '<%= request.getContextPath() %>/logout', 1500);
});

confirmNo.addEventListener('click', () => {
    confirmBox.classList.remove('active');
});
</script>

</body>
</html>
