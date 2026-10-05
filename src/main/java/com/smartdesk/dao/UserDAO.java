package com.smartdesk.dao;

import java.sql.*;
import java.util.*;
import com.smartdesk.model.User;
import com.smartdesk.util.DBConnection;

public class UserDAO {
    public boolean emailExists(String email){
        String sql="SELECT user_id FROM users WHERE email=?";
        try(Connection c=new DBConnection().getConnection(); PreparedStatement p=c.prepareStatement(sql)){
            p.setString(1,email);
            try(ResultSet r=p.executeQuery()){return r.next();}
        }catch(Exception e){e.printStackTrace();return false;}
    }

    public boolean registerUser(User u){
        String sql="INSERT INTO users(name,email,password,role,department) VALUES(?,?,?,?,?)";
        try(Connection c=new DBConnection().getConnection(); PreparedStatement p=c.prepareStatement(sql)){
            p.setString(1,u.getName()); p.setString(2,u.getEmail()); p.setString(3,u.getPassword());
            p.setString(4,"EMPLOYEE"); p.setString(5,u.getDepartment());
            return p.executeUpdate()>0;
        }catch(Exception e){e.printStackTrace();return false;}
    }

    public User loginUser(String email,String password){
        String sql="SELECT * FROM users WHERE email=? AND password=? AND status='ACTIVE'";
        try(Connection c=new DBConnection().getConnection(); PreparedStatement p=c.prepareStatement(sql)){
            p.setString(1,email); p.setString(2,password);
            try(ResultSet r=p.executeQuery()){if(r.next())return map(r);}
        }catch(Exception e){e.printStackTrace();}
        return null;
    }

    public List<User> getAllUsers(){return query("SELECT * FROM users ORDER BY user_id");}
    public List<User> getEmployees(){return query("SELECT * FROM users WHERE role='EMPLOYEE' AND status='ACTIVE' ORDER BY name");}

    private List<User> query(String sql){
        List<User> list=new ArrayList<>();
        try(Connection c=new DBConnection().getConnection(); PreparedStatement p=c.prepareStatement(sql); ResultSet r=p.executeQuery()){
            while(r.next())list.add(map(r));
        }catch(Exception e){e.printStackTrace();}
        return list;
    }

    private User map(ResultSet r)throws SQLException{
        User u=new User();
        u.setUserId(r.getInt("user_id")); u.setName(r.getString("name")); u.setEmail(r.getString("email"));
        u.setPassword(r.getString("password")); u.setRole(r.getString("role"));
        u.setDepartment(r.getString("department")); u.setStatus(r.getString("status"));
        return u;
    }
}
