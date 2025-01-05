package com.pysarivka.library.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.pysarivka.library.domain.Genre;
import com.pysarivka.library.service.impl.GenreServiceImpl;

@RestController
public class GenreController {

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

}
