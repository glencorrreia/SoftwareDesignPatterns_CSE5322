package com.project.dao;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.entity.User;

@Repository
public class UserDAOImpl implements IUserDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void persistUser(User user) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().persist(user);
	}

	@Override
	public User findUserById(Integer id) {
		// TODO Auto-generated method stub
				return (User)sessionFactory.getCurrentSession().get(User.class,id);
	}

	@Override
	public void saveOrUpdateUser(User user) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().saveOrUpdate(user);
	}

	@Override
	public void deleteUser(User user) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().delete(user);
	}

	@Override
	public User findUserByEmail(String email) {
		String queryStr = "Select u from User u where u.email=:email";
		Query query = sessionFactory.getCurrentSession().createQuery(queryStr);
		query.setParameter("email", email);
		User user = (User) query.uniqueResult();
		return user;
	}

	@Override
	public User findUserByUserName(String userName) {
		String queryStr = "Select u from User u where u.userName=:userName";
		Query query = sessionFactory.getCurrentSession().createQuery(queryStr);
		query.setParameter("userName", userName);
		User user = (User) query.uniqueResult();		
		return user;
	}

	@Override
	public User findByUserNameAndPassword(String userName, String password) {
		String queryStr = "Select u from User u where u.userName=:userName and u.password=:password";
		Query query = sessionFactory.getCurrentSession().createQuery(queryStr);
		query.setParameter("userName", userName);
		query.setParameter("password", password);
		User user = (User) query.uniqueResult();		
		return user;
	}
	
	

}
