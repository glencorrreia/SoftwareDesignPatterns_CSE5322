package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.IUserDAO;
import com.project.entity.User;

@Service
@Qualifier("iUserService")
@Transactional
public class UserServiceImpl implements IUserService{

	@Autowired
	IUserDAO userDAO;
	
	@Override
	public void persistUser(User user) {
		// TODO Auto-generated method stub
		userDAO.persistUser(user);
	}

	@Override
	public User findUserById(Integer id) {
		// TODO Auto-generated method stub
		return userDAO.findUserById(id);
	}

	@Override
	public void saveOrUpdateUser(User user) {
		// TODO Auto-generated method stub
		userDAO.saveOrUpdateUser(user);
	}

	@Override
	public void deleteUser(User user) {
		// TODO Auto-generated method stub
		userDAO.deleteUser(user);
	}

	@Override
	public User findUserByEmail(String email) {
		// TODO Auto-generated method stub
		return userDAO.findUserByEmail(email);
	}

	@Override
	public User findUserByUserName(String username) {
		// TODO Auto-generated method stub
		return userDAO.findUserByUserName(username);
	}

	@Override
	public User findByUserNameAndPassword(String userName, String password) {
		// TODO Auto-generated method stub
		return userDAO.findByUserNameAndPassword(userName, password);
	}

	

}
