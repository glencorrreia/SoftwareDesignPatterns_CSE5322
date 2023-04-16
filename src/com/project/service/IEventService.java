package com.project.service;

import java.util.List;

import com.project.entity.EventParticipation;
import com.project.entity.EventProposal;

public interface IEventService {
	
	EventProposal findEventById(Integer id);

	List<EventProposal> findEventByUserId(Integer userId);
	
	List<EventProposal> findEventByStatus(String status);

	Integer saveOrUpdateEvent(EventProposal event);

	void deleteEvent(EventProposal event);
	
	Integer saveOrUpdateEventParticipation(EventParticipation eventparticipation);

	EventParticipation findEventParticipationByEventIdAndUserId(Integer userId,Integer eventId);
}
