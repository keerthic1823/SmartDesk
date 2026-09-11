package com.smartdesk.service;

import java.util.List;

import com.smartdesk.dao.UserDAO;
import com.smartdesk.model.User;

public class UserService {
	 private final UserDAO userDAO = new UserDAO();

	 public boolean registerUser(User user) {

		    if (userDAO.emailExists(user.getEmail())) {

		        return false;
		    }

		    return userDAO.registerUser(user);
		}
	 public User loginUser(String email, String password) {

		    return userDAO.loginUser(email, password);

		}
	 public List<User> getAllUsers() {

		    return userDAO.getAllUsers();

		}
}
