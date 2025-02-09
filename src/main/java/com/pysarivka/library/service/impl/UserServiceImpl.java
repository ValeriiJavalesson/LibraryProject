package com.pysarivka.library.service.impl;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.pysarivka.library.dao.UserRepository;
import com.pysarivka.library.domain.User;
import com.pysarivka.library.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	private Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public Optional<User> findByEmail(String email) {
		logger.info("Get user by email: " + email);
		return userRepository.findByEmail(email);
	}

	@Override
	public Optional<User> findById(Long id) {
		logger.info("Get user by id: " + id);
		return userRepository.findById(id);
	}

	@Override
	public User saveUser(User user) {
		logger.info("Register new user : " + user);
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		return userRepository.save(user);
	}

	@Override
	public User updateUser(User user) {
		logger.info("Updated user : " + user);
		return userRepository.save(user);
	}

	@Override
	public void deleteUser(User user) {
		logger.info("Deleted user : " + user);
		userRepository.delete(user);
	}

	@Override
	public List<User> findAllUsers() {
		logger.info("Get all users");
		return userRepository.findAll();
	}

}
