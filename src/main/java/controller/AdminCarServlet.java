package controller;

import dao.CarDAO;
import model.Car;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminCarServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        CarDAO dao = new CarDAO();

        try {
            // Default: Show all cars
            if (action == null) {
                req.setAttribute("cars", dao.listAll());
                req.getRequestDispatcher("/admin/cars.jsp").forward(req, res);
                return;
            }

            if ("edit".equals(action)) {
                String idParam = req.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty()) {
                    res.getWriter().println("<h2 style='color:red'>Car ID not supplied for editing.</h2>");
                    return;
                }

                int id = Integer.parseInt(idParam);
                Car car = dao.getCarById(id);
                if (car != null) {
                    req.setAttribute("car", car);
                    req.getRequestDispatcher("/admin/editCar.jsp").forward(req, res);
                } else {
                    res.getWriter().println("<h2 style='color:red'>Car not found for editing. ID: " + id + "</h2>");
                }
                return;
            }

            if ("delete".equals(action)) {
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.trim().isEmpty()) {
                    int id = Integer.parseInt(idParam);
                    dao.deleteCar(id);
                }
                res.sendRedirect(req.getContextPath() + "/adminCars");
                return;
            }

            if ("add".equals(action)) {
                req.getRequestDispatcher("/admin/addCar.jsp").forward(req, res);
                return;
            }

            // Unknown action
            res.getWriter().println("<h2 style='color:red'>Unknown action: " + action + "</h2>");
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("<h2 style='color:red'>Internal error: " + e.getMessage() + "</h2>");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        CarDAO dao = new CarDAO();
        try {
            String idStr = req.getParameter("car_id");
            String make = req.getParameter("make");
            String model = req.getParameter("model");
            String yearStr = req.getParameter("year");
            String rateStr = req.getParameter("rate");
            String status = req.getParameter("status");

            if (make == null || model == null || yearStr == null || rateStr == null || status == null
                || make.trim().isEmpty() || model.trim().isEmpty() || yearStr.trim().isEmpty() || rateStr.trim().isEmpty() || status.trim().isEmpty()) {
                res.getWriter().println("<h2 style='color:red'>Some required parameters are missing for saving car.</h2>");
                return;
            }

            Car car = new Car();
            car.setMake(make.trim());
            car.setModel(model.trim());
            car.setYear(Integer.parseInt(yearStr.trim()));
            car.setDaily_rate(Double.parseDouble(rateStr.trim()));
            car.setStatus(status.trim());

            if (idStr == null || idStr.trim().isEmpty()) {
                // Add mode
                dao.addCar(car);
            } else {
                // Edit/Update mode
                car.setCar_id(Integer.parseInt(idStr.trim()));
                dao.updateCar(car);
            }
            res.sendRedirect(req.getContextPath() + "/adminCars");
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("<h2 style='color:red'>Car update failed: " + e.getMessage() + "</h2>");
        }
    }
}
