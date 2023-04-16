package com.project.dao;

import com.project.entity.*;


public interface IUserDAO {

    void persistUser(User user);
    
    User findUserById(Integer id);
    
    User findUserByEmail(String email);
    
    User findUserByUserName(String userName);
     
    void saveOrUpdateUser(User user);
     
    void deleteUser(User user);
    
    User findByUserNameAndPassword(String userName,String password);

}
