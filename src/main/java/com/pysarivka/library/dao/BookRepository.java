package com.pysarivka.library.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pysarivka.library.domain.Book;

public interface BookRepository extends JpaRepository<Book, Long>{
	Optional<Book> findById(Long id);
	Optional<List<Book>> findByName(String name);
	void deleteById(Long id);

}
