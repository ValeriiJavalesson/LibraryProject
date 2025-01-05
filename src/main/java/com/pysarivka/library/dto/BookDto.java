package com.pysarivka.library.dto;

import com.pysarivka.library.domain.Book;
import com.pysarivka.library.domain.Genre;

import lombok.Data;

@Data
public class BookDto {
	private Long id;
	private String name;
	private String author;
	private String registrationNumber;
	private String edition;
	private Integer numberOfPages;
	private Double price;
	private Integer year;
	private String language;
	private String notes;
	private String currency;
	private Boolean childhood;
	private Boolean closedSection;
	private Genre genre;
	
	public static BookDto toBookDto(Book book) {
		BookDto bookDto = new BookDto();
		bookDto.setAuthor(book.getAuthor());
		bookDto.setChildhood(book.getChildhood());
		bookDto.setClosedSection(book.getClosedSection());
		bookDto.setCurrency(book.getCurrency());
		bookDto.setEdition(book.getEdition());
		bookDto.setGenre(book.getGenre());
		bookDto.setId(book.getId());
		bookDto.setLanguage(book.getLanguage());
		bookDto.setName(book.getName());
		bookDto.setNotes(book.getNotes());
		bookDto.setNumberOfPages(book.getNumberOfPages());
		bookDto.setPrice(book.getPrice());
		bookDto.setRegistrationNumber(book.getRegistrationNumber());
		bookDto.setYear(book.getYear());		
		return bookDto;
	}

}
