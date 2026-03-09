/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fa26.t2s2.shopping;

import fa26.t2s2.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class Product {
    private String pid;
    private String name;
    private double price;
    private int quantity;

    public Product() {}

    public Product(String pid, String name, double price, int quantity) {
        this.pid = pid;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    // getter setter

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public List<Product> getListProduct() throws Exception {

    List<Product> list = new ArrayList<>();

    Connection conn = DBUtils.getConnection();

    String sql = "SELECT pid, pname, price, quantity FROM Product";

    PreparedStatement ps = conn.prepareStatement(sql);

    ResultSet rs = ps.executeQuery();

    while(rs.next()){

        String id = rs.getString("pid");
        String name = rs.getString("pname");
        float price = rs.getFloat("price");
        int quantity = rs.getInt("quantity");

        list.add(new Product(id,name,price,quantity));
    }

    return list;
}
}