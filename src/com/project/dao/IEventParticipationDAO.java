package com.project.dao;

import com.project.entity.EventParticipation;

public interface IEventParticipationDAO {

	Integer saveOrUpdateEventParticipation(EventParticipation eventparticipation);
	
	EventParticipation findByEventIdAndUserId(Integer userId,Integer eventId);
}
