package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.IEventDAO;
import com.project.dao.IPaymentDAO;
import com.project.entity.Payment;

@Service
@Qualifier("iPaymentService")
@Transactional
public class PaymentServiceImpl implements IPaymentService{

	@Autowired
	IPaymentDAO paymentDAO;
	
	@Override
	public Integer saveOrUpdatePayment(Payment payment) {
		// TODO Auto-generated method stub
		 
		 return paymentDAO.saveOrUpdatePayment(payment);
	}

}
