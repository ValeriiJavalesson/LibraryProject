package com.pysarivka.library.service.impl;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pysarivka.library.dao.GenreRepository;
import com.pysarivka.library.domain.Genre;
import com.pysarivka.library.service.GenreService;

@Service
public class GenreServiceImpl implements GenreService {
	private Logger logger = LoggerFactory.getLogger(GenreServiceImpl.class);
	@Autowired
	private GenreRepository genreRepository;

	@Override
	public Genre save(Genre genre) {
		logger.info("Save new genre: " + genre);
		return genreRepository.save(genre);
	}

	@Override
	public Optional<Genre> findById(Long id) {
		logger.info("Get genre by id: " + id);
		return genreRepository.findById(id);
	}

	@Override
	public Optional<List<Genre>> findByName(String name) {
		logger.info("Get genre by name: " + name);
		return genreRepository.findByName(name);
	}

	@Override
	public Genre updateBook(Genre genre) {
		logger.info("Update genre: " + genre);
		return genreRepository.save(genre);
	}

	@Override
	public void deleteById(Long id) {
		logger.info("Delete genre by id: " + id);
		genreRepository.deleteById(id);
	}

	@Override
	public List<Genre> findAll() {
		logger.info("Get all genres");
		return genreRepository.findAll();
	}

}
