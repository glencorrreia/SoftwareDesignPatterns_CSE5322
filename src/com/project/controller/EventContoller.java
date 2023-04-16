package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.dto.EventParticipationDTO;
import com.project.dto.EventProposalDTO;
import com.project.dto.Response;
import com.project.entity.EventParticipation;
import com.project.entity.EventProposal;
import com.project.entity.User;
import com.project.service.IEventService;
import com.project.service.IUserService;
import com.project.util.EmailUtil;

@Controller
public class EventContoller {


	@Autowired
	IUserService iUserService;
	

	@Autowired
	IEventService iEventService;
	
	@GetMapping("/eventorganizer")
    public ModelAndView organizerhome(@RequestParam Integer userId) {
		List<EventProposal> eventList=iEventService.findEventByUserId(userId);
        return new ModelAndView("eventorganizer","eventlist",eventList);
    }

	@GetMapping("/staffhome")
    public ModelAndView staffhome(@RequestParam Integer userId) {
		List<EventProposal> eventList=iEventService.findEventByStatus("Pending Review");
        return new ModelAndView("staffhome","eventlist",eventList);
    }
	
	@GetMapping("/reviewEvent")
    public ModelAndView reviewEvent(@RequestParam Integer eventId) {
		EventProposal event=iEventService.findEventById(eventId);
        return new ModelAndView("reviewEvent","event",event);
    }
	
	@ResponseBody
	@PostMapping("/submitEventReview")
	public Response submitEventReview(@RequestBody EventProposalDTO eventProposaldto) {
		Response response = new Response();
		
		
		
		EmailUtil emailutil = new EmailUtil();
		EventProposal event=iEventService.findEventById(eventProposaldto.getId());
		
		event.setFeedback(eventProposaldto.getFeedback());
		event.setReviewedBy(eventProposaldto.getReviewedBy());
		event.setStatus(eventProposaldto.getStatus());
		
		User user = iUserService.findUserById(event.getUserId());
		
		emailutil.sendStatuChangeEmail(user.getEmail(),eventProposaldto.getStatus() , eventProposaldto.getFeedback(), user.getFirstName());
		iEventService.saveOrUpdateEvent(event);
		response.setStatus(1);
		response.setResponse("Your review submitted.");
		return response;
	}

	@GetMapping("/eventProposal")
    public ModelAndView EventProposal() {
		
        return new ModelAndView("eventProposal");
    }
	
	@ResponseBody
	@PostMapping(value = "/submitEventProposal")
	public Response submitEventProposal(@RequestBody EventProposalDTO eventProposaldto) {
		Response response = new Response();

		System.out.println("username " + eventProposaldto.getName());
		User user = iUserService.findUserById(eventProposaldto.getUserId());
					
		EmailUtil emailutil = new EmailUtil();

		EventProposal eventProposal=new EventProposal();
		eventProposal.setName(eventProposaldto.getName());
		eventProposal.setDetail(eventProposaldto.getDetail());
		eventProposal.setDuration(eventProposaldto.getDuration());
		eventProposal.setDate(eventProposaldto.getDate());
		eventProposal.setLocation(eventProposaldto.getLocation());
		eventProposal.setSlogan(eventProposaldto.getSlogan());
		eventProposal.setStatus("Submitted");
		eventProposal.setUserId(eventProposaldto.getUserId());
		Integer eventId=iEventService.saveOrUpdateEvent(eventProposal);
	    emailutil.sendPaymentEmail(user.getEmail(), "100","http://localhost:8080/Project-0.0.1-SNAPSHOT/payment?eventId="+eventId+"&page=proposal", user.getFirstName());

	    response.setStatus(1);				
	    response.setResponse("Event Added");
	    response.setData(eventProposal);
		return response;
	}
	
	@GetMapping("/participanthome")
    public ModelAndView displayParticipantHome(@RequestParam Integer userId) {
		List<EventProposal> eventList=iEventService.findEventByStatus("Accept");
        return new ModelAndView("participanthome","eventlist",eventList);
    }
	
	@ResponseBody
	@PostMapping(value = "/registerParticipant")
	public Response registerParticipant(@RequestBody EventParticipationDTO eventParticipationDTO) {
		Response response = new Response();
		EventParticipation eventParticipation1=iEventService.findEventParticipationByEventIdAndUserId(eventParticipationDTO.getUserId(), eventParticipationDTO.getEventId());
		if(eventParticipation1!=null) {
			response.setStatus(0);
			response.setResponse("Already Registered for event");
		}else {
			EventParticipation eventParticipation=new EventParticipation();
			eventParticipation.setEventId(eventParticipationDTO.getEventId());
			eventParticipation.setUserId(eventParticipationDTO.getUserId());
			iEventService.saveOrUpdateEventParticipation(eventParticipation);
			response.setStatus(1);
			response.setResponse("Event participation submitted");
		}

		return response;
	}
}
