package com.pysarivka.library.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.pysarivka.library.domain.Book;
import com.pysarivka.library.domain.Genre;
import com.pysarivka.library.service.impl.BookServiceImpl;
import com.pysarivka.library.service.impl.GenreServiceImpl;

@RestController
public class GenreController {

	@Autowired
	private BookServiceImpl bookService;
	@Autowired
	private GenreServiceImpl genreService;

	@RequestMapping("/newgenre")
	public ModelAndView editgenre(@RequestParam("id") Long id) {
		ModelAndView model = new ModelAndView("newgenre");
		if (id == null)
			return model;
		Genre genre = null;
		Optional<Genre> optionalGenre = genreService.findById(id);
		if (optionalGenre.isPresent()) {
			genre = optionalGenre.get();
			model.addObject("genre", genre);
			return model;
		}
		return model;
	}

	@PostMapping("/save_genre")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String saveBook(@ModelAttribute("genreform") Genre genre) {
		Genre savedGenre = null;
		savedGenre = genreService.save(genre);
		return savedGenre != null ? "books" : "newgenre?id=0";
	}

	@GetMapping("/all_genres")
//	@PreAuthorize("hasAuthority('ROLE_USER')")
	public List<Genre> getAllGenres() {
		List<Genre> all = genreService.findAll();
		return all;
	}

	@GetMapping("/genre")
	public ModelAndView genre(@RequestParam("id") Long genreId) {
		ModelAndView model = new ModelAndView("genre");
		List<Book> allBooks = null;
		allBooks = bookService.findAll();
		if (genreId != null && genreId != 0) {
			List<Book> books = allBooks.stream().filter(b -> b.getGenre().getId().equals(genreId))
					.collect(Collectors.toList());
			List<Book> sortedBooks = books.stream().sorted((o1, o2) -> o1.getYear().compareTo(o2.getYear()))
					.collect(Collectors.toList());
			Genre genre = books.getFirst().getGenre();
			model.addObject("genre", genre);
			model.addObject("books", sortedBooks);
		} else {
			List<Book> sortedBooks = allBooks.stream().sorted((o1, o2) -> o1.getYear().compareTo(o2.getYear()))
					.collect(Collectors.toList());
			model.addObject("books", sortedBooks);
			model.addObject("genre", new Genre("Усі жанри"));
		}

		return model;
	}

}
