package com.pysarivka.library.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.pysarivka.library.domain.User;
import com.pysarivka.library.domain.UserRole;
import com.pysarivka.library.service.impl.UserServiceImpl;

@RestController
public class UserController {

	@Autowired
	private UserServiceImpl userServiceImpl;

	

	@GetMapping("/logout")
	public String logout(String url) {
		System.out.println(url);
		return url;
	}

	@RequestMapping("/registration")
//	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public ModelAndView registration() {
		ModelAndView model = new ModelAndView("registration");
		return model;
	}

//	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/registration")
	public String saveUser(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
		if (bindingResult.hasErrors()) {
			return "registration";
		}
		Optional<User> optionalUser = userServiceImpl.findByEmail(userForm.getEmail());
		if (optionalUser.isPresent()) {
			return "registration?message=ispresent";
		}
		userForm.setRole(UserRole.ROLE_USER);
		User user = userServiceImpl.saveUser(userForm);

		userServiceImpl.updateUser(user);
		return "login?registered=succesfully";
	}



	@GetMapping("/isUserPresent")
	public boolean isUserPresent(@RequestParam String email) {
		Optional<User> optionalUser = userServiceImpl.findByEmail(email);
		return optionalUser.isPresent();
	}

}
