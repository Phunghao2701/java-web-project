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
public class OrderDAO {

    public List<Product> getAllProducts() throws Exception {

        List<Product> list = new ArrayList<>();

        Connection conn = DBUtils.getConnection();
        String sql = "SELECT * FROM Product";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){

            String pid = rs.getString("pid");
            String name = rs.getString("name");
            float price = rs.getFloat("price");
            int quantity = rs.getInt("quantity");

            list.add(new Product(pid,name,price,quantity));
        }

        return list;
    }

    public int createOrder(String userID, float total) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void insertOrderDetail(int orderID, String pid, double price, int quantity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void updateProductQuantity(String pid, int quantity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}

