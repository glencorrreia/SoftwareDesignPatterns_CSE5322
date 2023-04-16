package com.project.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.dto.Response;
import com.project.dto.UserDTO;
import com.project.entity.User;
import com.project.service.IUserService;
import com.project.util.EmailUtil;

@Controller
public class CreateAccountController {

	@Autowired
	IUserService iUserService;

	@ResponseBody
	@PostMapping(value = "/adduser")
	public Response registerUser(@RequestBody UserDTO userdto) {
		Response response = new Response();

		System.out.println("username " + userdto.getUserName());
		User user = iUserService.findUserByEmail(userdto.getEmail());
		if (user != null) {
			response.setStatus(0);
			response.setResponse("Email already exsists");
		} else {
			User user1 = iUserService.findUserByUserName(userdto.getUserName());
			if (user1 != null) {
				response.setStatus(0);
				response.setResponse("Username already exsists.Please select another one.");
			} else {
				Random r = new Random();
				Integer num = r.nextInt(1000) + 1;
				EmailUtil emailutil = new EmailUtil();

				emailutil.sendWelcomeEmail(userdto.getEmail(), num.toString(),
						userdto.getFirstName() + " " + userdto.getLastName());

				User userObj = new User();
				userObj.setEmail(userdto.getEmail());
				userObj.setUserName(userdto.getUserName());
				userObj.setFirstName(userdto.getFirstName());
				userObj.setLastName(userdto.getLastName());
				userObj.setPassword(num.toString());
				userObj.setUserType(userdto.getUserType());
				userObj.setFirstlogin(true);
				iUserService.saveOrUpdateUser(userObj);
				response.setStatus(1);
				response.setResponse("User Added");
			}
		}

		return response;// new ModelAndView("checkuser");
	}

	@GetMapping("/registration")
	public ModelAndView registration() {
		String message = "";
		return new ModelAndView("registration", "message", message);
	}

	@GetMapping("/changepwd")
	public ModelAndView changepwd() {
		return new ModelAndView("changepwd");
	}

	@ResponseBody
	@PostMapping(value = "/updatepwd")
	public Response resetPwd(@RequestParam String uname, @RequestParam String password) {
		Response response = new Response();
		User user = iUserService.findUserByUserName(uname);
		if (user == null) {
			response.setStatus(0);
			response.setResponse("Wrong Username");
		} else {
			user.setPassword(password);
			user.setFirstlogin(false);
			iUserService.saveOrUpdateUser(user);
			response.setStatus(1);
			response.setResponse("Password Updated Successfully");
			response.setData(user);
		}
		System.out.println("username " + uname);
		return response;
	}
}
