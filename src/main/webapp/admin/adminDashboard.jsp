<%@ page import="model.User" %>
<%
User user = (User) session.getAttribute("user");
String name = (user != null && user.getName() != null) ? user.getName() : "Admin";
%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <style>
        /* ========== RESET & BASE ========== */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body {
            height: 100%;
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            overflow: hidden;
        }

        /* ========== BACKGROUND (Wavy Fluid Blob Effect) ========== */
        body {
            background: linear-gradient(-45deg, #23074d, #340c6b, #43158c, #5b28af, #7d44c9);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            position: relative;
        }
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .wavy-blob-container {
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }
        .blob {
            position: absolute;
            width: 600px;
            height: 600px;
            border-radius: 40% 60% 70% 30% / 40% 40% 60% 50%;
            opacity: 0.6;
            filter: blur(80px);
            mix-blend-mode: soft-light;
            animation: blobMove 25s infinite ease-in-out alternate;
        }
        .blob:nth-child(1) {
            top: -150px;
            left: -150px;
            background: #ff7e7e;
            animation-duration: 25s;
        }
        .blob:nth-child(2) {
            bottom: -100px;
            right: -100px;
            background: #a2ffaf;
            animation-duration: 30s;
            animation-delay: -5s;
        }
        .blob:nth-child(3) {
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            height: 400px;
            background: #50c9c3;
            animation-duration: 20s;
            animation-delay: -10s;
        }
        @keyframes blobMove {
            0% { 
                transform: translate(0, 0) scale(1); 
                border-radius: 40% 60% 70% 30% / 40% 40% 60% 50%;
            }
            33% { 
                transform: translate(30px, -50px) scale(1.1); 
                border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%;
            }
            66% { 
                transform: translate(-20px, 20px) scale(0.9); 
                border-radius: 30% 70% 40% 60% / 30% 60% 40% 70%;
            }
            100% { 
                transform: translate(0, 0) scale(1); 
                border-radius: 40% 60% 70% 30% / 40% 40% 60% 50%;
            }
        }

        .dashboard-content-wrapper {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
            width: 90%;
            max-width: 640px;
            padding: 20px 10px;
            text-align: center;
            backdrop-filter: blur(6px);
        }
        .dashboard-header {
            font-size: 2.5rem;
            font-weight: 800;
            color: #fff;
            text-shadow: 0 0 15px rgba(255, 255, 255, 0.7); 
            letter-spacing: 2px;
            opacity: 0;
            margin-bottom: 40px;
            animation: fadeInHeader 1.2s 0.8s forwards;
        }
        @keyframes fadeInHeader {
            from { opacity: 0; transform: translateY(-30px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .dashboard-buttons {
            margin: 40px 0;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .btn {
            display: inline-block;
            border: none;
            border-radius: 10px;
            padding: 14px 36px;
            font-size: 1.05rem;
            font-weight: 600;
            color: #fff;
            text-decoration: none;
            cursor: pointer;
            position: relative;
            background: rgba(125, 68, 201, 0.9);
            box-shadow: 0 4px 25px rgba(0,0,0,0.6);
            transition: all 0.3s ease;
            overflow: hidden;
            backdrop-filter: blur(5px);
        }
        .btn::before {
            content: "";
            position: absolute;
            top: 0; left: -75%;
            width: 50%; height: 100%;
            background: rgba(255,255,255,0.25);
            transform: skewX(-25deg);
            transition: left 0.75s ease;
        }
        .btn:hover::before {
            left: 125%;
        }
        .btn:hover {
            transform: scale(1.08);
            box-shadow: 0 6px 30px rgba(0,0,0,0.7);
        }
        .btn.logout {
            background: rgba(255, 100, 100, 0.85);
        }
        .card {
            border-radius: 16px;
            margin: 40px auto 0;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 3px 25px rgba(0,0,0,0.5);
            padding: 24px;
            opacity: 0;
            backdrop-filter: blur(10px);
            animation: fadeInCard 1s 1.6s forwards;
        }
        @keyframes fadeInCard {
            from { opacity: 0; transform: translateY(50px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .card {
            animation: float 6s ease-in-out infinite alternate, fadeInCard 1s 1.6s forwards;
        }
        @keyframes float {
            from { transform: translateY(0); }
            to   { transform: translateY(-10px); }
        }
        .card-title {
            color: #fff;
            text-shadow: 0 0 5px #ff7e7e;
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 12px;
        }
        .card-text {
            color: #fff;
            font-size: 1rem;
        }
        @media (max-width: 600px) {
            .btn { padding: 12px 24px; font-size: 1rem; }
            .dashboard-header { font-size: 1.8rem; }
            .dashboard-content-wrapper { top: 0; transform: translate(-50%, 0); margin-top: 40px; }
        }

        /* ======= Logout Confirmation Modal ======= */
        .confirm-box {
            position: fixed;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: rgba(30, 11, 56, 0.52);
            backdrop-filter: blur(7px);
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.36s;
            z-index: 50;
        }
        .confirm-box.active {
            opacity: 1;
            visibility: visible;
        }
        .confirm-content {
            background: linear-gradient(135deg, #43158c 0%, #7d44c9 100%);
            color: #fff;
            padding: 35px 42px;
            border-radius: 14px;
            box-shadow: 0 14px 44px rgba(120,68,201,.2);
            text-align: center;
            animation: popupFade 0.38s cubic-bezier(.21,.61,.36,.9) forwards;
        }
        @keyframes popupFade {
            0%   { transform: scale(0.7); opacity: 0;}
            60%  { transform: scale(1.04); opacity: 1;}
            100% { transform: scale(1);}
        }
        .confirm-buttons {
            margin-top: 26px;
            display: flex;
            justify-content: center;
            gap: 30px;
        }
        /* ======= Logout Toast Animation ======= */
        .logout-toast {
            position: fixed;
            top: 50px;
            right: -300px;
            background: linear-gradient(90deg,#ff7e7e 60%,#43158c 100%);
            color: #fff;
            padding: 12px 27px;
            border-radius: 8px;
            font-weight: 600;
            box-shadow: 0 7px 22px rgba(67,21,140,.18);
            z-index: 99;
            animation: toastSlide 1.7s forwards;
        }
        @keyframes toastSlide {
          0% { right: -300px; opacity: 0; }
          20% { right: 55px; opacity: 1; }
          80% { right: 55px; opacity: 1; }
          100% { right: -300px; opacity: 0; }
        }
    </style>
</head>
<body>

<div class="wavy-blob-container">
    <div class="blob"></div>
    <div class="blob"></div>
    <div class="blob"></div>
</div>

<div class="dashboard-content-wrapper">
    <h2 class="dashboard-header">Welcome, <%= name %> 👋</h2>
    <div class="dashboard-buttons">
        <a href="<%= request.getContextPath() %>/adminCars" class="btn">Cars List</a>
        <a href="<%= request.getContextPath() %>/admin/addCar.jsp" class="btn">Add Car</a>
        <a href="<%= request.getContextPath() %>/adminBookings" class="btn">Bookings</a>
        <a href="#" class="btn logout" id="logoutBtn">Logout</a>
    </div>
    <div class="card">
        <div class="card-title">💡 Tip</div>
        <div class="card-text">Manage cars and bookings efficiently! Add new cars, track bookings, and always log out for security.</div>
    </div>
</div>

<!-- Logout Confirmation Modal -->
<div id="confirmBox" class="confirm-box">
  <div class="confirm-content">
    <h3>Confirm Logout</h3>
    <p>Are you sure you want to log out?</p>
    <div class="confirm-buttons">
      <button id="confirmYes" class="btn logout">Yes</button>
      <button id="confirmNo" class="btn">No</button>
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
    const toast = document.createElement('div');
    toast.className = 'logout-toast';
    toast.textContent = 'Logged out successfully!';
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 1500);
    setTimeout(() => window.location.href = '<%= request.getContextPath() %>/logout', 1200);
});

confirmNo.addEventListener('click', () => {
    confirmBox.classList.remove('active');
});
</script>

</body>
</html>
