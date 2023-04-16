package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.dto.PaymentDTO;
import com.project.dto.Response;
import com.project.entity.EventParticipation;
import com.project.entity.EventProposal;
import com.project.entity.Payment;
import com.project.entity.User;
import com.project.service.IEventService;
import com.project.service.IPaymentService;
import com.project.service.IUserService;
import com.project.util.EmailUtil;

@Controller
public class PaymentController {


	@Autowired
	IEventService iEventService;
	
	@Autowired
	IPaymentService iPaymentService;
	
	@Autowired
	IUserService iUserService;
	
	@GetMapping("/payment")
    public ModelAndView EventProposal(@RequestParam Integer eventId,@RequestParam String page) {
		
        return new ModelAndView("payment");
    }
	
	@ResponseBody
	@PostMapping(value = "/submitPayment")
	public Response submitEventProposal(@RequestBody PaymentDTO paymentDto) {
		Response response = new Response();

		System.out.println("card name " + paymentDto.getCardname());
		Payment payment =new Payment();
		payment.setCardname(paymentDto.getCardname());
		payment.setCardnum(paymentDto.getCardnum());
		payment.setCvv(paymentDto.getCvv());
		payment.setExpirydate(paymentDto.getExpirydate());
		payment.setUserId(paymentDto.getUserId());
		Integer paymentId=iPaymentService.saveOrUpdatePayment(payment);
		System.out.println(paymentDto.getPage());
		if(paymentDto.getPage().equalsIgnoreCase("proposal")) {
			EventProposal eventProposal=iEventService.findEventById(paymentDto.getEventId());
			eventProposal.setStatus("Pending Review");
			eventProposal.setPaymentId(paymentId);
			iEventService.saveOrUpdateEvent(eventProposal);			
		}else {
			EventParticipation eventParticipation=iEventService.findEventParticipationByEventIdAndUserId(paymentDto.getUserId(),paymentDto.getEventId());
			eventParticipation.setPaymentId(paymentId);
			iEventService.saveOrUpdateEventParticipation(eventParticipation);
		}

		
		User user=iUserService.findUserById(paymentDto.getUserId());
		EmailUtil emailUtil=new EmailUtil();
		emailUtil.sendPaymentConfirmationEmail(user.getEmail(),user.getFirstName());
	    response.setStatus(1);				
	    response.setResponse("Successfully made Payment.");
	    
		return response;
	}

}
