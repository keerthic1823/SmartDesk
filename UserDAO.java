package com.smartdesk.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import com.smartdesk.model.User;
import com.smartdesk.util.DBConnection;

public class UserDAO {
	public boolean registerUser(User user) {
		DBConnection dc = new DBConnection();
		Connection con =dc.getConnection();
		try {
		PreparedStatement ps = con.prepareStatement("insert into users(name,email,password,role,department)values(?,?,?,?,?)");
		ps.setString(1,user.getName());
		ps.setString(2,user.getEmail());
		ps.setString(3,user.getPassword());
		ps.setString(4,user.getRole());
		ps.setString(5,user.getDepartment());
		int n = ps.executeUpdate();
		ps.close();
        
		if(n>0) {
			return true;
		}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
return false;				
}
	public boolean emailExists(String email) {

	    boolean status = false;

	    try {

	        Connection con = new DBConnection().getConnection();

	        PreparedStatement ps = con.prepareStatement(
	            "SELECT user_id FROM users WHERE email = ?"
	        );

	        ps.setString(1, email);

	        var rs = ps.executeQuery();

	        if (rs.next()) {
	            status = true;
	        }
	        con.close();

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    return status;
	}
	public User loginUser(String email, String password) {

	    DBConnection dc = new DBConnection();
	    Connection con = dc.getConnection();

	    User user = null;

	    try {

	        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, email);
	        ps.setString(2, password);

	        var rs = ps.executeQuery();

	        if (rs.next()) {

	            user = new User();

	            user.setUserId(rs.getInt("user_id"));
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            user.setRole(rs.getString("role"));
	            user.setDepartment(rs.getString("department"));
	            user.setStatus(rs.getString("status"));
	        }

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    return user;
	}
	public List<User> getAllUsers() {

	    DBConnection dc = new DBConnection();
	    Connection con = dc.getConnection();

	    List<User> users = new ArrayList<>();

	    try {

	        String sql =
	            "SELECT * FROM users ORDER BY user_id";

	        PreparedStatement ps =
	            con.prepareStatement(sql);

	        var rs = ps.executeQuery();

	        while (rs.next()) {

	            User user = new User();

	            user.setUserId(
	                rs.getInt("user_id")
	            );

	            user.setName(
	                rs.getString("name")
	            );

	            user.setEmail(
	                rs.getString("email")
	            );

	            user.setPassword(
	                rs.getString("password")
	            );

	            user.setRole(
	                rs.getString("role")
	            );

	            user.setDepartment(
	                rs.getString("department")
	            );

	            user.setStatus(
	                rs.getString("status")
	            );

	            users.add(user);
	        }

	    } catch (Exception e) {

	        e.printStackTrace();

	    }

	    return users;
	}
}
