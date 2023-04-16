package com.project.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.entity.EventParticipation;
import com.project.entity.EventProposal;

@Repository
public class EventDAOImpl implements IEventDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public EventProposal findEventById(Integer id) {
		
		return (EventProposal)sessionFactory.getCurrentSession().get(EventProposal.class,id);
	}

	@Override
	public List<EventProposal> findEventByUserId(Integer userId) {
		String queryStr = "Select e from EventProposal e where e.userId=:userId";
		Query query = sessionFactory.getCurrentSession().createQuery(queryStr);
		query.setParameter("userId", userId);
		List<EventProposal> eventlist =  query.getResultList();
		
		return eventlist;
	}

	@Override
	public Integer saveOrUpdateEvent(EventProposal event) {
		sessionFactory.getCurrentSession().saveOrUpdate(event);
		return event.getId();
	}

	@Override
	public void deleteEvent(EventProposal event) {
		sessionFactory.getCurrentSession().delete(event);
		
	}

	@Override
	public List<EventProposal> findEventByStatus(String status) {
		
		String queryStr = "Select e from EventProposal e where e.status=:status";
		Query query = sessionFactory.getCurrentSession().createQuery(queryStr);
		query.setParameter("status", status);
		List<EventProposal> eventlist =  query.getResultList();
		return eventlist;
	}

	


	    
}
