package com.project.service;

import com.project.entity.User;


public interface IUserService {
	
void persistUser(User user);
    
    User findUserById(Integer id);
    
    User findUserByEmail(String email);
    
    User findUserByUserName(String username);
    
    User findByUserNameAndPassword(String userName,String password);
     
    void saveOrUpdateUser(User user);
     
    void deleteUser(User user);
    

}
