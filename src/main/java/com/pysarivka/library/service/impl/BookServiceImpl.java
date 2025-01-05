package com.pysarivka.library.service.impl;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pysarivka.library.dao.BookRepository;
import com.pysarivka.library.domain.Book;
import com.pysarivka.library.service.BookService;

@Service
public class BookServiceImpl implements BookService {
	private Logger logger = LoggerFactory.getLogger(BookServiceImpl.class);
	@Autowired
	private BookRepository bookRepository;

	@Override
	public Book saveBook(Book book) {
		logger.info("Save new book: " + book);
		return bookRepository.save(book);
	}

	@Override
	public Optional<Book> findById(Long id) {
		logger.info("Get book by id: " + id);
		return bookRepository.findById(id);
	}

	@Override
	public Optional<List<Book>> findByName(String name) {
		logger.info("Get book by name: " + name);
		return bookRepository.findByName(name);
	}

	@Override
	public Book updateBook(Book book) {
		logger.info("Update book: " + book);
		return bookRepository.save(book);
	}

	@Override
	@Transactional
	public void deleteById(Long id) {
		logger.info("Delete book by id: " + id);
		bookRepository.deleteById(id);
	}

	@Override
	public List<Book> findAll() {
		logger.info("Get all books");
		return bookRepository.findAll();
	}

}
