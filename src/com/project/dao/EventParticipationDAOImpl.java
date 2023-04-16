package com.project.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.entity.EventParticipation;
import com.project.entity.EventProposal;

@Repository
public class EventParticipationDAOImpl implements IEventParticipationDAO{

	@Autowired
	private SessionFactory sessionFactory;
	


	@Override
	public Integer saveOrUpdateEventParticipation(EventParticipation eventparticipation) {
		sessionFactory.getCurrentSession().saveOrUpdate(eventparticipation);
		return eventparticipation.getId();
	}



	@Override
	public EventParticipation findByEventIdAndUserId(Integer userId, Integer eventId) {
		// TODO Auto-generated method stub
		String queryStr = "Select e from EventParticipation e where e.userId=:userId and e.eventId=:eventId";
		Query query = sessionFactory.getCurrentSession().createQuery(queryStr);
		query.setParameter("userId", userId);
		query.setParameter("eventId", eventId);
		EventParticipation eventParticipation =  (EventParticipation)query.uniqueResult();
		return eventParticipation;
		
		
	}

}
