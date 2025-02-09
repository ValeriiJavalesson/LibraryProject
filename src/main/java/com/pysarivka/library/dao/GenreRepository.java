package com.pysarivka.library.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pysarivka.library.domain.Genre;

public interface GenreRepository extends JpaRepository<Genre, Long>{
	Optional<Genre> findById(Long id);
	Optional<List<Genre>> findByName(String name);
	void deleteById(Long id);

}
