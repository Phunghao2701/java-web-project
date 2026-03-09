/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fa26.t2s2.shopping;

import fa26.t2s2.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
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

        String sql = "SELECT pid, name, price, quantity FROM Product WHERE quantity > 0";

        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                String pid = rs.getString("pid");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");

                list.add(new Product(pid, name, price, quantity));
            }
        }
        return list;
    }

    public void insertOrderDetail(int orderID, String pid, double price, int quantity) throws Exception {
        String sql = "INSERT INTO OrderDetail(oid, pid, price, quantity) VALUES(?,?,?,?)";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ps.setInt(2, Integer.parseInt(pid));
            ps.setDouble(3, price);
            ps.setInt(4, quantity);
            ps.executeUpdate();
        }
    }

    public boolean updateProductQuantity(String pid, int quantity) throws Exception {
        String sql = "UPDATE Product SET quantity = quantity - ? WHERE pid = ? AND quantity >= ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, Integer.parseInt(pid));
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        }
    }

    public Product getProductById(String pid) throws Exception {
        String sql = "SELECT pid, name, price, quantity FROM Product WHERE pid = ?";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(pid));
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getString("pid"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getInt("quantity")
                    );
                }
            }
        }
        return null;
    }

    public int createOrder(String userID, float total) throws Exception {
        String sql = "INSERT INTO Orders(date, total, userID) OUTPUT INSERTED.oid VALUES(?,?,?)";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, new Date(System.currentTimeMillis()));
            ps.setFloat(2, total);
            ps.setString(3, userID);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
}
