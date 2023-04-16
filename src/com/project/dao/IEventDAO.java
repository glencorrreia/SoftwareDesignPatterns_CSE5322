package com.project.dao;

import java.util.List;

import com.project.entity.EventParticipation;
import com.project.entity.EventProposal;

public interface IEventDAO {

	EventProposal findEventById(Integer id);

	List<EventProposal> findEventByUserId(Integer userId);
	
	List<EventProposal> findEventByStatus(String status);

	Integer saveOrUpdateEvent(EventProposal event);

	void deleteEvent(EventProposal event);
	
	
}
