<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Booking" %>
<html>
<head>
    <title>All Bookings</title>
    <style>
body {
  font-family: 'Segoe UI', Arial, sans-serif;
  margin: 0;
  background: linear-gradient(120deg, #0e1b32 0%, #09ffd1 90%, #3846f2 100%);
  min-height: 100vh;
  color: #fff;
  animation: fadeInBody 1.2s;
  overflow-x: hidden;
}
@keyframes fadeInBody {
  from { opacity: 0; transform: scale(1.01);}
  to { opacity: 1; transform: scale(1);}
}
.container {
  margin-top: 56px;
  background: rgba(24,44,61,0.93);
  border-radius: 18px;
  box-shadow: 0 8px 32px #09ffd1b6, 0 4px 16px #3846f280;
  padding: 38px 28px 24px;
  max-width: 800px;
  margin-left: auto;
  margin-right: auto;
  animation: dropIn 1.3s cubic-bezier(.65,-0.03,.19,1.06);
}
@keyframes dropIn {
  from { transform: translateY(70px); opacity: 0; }
  to   { transform: translateY(0); opacity: 1; }
}
h2 {
  text-align: center;
  margin-bottom: 30px;
  font-size: 2.15rem;
  color: #22ffe2;
  letter-spacing: 2px;
  animation: glowText 1.8s infinite alternate;
}
@keyframes glowText {
  from { text-shadow: 0 0 8px #09ffd1, 0 0 22px #3846f2; }
  to   { text-shadow: 0 0 32px #22ffe2, 0 0 42px #3846f2; }
}
/* Button group */
.button-row {
  display: flex;
  gap: 17px;
  justify-content: flex-end;
  margin-bottom: 26px;
}
.btn {
  display: inline-block;
  background: linear-gradient(90deg,#35323d 10%,#3846f2 120%);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 10px 24px;
  font-size: 1rem;
  margin: 0;
  transition: background 0.15s, transform 0.15s, box-shadow 0.13s;
  text-decoration: none;
  box-shadow: 0 2px 14px #3846f290;
  position: relative;
  cursor: pointer;
  user-select: none;
}
.btn:hover {
  background: linear-gradient(90deg,#3846f2 14%,#09ffd1 100%);
  box-shadow: 0 4px 18px #09ffd188;
  transform: scale(1.045) translateY(-1px);
}
table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 14px;
  box-shadow: 0 4px 20px #3846f240;
  animation: tableFade 1.16s cubic-bezier(.45,.19,.31,1.14);
}
@keyframes tableFade {
  from { opacity:0; transform: scale(.96);}
  to   { opacity:1; transform: scale(1);}
}
thead {
  background: linear-gradient(90deg, #09ffd1 30%, #3846f2 120%);
}
thead th {
  color: white;
  text-transform: uppercase;
  letter-spacing: 1px;
  padding: 13px 0;
  font-size: 1.04rem;
  border-bottom: 2px solid #3846f2;
}
tbody tr {
  background-color: rgba(255,255,255,0.07);
  transition: all 0.32s cubic-bezier(.43,.19,.31,1.18);
  border-radius: 8px;
}
tbody tr:hover {
  background: radial-gradient(circle at 40% 60%, #09ffd1a1 0 55%, transparent 100%);
  transform: scale(1.03);
  box-shadow: 0 0 18px #09ffd190;
}
td {
  padding: 12px 10px;
  text-align: center;
  font-size: 1.01rem;
  border-bottom: 1px solid #3846f250;
  color: #eafdff;
}
tr td {
  transition: color 0.19s;
}
tr:hover td {
  color: #2ff2de;
}
.text-center {
  text-align: center;
}

/* PRINT ONLY TABLE */
@media print {
  body * { visibility: hidden !important; }
  table, table * {
    visibility: visible !important;
  }
  table {
    position: absolute !important;
    left: 0; top: 0; width: 100vw;
    background: #fff !important; color: #222 !important;
    box-shadow: none !important;
    margin: 0 !important;
  }
  thead th, td, tr { 
    background: #fff !important;
    color: #222 !important;
    page-break-inside: avoid !important;
    border: 1px solid #666 !important;
  }
  .container {
    box-shadow:none !important;
    background: #fff !important;
    padding: 0 !important;
    margin: 0 !important;
  }
  h2, .button-row, .btn, a { display: none !important; }
}

    </style>
    <script>
    // Print only the table by triggering print (the print CSS will hide the rest)
    function printTable() {
      window.print();
    }
    // Export to CSV functionality
    function exportToCSV() {
      var table = document.querySelector('table');
      var rows = table.querySelectorAll('tr');
      let csv = "";
      for(var i=0; i<rows.length; i++){
        var cols = rows[i].querySelectorAll('th,td');
        var rowArr = [];
        for(var j=0; j<cols.length; j++){
          var val = cols[j].innerText.replace(/"/g, '""');
          rowArr.push('"' + val + '"');
        }
        csv += rowArr.join(",") + "\n";
      }
      var hiddenElem = document.createElement('a');
      hiddenElem.href = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv);
      hiddenElem.target = '_blank';
      hiddenElem.download = 'bookings.csv';
      hiddenElem.click();
    }
    </script>
</head>
<body>
<div class="container">
    <h2>All Bookings</h2>
    <div class="button-row">
        <button class="btn" type="button" onclick="printTable()">Print</button>
        <button class="btn" type="button" onclick="exportToCSV()">Export to CSV</button>
    </div>
    <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>User ID</th>
                <th>Car ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Total Cost</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty bookings}">
                <c:forEach var="b" items="${bookings}">
                    <tr>
                        <td>${b.booking_id}</td>
                        <td>${b.user_id}</td>
                        <td>${b.car_id}</td>
                        <td>${b.start_date}</td>
                        <td>${b.end_date}</td>
                        <td>&#8377;${b.total_cost}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6" class="text-center">No bookings found.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/adminCars" class="btn">Back to Cars</a>
</div>
</body>
</html>
