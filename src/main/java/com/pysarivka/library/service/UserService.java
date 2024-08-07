package com.pysarivka.library.service;

import java.util.List;
import java.util.Optional;

import com.pysarivka.library.domain.User;

public interface UserService {

	Optional<User> findByEmail(String email);

	Optional<User> findById(Long id);

	User saveUser(User user);

	User updateUser(User user);

	void deleteUser(User user);

	List<User> findAllUsers();
}
