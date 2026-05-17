package com.lms.service;

import java.util.List;

import com.lms.pojo.User;

public interface UserService {
	public User checkLogin(String username , String password);
	public boolean addUser(User user);
	public  List<User> getAllUsersList();
	public User getUserById(Long userId);
	public boolean updateUser(User user);
	public boolean deleteUser(Long userId);
	public boolean emailExists(String email);

}