package com.pysarivka.library.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.pysarivka.library.domain.Book;

public interface BookRepository extends JpaRepository<Book, Long> {
	Optional<Book> findById(Long id);

	Optional<List<Book>> findByName(String name);

	void deleteById(Long id);

	@Query(value = "SELECT id, name, author, registration_number, edition, number_of_pages, "
			+ "price, year, language, notes, currency, childhood, closed_section, genre_id " + "FROM ( "
			+ "  SELECT b.*, ROW_NUMBER() OVER (PARTITION BY b.genre_id ORDER BY b.id DESC) as rn " + "  FROM book b "
			+ "  WHERE b.genre_id IS NOT NULL AND b.genre_id != 1 " + ") tmp WHERE rn <= 12", nativeQuery = true)
	List<Book> findTop12BooksPerGenre();

}
