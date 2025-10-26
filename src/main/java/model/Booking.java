package model;

import java.sql.Date;

public class Booking {
    private int booking_id, user_id, car_id;
    private Date start_date, end_date;
    private double total_cost;
    private String payment_status; // "pending", "success", "failed"

    public String getPayment_status() { return payment_status; }
    public void setPayment_status(String payment_status) { this.payment_status = payment_status; }

    public int getBooking_id() { return booking_id; }
    public void setBooking_id(int booking_id) { this.booking_id = booking_id; }

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public int getCar_id() { return car_id; }
    public void setCar_id(int car_id) { this.car_id = car_id; }

    public Date getStart_date() { return start_date; }
    public void setStart_date(Date start_date) { this.start_date = start_date; }

    public Date getEnd_date() { return end_date; }
    public void setEnd_date(Date end_date) { this.end_date = end_date; }

    public double getTotal_cost() { return total_cost; }
    public void setTotal_cost(double total_cost) { this.total_cost = total_cost; }
}
