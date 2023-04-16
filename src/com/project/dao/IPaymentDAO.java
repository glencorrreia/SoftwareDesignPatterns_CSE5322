package com.project.dao;

import com.project.entity.Payment;

public interface IPaymentDAO {

	Integer saveOrUpdatePayment(Payment payment);
}
