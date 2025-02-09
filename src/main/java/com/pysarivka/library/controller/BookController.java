package com.pysarivka.library.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.pysarivka.library.domain.Book;
import com.pysarivka.library.domain.Genre;
import com.pysarivka.library.dto.BookDto;
import com.pysarivka.library.service.impl.BookServiceImpl;
import com.pysarivka.library.service.impl.GenreServiceImpl;

@RestController
public class BookController {
	
	@Autowired
	private BookServiceImpl bookService;
	@Autowired
	private GenreServiceImpl genreService;

	@RequestMapping("/")
	public ModelAndView init() {
		return home();
	}

	@RequestMapping("/books")
	public ModelAndView books() {
		String[] sections = {};
		return allbooks((int) 1, "", (int) 0, sections);
	}

	@RequestMapping("/login")
	public ModelAndView login() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		ModelAndView model = new ModelAndView("login");
		if (principal instanceof UserDetails) {
			return home();
		}
		return model;
	}

	@GetMapping("/welcome")
	public String welcome() {
		return "Welcome Page...";
	}

	@GetMapping("/get_book/{id}")
//	@PreAuthorize("hasAuthority('ROLE_USER')")
	public Book getByName(@PathVariable Long id) {
		Book book = null;
		if (id != null) {
			Optional<Book> optionalBook = bookService.findById(id);
			if (optionalBook.isPresent()) {
				book = optionalBook.get();
			}
		}
		return book;
	}

	@RequestMapping("/newbook")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public ModelAndView editbook(@RequestParam("id") Long id) {

		ModelAndView model = new ModelAndView("newbook");
		model.addObject("genres", genreService.findAll());
		model.addObject("username", getUser());
		if (id == null)
			return model;
		Book book = null;
		Optional<Book> optionalBook = bookService.findById(id);
		if (optionalBook.isPresent()) {
			book = optionalBook.get();
			model.addObject("book", book);
			return model;
		}
		return model;
	}

	@PostMapping("/save_book")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String saveBook(@ModelAttribute("bookform") Book bookform) {
		Book savedBook = bookService.saveBook(bookform);
		return "book?id=" + savedBook.getId().toString();
	}

	@PostMapping("/book_section")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String changeBookSection(@ModelAttribute Book book) {
		Book savedbook = null;
		Optional<Book> optionalBook = bookService.findById(book.getId());
		if (optionalBook.isPresent()) {
			savedbook = optionalBook.get();
			if (book.getChildhood() != null)
				savedbook.setChildhood(book.getChildhood());
			if (book.getClosedSection() != null)
				savedbook.setClosedSection(book.getClosedSection());
			bookService.updateBook(savedbook);
			return "success";
		}
		return "error";
	}

	@GetMapping("/book")
	public ModelAndView openBook(@RequestParam("id") Long id) {
		ModelAndView model = new ModelAndView("book");
		model.addObject("username", getUser());
		Book book = null;
		Optional<Book> optionalBook = bookService.findById(id);
		if (optionalBook.isPresent()) {
			book = optionalBook.get();
			model.addObject("book", book);
			return model;
		}
		return home();
	}

	@GetMapping("/home")
	public ModelAndView home() {
		ModelAndView model = new ModelAndView("home");
		List<Book> allBooks = null;
		allBooks = bookService.findAll();
		Map<Genre, List<Book>> allgenres = allBooks.stream().filter(b -> !b.getGenre().getId().equals((long) 1))
				.collect(Collectors.groupingBy(Book::getGenre, Collectors.toList()));
		allgenres.entrySet().stream()
				.forEach(entry -> entry.setValue(entry.getValue().stream().limit((long) 20).toList()));
		List<Book> randomBooks = new ArrayList<Book>();
		while (randomBooks.size() < 12) {
			int randomNumber = (int) (Math.random() * (allBooks.size() - 0));
			Book book = allBooks.get(randomNumber);
			if (!randomBooks.contains(book))
				randomBooks.add(book);
		}		
		model.addObject("allgenres", allgenres);
		model.addObject("allbooks", randomBooks);
		model.addObject("username", getUser());
		return model;
	}

	@GetMapping("/searchl")
	public ModelAndView searchByLetter(@RequestParam String word) {
		ModelAndView model = new ModelAndView("search");
		model.addObject("searchedword", word);
		List<Book> allBooks = bookService.findAll();
		Predicate<Book> nameNumberPredicate = b -> Character.isDigit(b.getName().toLowerCase().charAt(0));
		Predicate<Book> namePredicate = b -> b.getName().toLowerCase().startsWith(word.toLowerCase());
		List<Book> filteredBooks;
		if (word.equals("0")) {
			model.addObject("searchedword", "#");
			filteredBooks = allBooks.stream().filter(nameNumberPredicate).collect(Collectors.toList());
		} else
			filteredBooks = allBooks.stream().filter(namePredicate).collect(Collectors.toList());
		List<List<Book>> selfs = getSelfs(filteredBooks);

		model.addObject("username", getUser());
		model.addObject("selfs", selfs);
		return model;
	}

	@GetMapping("/searchw")
	public ModelAndView searchByWord(@RequestParam String word) {
		ModelAndView model = new ModelAndView("search");
		Predicate<Book> namePredicate = b -> String.valueOf(b.getName()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> authorPredicate = b -> String.valueOf(b.getAuthor()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> notesPredicate = b -> String.valueOf(b.getNotes()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> yearPredicate = b -> String.valueOf(b.getYear()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> editionPredicate = b -> String.valueOf(b.getEdition()).toLowerCase()
				.contains(word.toLowerCase());
		Predicate<Book> langPredicate = b -> String.valueOf(b.getLanguage()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> regNumberPredicate = b -> String.valueOf(b.getRegistrationNumber()).toLowerCase()
				.contains(word.toLowerCase());
		List<Book> allBooks = bookService.findAll();
		List<Book> filteredBooks = allBooks.stream().filter(namePredicate.or(authorPredicate).or(notesPredicate)
				.or(yearPredicate).or(editionPredicate).or(langPredicate).or(regNumberPredicate))
				.collect(Collectors.toList());
		List<List<Book>> selfs = getSelfs(filteredBooks);
		model.addObject("searchedword", word);
		model.addObject("username", getUser());
		model.addObject("selfs", selfs);
		return model;
	}

	public static List<List<Book>> getSelfs(List<Book> books) {
		List<List<Book>> selfs = new ArrayList<List<Book>>();
		books.forEach((book) -> {
			if (selfs.size() == 0)
				selfs.add(new ArrayList<Book>());
			List<Book> lastSelf = selfs.getLast();
			int sum = lastSelf.stream().mapToInt((b) -> {
				if (b.getNumberOfPages() < 100)
					return 100;
				return b.getNumberOfPages();

			}).sum();
			if (sum >= 4000)
				selfs.add(new ArrayList<Book>());
			lastSelf = selfs.getLast();
			lastSelf.add(book);
		});

		return selfs;
	}

	@GetMapping("/allbooks")
	public ModelAndView allbooks(@RequestParam Integer page, @RequestParam String word, @RequestParam int genreId,
			@RequestParam String[] sections) {
		List<Genre> allGenres = genreService.findAll();
		ModelAndView model = new ModelAndView("allbooks");
		List<Book> allBooks = null;
		allBooks = getAllBooks(word);
		List<Book> filteredBooks = new ArrayList<Book>();

		if (genreId != 0) {
			Genre genre = allGenres.stream().filter(g -> g.getId().equals((long) genreId)).findFirst().orElse(null);
			if (genre != null) {
				filteredBooks = allBooks.stream().filter(b -> b.getGenre().getId().equals(genre.getId()))
						.collect(Collectors.toList());
				model.addObject("genreId", genre.getId());
			} else {
				model.addObject("genreId", 0);
				filteredBooks = allBooks;
			}
		} else {
			model.addObject("genreId", 0);
			filteredBooks = allBooks;
		}

		if (sections.length > 0) {
			for (int i = 0; i < sections.length; i++) {
				switch (sections[i]) {
				case "childhood": {
					filteredBooks = filteredBooks.stream().filter(b -> b.getChildhood() != null && b.getChildhood())
							.collect(Collectors.toList());
					break;
				}
				case "closedSection": {
					filteredBooks = filteredBooks.stream()
							.filter(b -> b.getClosedSection() != null && b.getClosedSection())
							.collect(Collectors.toList());
					break;
				}

				}
			}
		}

		List<Book> sortedBooks = filteredBooks.stream().sorted((o1, o2) -> o1.getYear().compareTo(o2.getYear()))
				.collect(Collectors.toList());
		int booksInPage = sortedBooks.size() > 500 ? 500 : sortedBooks.size();
		double numberOfPages = Math.ceil((double) sortedBooks.size() / (double) booksInPage);
		List<Book> sublist;
		if (page != null && page > 0 && page <= numberOfPages) {
			int startIndex = booksInPage * (page - 1);
			int endIndex = booksInPage * (page - 1) + booksInPage;
			if (endIndex > sortedBooks.size())
				endIndex = sortedBooks.size();
			sublist = sortedBooks.subList(startIndex, endIndex);
			model.addObject("page", page);

		} else {
			sublist = sortedBooks.subList(0, booksInPage);
			model.addObject("page", 1);
		}
		model.addObject("word", word);
		model.addObject("booksOnPage", booksInPage);
		model.addObject("numberOfPages", numberOfPages);
		model.addObject("allbooks", sublist);
		model.addObject("username", getUser());
		model.addObject("numberOfAllBooks", sortedBooks.size());
		model.addObject("allGenres", allGenres);
		model.addObject("sections", sections);

		return model;
	}

	@GetMapping("/adminsearch")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public ModelAndView adminsearch(@RequestParam String word) {
		ModelAndView model = new ModelAndView("allbooks");
		List<Book> allBooks = null;
		allBooks = getAllBooks(word);
		List<Book> sortedBooks = allBooks.stream().sorted((o1, o2) -> o1.getYear().compareTo(o2.getYear()))
				.collect(Collectors.toList());
		model.addObject("allbooks", sortedBooks);
		model.addObject("username", getUser());
		model.addObject("searchedword", word);
		return model;
	}

	@Deprecated
	@GetMapping("/getbooksbyword")
	public List<Book> getAllBooks(@RequestParam String word) {
		Predicate<Book> namePredicate = b -> String.valueOf(b.getName()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> authorPredicate = b -> String.valueOf(b.getAuthor()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> notesPredicate = b -> String.valueOf(b.getNotes()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> yearPredicate = b -> String.valueOf(b.getYear()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> editionPredicate = b -> String.valueOf(b.getEdition()).toLowerCase()
				.contains(word.toLowerCase());
		Predicate<Book> langPredicate = b -> String.valueOf(b.getLanguage()).toLowerCase().contains(word.toLowerCase());
		Predicate<Book> regNumberPredicate = b -> String.valueOf(b.getRegistrationNumber()).toLowerCase()
				.contains(word.toLowerCase());
		List<Book> allBooks = bookService.findAll();
		List<Book> filteredBooks = allBooks.stream().filter(namePredicate.or(authorPredicate).or(notesPredicate)
				.or(yearPredicate).or(editionPredicate).or(langPredicate).or(regNumberPredicate))
				.collect(Collectors.toList());
		return filteredBooks;
	}

	@Deprecated
	@GetMapping("/getbooksbyfirstletter")
	public List<Book> getBooksByFirstLetter(@RequestParam String word) {
		List<Book> allBooks = bookService.findAll();
		Predicate<Book> nameNumberPredicate = b -> Character.isDigit(b.getName().toLowerCase().charAt(0));
		Predicate<Book> namePredicate = b -> b.getName().toLowerCase().startsWith(word.toLowerCase());
		List<Book> filteredBooks;
		if (word.equals("#")) {
			filteredBooks = allBooks.stream().filter(nameNumberPredicate).collect(Collectors.toList());
		} else
			filteredBooks = allBooks.stream().filter(namePredicate).collect(Collectors.toList());
		return filteredBooks;
	}

	@RequestMapping("/update_book")
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String updateUser(@RequestBody BookDto bookDto) {
		System.out.println(bookDto);
		Book book = null;
		Optional<Book> optionalBook = bookService.findById(bookDto.getId());
		if (optionalBook.isPresent()) {
			book = optionalBook.get();
			book.setAuthor(bookDto.getAuthor());
//			book.setChildhood(bookDto.getChildhood());
//			book.setClosedSection(bookDto.getClosedSection());
			book.setCurrency(bookDto.getCurrency());
			book.setEdition(bookDto.getEdition());
			book.setGenre(bookDto.getGenre());
			book.setId(bookDto.getId());
			book.setLanguage(bookDto.getLanguage());
			book.setName(bookDto.getName());
			book.setNotes(bookDto.getNotes());
			book.setNumberOfPages(bookDto.getNumberOfPages());
			book.setPrice(bookDto.getPrice());
			book.setRegistrationNumber(bookDto.getRegistrationNumber());
			book.setYear(bookDto.getYear());
			Book savedBook = bookService.updateBook(book);
			System.out.println(savedBook);
			return "success";
		}
		return "error";
	}

	@RequestMapping(value = "/delete_book", method = RequestMethod.DELETE)
	public String delete_book(@RequestParam Long id) {
		bookService.deleteById((long) id);
		return "Книгу видалено!";
	}

	@GetMapping("/getcurrentuser")
	public String getUser() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			String username = ((UserDetails) principal).getUsername();
			return username;
		}
		return "";
	}
}
