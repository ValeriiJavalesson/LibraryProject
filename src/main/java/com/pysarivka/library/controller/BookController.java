package com.pysarivka.library.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.pysarivka.library.LibraryOfPysarivkaApplication;
import com.pysarivka.library.domain.Book;
import com.pysarivka.library.service.impl.BookServiceImpl;

@RestController
public class BookController {

	@Autowired
	private BookServiceImpl bookService;

	@GetMapping("/welcome")
	public String welcome() {
		return "Welcome Page...";
	}

	@GetMapping("/get_book/{name}")
//	@PreAuthorize("hasAuthority('ROLE_USER')")
	public Optional<List<Book>> getByName(@PathVariable String name) {
		return bookService.findByName(name);
	}

	@RequestMapping("/newbook")
	public ModelAndView editbook(@RequestParam("id") Long id) {
		ModelAndView model = new ModelAndView("newbook");
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
//	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String saveBook(@ModelAttribute("bookform") Book bookform) {
		Book savedBook = bookService.saveBook(bookform);
		return "book?id=" + savedBook.getId().toString();
	}

	@GetMapping("/book")
	public ModelAndView openBook(@RequestParam("id") Long id) {
		ModelAndView model = new ModelAndView("book");
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
//	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public ModelAndView home() {
		ModelAndView model = new ModelAndView("home");
		List<Book> allBooks = null;
		allBooks = bookService.findAll();
		List<Book> randomBooks = new ArrayList<Book>();
		while (randomBooks.size() < 20) {
			int randomNumber = (int) (Math.random() * (allBooks.size() - 0));
			Book book = allBooks.get(randomNumber);
			if (!randomBooks.contains(book))
				randomBooks.add(book);
		}
		model.addObject("allbooks", randomBooks);
		return model;
	}

	@GetMapping("/getbooksbyword")
	public List<Book> getAllBooks(@RequestParam String word) {
//		if (word.equals("add")) {
//			List<Book> booksFromTable = LibraryOfPysarivkaApplication.addCurrency();
//			booksFromTable.stream().forEach(b -> {
//				System.out.println(b.getName() + " ---> " + b.getCurrency().toString());
//				Optional<List<Book>> optionalBook = bookService.findByName(b.getName());
//				if (optionalBook.isPresent()) {
//					List<Book> list = optionalBook.get();
//					list.forEach(book -> {
//						book.setCurrency(b.getCurrency());
//						bookService.saveBook(book);
//					});
//				}
//			});
//		}
		Predicate<Book> namePredicate = b -> b.getName().toLowerCase().contains(word.toLowerCase());
		Predicate<Book> authorPredicate = b -> b.getAuthor().toLowerCase().contains(word.toLowerCase());
		Predicate<Book> notesPredicate = b -> b.getNotes().toLowerCase().contains(word.toLowerCase());
		Predicate<Book> yearPredicate = b -> b.getYear().toString().contains(word.toLowerCase());
		Predicate<Book> editionPredicate = b -> b.getEdition().toLowerCase().contains(word.toLowerCase());
		Predicate<Book> langPredicate = b -> b.getLanguage().toLowerCase().contains(word.toLowerCase());
		Predicate<Book> regNumberPredicate = b -> b.getRegistrationNumber().toString().contains(word.toLowerCase());
		List<Book> allBooks = bookService.findAll();
		List<Book> filteredBooks = allBooks.stream().filter(namePredicate.or(authorPredicate).or(notesPredicate)
				.or(yearPredicate).or(editionPredicate).or(langPredicate).or(regNumberPredicate))
				.collect(Collectors.toList());
		return filteredBooks;
	}

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

//		List<Book> result = filteredBooks.stream().sorted((o1, o2)->o1.getName().compareTo(o2.getName())).
//                collect(Collectors.toList());

		return filteredBooks;
	}

	@PutMapping("/update_book")
	public String updateUser(@RequestBody Book book) {
		bookService.updateBook(book);
		return "Student successfully updated";
	}

	@RequestMapping(value = "/delete_book", method = RequestMethod.DELETE)
//	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	public String delete_book(@RequestParam Long id) {
		bookService.deleteById((long) id);
		return "Книгу видалено!";
	}
}
