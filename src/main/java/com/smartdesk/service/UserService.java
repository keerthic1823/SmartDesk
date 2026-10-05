package com.smartdesk.service;
import java.util.List;import com.smartdesk.dao.UserDAO;import com.smartdesk.model.User;
public class UserService{
 private final UserDAO dao=new UserDAO();
 public boolean registerUser(User u){return !dao.emailExists(u.getEmail())&&dao.registerUser(u);}
 public User loginUser(String e,String p){return dao.loginUser(e,p);}
 public List<User> getAllUsers(){return dao.getAllUsers();}
 public List<User> getEmployees(){return dao.getEmployees();}
}
