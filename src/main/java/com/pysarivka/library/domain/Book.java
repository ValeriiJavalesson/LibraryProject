package com.pysarivka.library.domain;

import io.micrometer.common.lang.NonNull;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table
@Data
public class Book {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	@NonNull
	@Column
	private String name;
	@Column
	private String author;
	@Column
	private String registrationNumber;
	@Column
	private String edition;
	@Column
	private Integer numberOfPages;
	@Column
	private Double price;
	@Column
	private Integer year;
	@Column
	private String language;
	@Column
	private String notes;

}
