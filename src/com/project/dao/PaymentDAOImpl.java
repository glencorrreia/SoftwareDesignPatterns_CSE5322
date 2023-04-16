package com.project.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.entity.Payment;

@Repository
public class PaymentDAOImpl implements IPaymentDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public Integer saveOrUpdatePayment(Payment payment) {
		sessionFactory.getCurrentSession().saveOrUpdate(payment);
		return payment.getId();
	}

	
}
