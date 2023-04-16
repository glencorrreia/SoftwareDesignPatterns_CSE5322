package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.IEventDAO;
import com.project.dao.IEventParticipationDAO;
import com.project.entity.EventParticipation;
import com.project.entity.EventProposal;

@Service
@Qualifier("iEventService")
@Transactional
public class EventServiceImpl implements IEventService{

	@Autowired
	IEventDAO eventDAO;
	
	@Autowired
	IEventParticipationDAO eventParticipationDAO;
	
	@Override
	public EventProposal findEventById(Integer id) {
		// TODO Auto-generated method stub
		return eventDAO.findEventById(id);
	}

	@Override
	public List<EventProposal> findEventByUserId(Integer userId) {
		// TODO Auto-generated method stub
		return eventDAO.findEventByUserId(userId);
	}

	@Override
	public Integer saveOrUpdateEvent(EventProposal event) {
		// TODO Auto-generated method stub
		return eventDAO.saveOrUpdateEvent(event);
	}

	@Override
	public void deleteEvent(EventProposal event) {
		// TODO Auto-generated method stub
		eventDAO.deleteEvent(event);
	}

	@Override
	public List<EventProposal> findEventByStatus(String status) {
		// TODO Auto-generated method stub
		return eventDAO.findEventByStatus(status);
	}

	@Override
	public Integer saveOrUpdateEventParticipation(EventParticipation eventparticipation) {
		// TODO Auto-generated method stub
		return eventParticipationDAO.saveOrUpdateEventParticipation(eventparticipation);
	}

	@Override
	public EventParticipation findEventParticipationByEventIdAndUserId(Integer userId,Integer eventId) {
		// TODO Auto-generated method stub
		return eventParticipationDAO.findByEventIdAndUserId(userId, eventId);
	}

}
