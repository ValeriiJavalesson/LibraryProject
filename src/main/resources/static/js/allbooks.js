function checkbox_childhood(inp) {

	let book = {
		id: $(inp).data('book_id'),
		childhood: inp.checked
	};
	$.post("book_section", book);
}

function closedSection_change(inp) {
	let book = {
		id: $(inp).data('book_id'),
		closedSection: inp.checked
	};
	$.post("book_section", book);
}
function showPrintBtn() {
	if ($('#preparePrintButton').data("print") === false) {
		$('#preparePrintButton').data("print", true);
		$("#table_title").prop("hidden", false);
		$("#table_title_button").prop("hidden", false);
		topFunction();
	} else {
		$('#preparePrintButton').data("print", false);
		$("#table_title").prop("hidden", true);
		$("#table_title_button").prop("hidden", true);
	}


}

function print(id) {
	$('#preparePrintButton').prop("hidden", false);
	$("#table_title").prop("hidden", true);
	$("#table_title_button").prop("hidden", true);

	var table_title = $("#table_title").val();
	$("#table_title").val("");
	let tableHead = $('<textarea id="tableHead">' + table_title + '</textarea>');
	var content = document.getElementById(id).cloneNode(true);
	var w = window.open();



	$(content).css({ "width": "190mm", "min-height": "200mm" });
	var table = content.querySelector('.allbooks_table');
	$(tableHead).insertBefore(table);
	tableHead = content.querySelector('#tableHead');
	$(table).find('tr').each(function() {
		$(this).children("th:eq(11)").remove();
		$(this).children("th:eq(10)").remove();
		$(this).children("th:eq(9)").remove();
		$(this).children("th:eq(8)").remove();
		$(this).children("th:eq(0)").remove();
		$(this).children("td:eq(11)").remove();
		$(this).children("td:eq(10)").remove();
		$(this).children("td:eq(9)").remove();
		$(this).children("td:eq(8)").remove();
		$(this).children("td:eq(0)").remove();
	});
	$(table).css({ "border-collapse": "collapse", 
	"font-size": "14px", 
	"table-layout": "fixed", 
	"width": "100%", 
	"height": "auto" });
	$(table).find('th, td').css({
		"border": "solid 1px #000000",
		"word-break": "break-word",
		"padding": "3px",
		"width": "min-content"
	});
	$(table).find('colgroup').children().remove();
	let colgroup_content = '<col width="9%">';
	colgroup_content += '<col width="18%">';
	colgroup_content += '<col width="30%">';
	colgroup_content += '<col width="15%">';
	colgroup_content += '<col width="10%">';
	colgroup_content += '<col width="9%">';
	colgroup_content += '<col width="9%">';
	$(table).find('colgroup').append(colgroup_content);	
	$(tableHead).css({
		"text-align": "center",
		"font-size": "26px",
		"font-weight": "bold",
		"margin-bottom": "5px",
		"width": "100%",
		"height": "auto",
		"font-family": `"Times New Roman", Times, serif`,
		"border": "none",
		"resize": "none",
		"overflow": "hidden",
		"min-heigh": "26px"
	});
	w.document.body.append(content);
	
	$(table).find('.centerAlign').css({"text-align": "center"});
	$(table).find('.rightAlign').css({"text-align": "right"});
	$(table).find('.leftAlign').css({"text-align": "left"});

	w.print();
}

function editbook(book_id) {
	let book = '';
	$.get("get_book/" + book_id, function(data) {
		if (data != '') {
			book = data;
		}
	}).done(function() {
		cancelEditBook();
		let bookClass = '.book_id' + book_id;
		let content = '<tr class="editingRow editingBook' + book_id + '">';
		content += '<td colspan="1" class="added-class"><input name="id" hidden="hidden"/></td>';
		content += '<td colspan="1"><input name="registrationNumber" /></td>';
		content += '<td colspan="1"><textarea name="author" /></textarea></td>';
		content += '<td colspan="1"><textarea name="name"></textarea></td>';
		content += '<td colspan="1"><textarea name ="edition"></textarea></td>';
		content += '<td colspan="1"><input name="numberOfPages" /></td>';
		content += '<td colspan="1"><input name="price" /></td>';
		content += '<td colspan="1"><input name="year" /></td>';
		content += '<td colspan="1"><select name="language">';
		content += '<option value="Ukrainian">Ukrainian</option>';
		content += '<option value="Russian">Russian</option>';
		content += '<option value="English">English</option>';
		content += '</select></td>';
		content += '<td colspan="1"><textarea name="notes" ></textarea></td>';
		content += '<td colspan="1"><button class="btn btn-success" type="button" onclick="saveBook()">Зберегти</button></td>';
		content += '<td colspan="1"><button class="btn btn-warning" type="button" onclick="cancelEditBook()">Відміна</button></td>';
		content += '</tr';
		$('.allbooks_table').find(bookClass).after(content);

		$('input[name=id]').val(book.id);
		$('input[name=registrationNumber]').val(book.registrationNumber);
		$('textarea[name=name]').val(book.name);
		$('textarea[name=author]').val(book.author);
		$('textarea[name=edition]').val(book.edition);
		$('input[name=numberOfPages]').val(book.numberOfPages);
		$('input[name=price]').val(book.price);
		$('input[name=year]').val(book.year);
		$('select[name=language]').val(book.language);
		$('input[name=notes]').val(book.notes);
	});

}

function cancelEditBook() {
	$('.editingRow').remove();
}

function saveBook() {
	let book = {
		id: $('input[name=id]').val(),
		name: $('textarea[name=name]').val(),
		author: $('textarea[name=author]').val(),
		edition: $('textarea[name=edition]').val(),
		numberOfPages: $('input[name=numberOfPages]').val(),
		price: $('input[name=price]').val(),
		year: $('input[name=year]').val(),
		language: $('select[name=language]').val(),
		notes: $('input[name=notes]').val()
	};
	$.post("update_book", book).done(function() {
		window.location.reload();
	});
}


function topFunction() {
	document.body.scrollTop = 0;
	document.documentElement.scrollTop = 0;
}

function auto_grow(element) {
	element.style.height = "5px";
	element.style.height = (element.scrollHeight) + "px";
}