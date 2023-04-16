package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.dto.Response;
import com.project.entity.User;
import com.project.service.IUserService;

@Controller
public class AuthenticationController {

	@Autowired
	IUserService iUserService;

	@ResponseBody
	@PostMapping(value="/checkuser")
    public Response verifyLogin(@RequestParam String uname,@RequestParam String password) {
		Response response =new Response();
		User user=iUserService.findByUserNameAndPassword(uname, password);
		if(user==null) {
        	response.setStatus(0);
        	response.setResponse("Wrong Username/Password");			
		}else {
			response.setStatus(1);
			response.setResponse("Successfull login");
			response.setData(user);
		}
        System.out.println("username "+uname);
        return response;
    }
	
	@GetMapping("/login")
    public ModelAndView login() {

        return new ModelAndView("login");
    }

}
