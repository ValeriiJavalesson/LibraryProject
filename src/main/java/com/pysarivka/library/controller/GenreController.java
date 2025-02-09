package com.pysarivka.library.controller;

import java.util.List;
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

	@RequestMapping("/addgenre")
	public ModelAndView addgenre() {
		ModelAndView model = new ModelAndView("addgenre");
		List<Genre> allGenres = genreService.findAll();
		model.addObject("allgenres", allGenres);
		return model;
	}

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
	public String saveBook(@ModelAttribute Genre genre) {
		genreService.save(genre);
		return "addgenre";
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
			List<List<Book>> selfs = BookController.getSelfs(sortedBooks);
			Genre genre = books.getFirst().getGenre();

			model.addObject("genre", genre);
			model.addObject("selfs", selfs);
		} else {
			List<Book> sortedBooks = allBooks.stream().sorted((o1, o2) -> o1.getYear().compareTo(o2.getYear()))
					.collect(Collectors.toList());
			List<List<Book>> selfs = BookController.getSelfs(sortedBooks);
			model.addObject("selfs", selfs);
			model.addObject("genre", new Genre("Усі жанри"));
		}

		return model;
	}

	@PostMapping("/delete_genre")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String deleteGenre(@RequestParam("id") Long genreId) {
		Genre emptyGenre = null;
		Optional<Genre> optionalGenre = genreService.findById((long) 1);
		if (optionalGenre.isPresent())
			emptyGenre = optionalGenre.get();
		Genre firstGenre = emptyGenre;
		bookService.findAll().stream().filter(b -> b.getGenre().getId().equals(genreId))
				.forEach(b -> b.setGenre(firstGenre));
		genreService.deleteById(genreId);
		return "addgenre";
	}

}
