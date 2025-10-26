<%@ page import="java.util.*,dao.CarDAO,model.Car" %>
<%
CarDAO dao = new CarDAO();
List<Car> cars = dao.listAll();
%>
<html>
<head>
<title>Manage Cars</title>
<style>
/* Base Theme */
body {
  font-family: 'Segoe UI', sans-serif;
  background: linear-gradient(135deg, #0f0f0f, #1a1a1a);
  color: #fff;
  margin: 0;
  overflow-x: hidden;
  animation: fadeIn 1.2s ease-in;
}

/* Fade in whole page */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.container {
  width: 90%;
  margin: 60px auto;
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(10px);
  border-radius: 12px;
  padding: 30px;
  box-shadow: 0 0 25px rgba(0, 255, 200, 0.3);
  animation: slideUp 1s ease-out;
}

/* Slide-up reveal effect */
@keyframes slideUp {
  from { transform: translateY(30px); opacity: 0; }
  to { transform: translateY(0); opacity: 1; }
}

/* Title animation */
h2 {
  text-align: center;
  font-size: 2rem;
  letter-spacing: 1px;
  text-transform: uppercase;
  margin-bottom: 25px;
  position: relative;
  animation: glowText 2s infinite alternate;
}
@keyframes glowText {
  from { text-shadow: 0 0 10px #00e6b8, 0 0 20px #00e6b8; }
  to { text-shadow: 0 0 25px #04ffcc, 0 0 45px #04ffcc; }
}

/* Buttons */
.button-group {
  text-align: center;
  margin-top: 24px;
}
a.btn {
  text-decoration: none;
  padding: 10px 18px;
  border-radius: 8px;
  color: white;
  background-color: #00bfa5;
  margin-right: 10px;
  transition: all 0.3s ease;
  display: inline-block;
  animation: fadeButtons 0.8s ease backwards;
  margin-bottom: 8px;
}
a.btn:last-child {
  margin-right: 0;
}
a.btn:hover {
  background-color: #04e6c7;
  box-shadow: 0 0 15px #04e6c7;
  transform: translateY(-3px);
}
@keyframes fadeButtons {
  from { opacity: 0; transform: scale(0.9); }
  to { opacity: 1; transform: scale(1); }
}

/* Table styling */
table {
  width: 100%;
  border-collapse: collapse;
  overflow: hidden;
  border-radius: 8px;
  animation: tableFade 1.2s ease;
}
@keyframes tableFade {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

thead {
  background: #00bfa5;
  color: white;
  text-transform: uppercase;
  letter-spacing: 1px;
}

tbody tr {
  background-color: rgba(255, 255, 255, 0.05);
  transition: all 0.3s ease;
}
tbody tr:hover {
  background-color: rgba(0, 255, 200, 0.2);
  transform: scale(1.01);
  box-shadow: 0 0 10px rgba(0, 255, 200, 0.3);
}

/* Table cells */
td, th {
  padding: 12px 16px;
  text-align: center;
}

/* Button styles inside table */
.btn-warning {
  background: linear-gradient(145deg, #ffaa00, #cc8800);
}
.btn-danger {
  background: linear-gradient(145deg, #ff4444, #cc0000);
}
.btn-warning:hover {
  background: linear-gradient(145deg, #ffbb33, #ffaa00);
  box-shadow: 0 0 12px #ffaa00;
}
.btn-danger:hover {
  background: linear-gradient(145deg, #ff6666, #ff3333);
  box-shadow: 0 0 12px #ff6666;
}
</style>
</head>
<body>
<div class="container">
    <h2>Admin - Manage Cars</h2>

    <table>
        <thead>
            <tr>
                <th>Make</th><th>Model</th><th>Year</th>
                <th>Daily Rate</th><th>Status</th><th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% for(Car c : cars){ %>
        <tr>
            <td><%= c.getMake() %></td>
            <td><%= c.getModel() %></td>
            <td><%= c.getYear() %></td>
            <td>&#8377;<%= c.getDaily_rate() %></td>
            <td><%= c.getStatus() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/adminCars?action=edit&id=<%= c.getCar_id() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%= request.getContextPath() %>/adminCars?action=delete&id=<%= c.getCar_id() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this car?');">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <div class="button-group">
        <a href="<%= request.getContextPath() %>/admin/addCar.jsp" class="btn">Add New Car</a>
        <a href="<%= request.getContextPath() %>/admin/adminDashboard.jsp" class="btn">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
