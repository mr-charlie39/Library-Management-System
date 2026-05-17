package com.lms.servicelmpl;

import java.util.List;

import com.lms.dao.UserDao;
import com.lms.daolmpl.UserDaolmpl;
import com.lms.pojo.User;
import com.lms.service.UserService;

public class UserServiceImpl implements UserService {
	UserDao userDao = new UserDaolmpl();

	
	public User checkLogin(String username ,String  password) {
		
		return userDao.checkLogin(username , password);
		
	}


	@Override
	public boolean addUser(User user) {
		// TODO Auto-generated method stub
		return userDao.addUser(user);
	}


	@Override
	public List<User> getAllUsersList() {
		// TODO Auto-generated method stub
		return userDao.getAllUsersList();
	}


	@Override
	public User getUserById(Long userId) {
		// TODO Auto-generated method stub
		return userDao.getUserById(userId);
	}


	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return userDao.updateUser(user);
	}

	@Override
	public boolean deleteUser(Long userId) {
		// TODO Auto-generated method stub
		return userDao.deleteUser(userId);
	}

	@Override
	public boolean emailExists(String email) {
		return userDao.emailExists(email);
	}
}