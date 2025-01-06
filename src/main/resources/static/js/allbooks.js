let page = 1;
let word = "";
let allGenres = '';
let sections = [];
$(document).ready(function() {
	page = $('input#currentpage').val();
	word = $('input#word').val();
	$.get("all_genres", function(data) {
		if (data != '') {
			allGenres = data;
		}
	});
	$('input.filter_value[type=radio][value=' + genreId + ']').attr('checked', true);
	let arr = $('input[type=text][name=section]');
	$(arr).each(function(i) {
		sections.push($(this).val());
	});
	$.each(sections, function(i, item) {
		$('input[type=checkbox][name='+ item + ']').attr('checked', true);
	});
});

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
		$(this).children("th:eq(12)").remove();
		$(this).children("th:eq(11)").remove();
		$(this).children("th:eq(10)").remove();
		$(this).children("th:eq(9)").remove();
		$(this).children("th:eq(8)").remove();
		$(this).children("th:eq(0)").remove();
		$(this).children("td:eq(12)").remove();
		$(this).children("td:eq(11)").remove();
		$(this).children("td:eq(10)").remove();
		$(this).children("td:eq(9)").remove();
		$(this).children("td:eq(8)").remove();
		$(this).children("td:eq(0)").remove();
	});
	$(table).css({
		"border-collapse": "collapse",
		"font-size": "14px",
		"table-layout": "fixed",
		"width": "100%",
		"height": "auto"
	});
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

	$(table).find('.centerAlign').css({ "text-align": "center" });
	$(table).find('.rightAlign').css({ "text-align": "right" });
	$(table).find('.leftAlign').css({ "text-align": "left" });

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
		content += '<td colspan="2" class="added-class remove_before"><input name="id" hidden="hidden"/><input name="registrationNumber" /></td>';


		content += '<td colspan="1"><textarea name="author" /></textarea></td>';
		content += '<td colspan="1"><textarea name="name"></textarea></td>';
		content += '<td colspan="1"><textarea name ="edition"></textarea></td>';
		content += '<td colspan="5"><div class="d-flex justify-content-between"><span>К-ть сторінок:</span><input class="w-50" name="numberOfPages"/></div>';
		content += '<div class="d-flex justify-content-between"><span>Ціна:</span> <div class="w-50 d-flex"><input name="price"/><input name="currency"/></div></div><div class="d-flex justify-content-between">Рік випуску: <input class="w-50" name="year"/></div>';
		content += '<div class="d-flex justify-content-between"><span>Мова: </span><select class="w-50" name="language"><option value="Ukrainian">Ukrainian</option>';
		content += '<option value="Russian">Russian</option>';
		content += '<option value="English">English</option></select></div>';
		content += '<div class="d-flex justify-content-between"><span>Жанр: </span><select class="w-50" name="genre"></select></div>';
		content += '</td>';
		content += '<td colspan="1"><textarea name="notes"></textarea></td>';
		content += '<td colspan="2"><div class="editButtons"><button class="btn btn-success w-100" type="button" onclick="saveBook()">Зберегти</button>';
		content += '<button class="btn btn-warning w-100" type="button" onclick="cancelEditBook()">Відміна</button></div></td>';
		content += '</tr';
		$('.allbooks_table').find(bookClass).after(content);

		$('input[name=id]').val(book.id);
		$('input[name=registrationNumber]').val(book.registrationNumber);
		$('textarea[name=name]').val(book.name);
		$('textarea[name=author]').val(book.author);
		$('textarea[name=edition]').val(book.edition);
		$('input[name=numberOfPages]').val(book.numberOfPages);
		$('input[name=numberOfPages]').css({ "text-align": "center" });
		$('input[name=price]').val(book.price);
		$('input[name=price]').css({ "text-align": "center" });
		$('input[name=currency]').val(book.currency);
		$('input[name=currency]').css({ "width": "50%" });
		$('input[name=year]').val(book.year);
		$('input[name=year]').css({ "text-align": "center" });
		$('select[name=language]').val(book.language);
		$('select[name=language]').css({ "text-align": "center" });
		$('textarea[name=notes]').val(book.notes);

		$.each(allGenres, function(i, item) {
			$('select[name=genre]').append($('<option>', {
				value: item.id,
				text: item.name
			}));
		});
		$('select[name=genre]').val(book.genre.id);
		$('select[name=genre]').css({ "text-align": "center" });
		$('.editButtons').css({
			'display': 'flex',
			'flex-direction': 'column',
			'flex-wrap': 'nowrap',
			'justify-content': 'space-evenly',
			'align-items': 'center',
			'height': '100%'
		});
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
		currency: $('input[name=currency]').val(),
		year: $('input[name=year]').val(),
		language: $('select[name=language]').val(),
		notes: $('textarea[name=notes]').val(),
		genre: {
			id: $('select[name=genre]').val(),
			name: $('select[name=genre]').find('option:selected').text()
		}
	};
	$.ajax({
		url: "update_book",
		type: 'POST',
		data: JSON.stringify(book),
		dataType: "html",
		contentType: 'application/json',
		success: function(data) {
			window.location.reload();
		}
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
function displayFilters() {
	$('#filter_list').toggleClass("active");
}

function applyFilter() {
	let objcts = $('input.filter_value[type=radio]:checked');
	let sectionsUrl = '';
	for (let i = 0; i < sections.length; i++) {
		sectionsUrl += '&sections=' + sections[i];
	}
	if (sections.length == 0) sectionsUrl = '&sections=';
	let url = "allbooks?page=" + page + "&word=" + word + "&genreId=" + $(objcts).val() + sectionsUrl;
	window.location.href = url;

}

function clearSearchedWord() {
	let objcts = $('input.filter_value[type=radio]:checked');
	let sectionsUrl = '';
	for (let i = 0; i < sections.length; i++) {
		sectionsUrl += '&sections=' + sections[i];
	}
	if (sections.length == 0) sectionsUrl = '&sections=';
	let url = "allbooks?page=" + page + "&word=" + "&genreId=" + $(objcts).val() + sectionsUrl;
	window.location.href = url;

}

function section_filter() {
	let childhood = $('input[type=checkbox][name=childhood]').is(':checked');
	let closedSection = $('input[type=checkbox][name=closedSection]').is(':checked');
	console.log('childhood - ' + childhood);
	console.log('closedSection - ' + closedSection);

	sections = [];
	if (childhood) sections.push('childhood');
	if (closedSection) sections.push('closedSection');
	applyFilter();
}


























