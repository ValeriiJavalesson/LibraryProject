package com.pysarivka.library.service;

import java.util.List;
import java.util.Optional;

import com.pysarivka.library.domain.Book;

public interface BookService {
	Book saveBook(Book book);
	Optional<Book> findById(Long id);
	Optional<List<Book>> findByName(String name);
	Book updateBook(Book book);
	void deleteById(Long id);
	List<Book> findAll();
}
