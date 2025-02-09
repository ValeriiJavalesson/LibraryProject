package com.pysarivka.library.service;

import java.util.List;
import java.util.Optional;

import com.pysarivka.library.domain.Genre;

public interface GenreService {
	
	Genre save(Genre genre);
	Optional<Genre> findById(Long id);
	Optional<List<Genre>> findByName(String name);
	Genre updateBook(Genre genre);
	void deleteById(Long id);
	List<Genre> findAll();

}
