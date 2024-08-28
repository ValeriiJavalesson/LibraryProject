package com.pysarivka.library;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

//import com.pysarivka.library.domain.Book;

@SpringBootApplication
public class LibraryOfPysarivkaApplication extends SpringBootServletInitializer{

	 @Override
	    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
	        return application.sources(LibraryOfPysarivkaApplication.class);
	    }
	 
	public static void main(String[] args) {
		SpringApplication.run(LibraryOfPysarivkaApplication.class, args);

	}

//	public static List<Book> addBooksFromTable() {
//		List<Book> books = new ArrayList<>();
//		File file = new File("C://Users/VALERKO/Documents/Бібліотека.xlsx");
//		try {
//			FileInputStream fis = new FileInputStream(file);
//			XSSFWorkbook myWorkBook = new XSSFWorkbook(fis);
//			XSSFSheet mysheet = myWorkBook.getSheet("sheet1");
//
//			Integer numberStartRow = 1;
//			Integer numberEndRow = 1835;
//			for (int i = numberStartRow; i <= numberEndRow; i++) {
//				Book book = new Book();
//				
//				CellType cellType = mysheet.getRow(i).getCell(1).getCellType();
//				if(cellType.equals(CellType.NUMERIC))book.setRegistrationNumber((Integer.toString((int) mysheet.getRow(i).getCell(1).getNumericCellValue())));
//				else book.setRegistrationNumber(mysheet.getRow(i).getCell(1).getStringCellValue());	 
//				book.setAuthor(mysheet.getRow(i).getCell(2).getStringCellValue());
//				book.setName(mysheet.getRow(i).getCell(3).getStringCellValue());
//				book.setEdition(mysheet.getRow(i).getCell(4).getStringCellValue());
//				book.setNumberOfPages((int) mysheet.getRow(i).getCell(5).getNumericCellValue());
//				book.setPrice((double) mysheet.getRow(i).getCell(6).getNumericCellValue());
//				book.setYear((int) mysheet.getRow(i).getCell(7).getNumericCellValue());
//				book.setLanguage(mysheet.getRow(i).getCell(8).getBooleanCellValue() ? "Ukrainian" : "Russian");
//				book.setNotes(mysheet.getRow(i).getCell(9).getStringCellValue());
//				books.add(book);
//			}
//          myWorkBook.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return books;
//	}
}
