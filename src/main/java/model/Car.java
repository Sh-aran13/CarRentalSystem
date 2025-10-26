package model;

public class Car {
    private int car_id;
    private String make, model, status;
    private int year;
    private double daily_rate;

    public int getCar_id() { return car_id; }
    public void setCar_id(int car_id) { this.car_id = car_id; }

    public String getMake() { return make; }
    public void setMake(String make) { this.make = make; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public double getDaily_rate() { return daily_rate; }
    public void setDaily_rate(double daily_rate) { this.daily_rate = daily_rate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
