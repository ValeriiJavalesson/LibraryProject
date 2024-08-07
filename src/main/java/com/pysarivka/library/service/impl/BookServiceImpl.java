package com.pysarivka.library.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pysarivka.library.dao.BookRepository;
import com.pysarivka.library.domain.Book;
import com.pysarivka.library.service.BookService;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BookServiceImpl implements BookService {

	private final BookRepository bookRepository;

	@Override
	public Book saveBook(Book book) {
		System.out.println("Saved book: " + book.getName());
		return bookRepository.save(book);
	}

	@Override
	public Optional<Book> findById(Long id) {
		return bookRepository.findById(id);
	}

	@Override
	public Optional<List<Book>> findByName(String name) {
		return bookRepository.findByName(name);
	}

	@Override
	public Book updateBook(Book book) {
		return bookRepository.save(book);
	}

	@Override
	@Transactional
	public void deleteById(Long id) {
		bookRepository.deleteById(id);
	}

	@Override
	public List<Book> findAll() {
		return bookRepository.findAll();
	}

}
