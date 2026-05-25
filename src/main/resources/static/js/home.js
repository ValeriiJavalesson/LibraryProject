$(document).ready(function() {
	changeFontSize();
	changeBookHeight();
});

function changeFontSize() {
	let names = $('div.book_name');
	let authors = $('div.book_author');


	names.each(function() {
		let l = $(this).text().length;
		if (l => 45 && l < 60) $(this).css(
			{ 'font-size': '0.7rem' }
		);
		if (l >= 60) $(this).css(
			{ 'font-size': '0.5rem' }
		);
	});
	authors.each(function() {
		let l = $(this).text().length;
		if (l => 20 && l < 30) $(this).css(
			{ 'font-size': '0.7rem' }
		);
		if (l >= 30) $(this).css(
			{ 'font-size': '0.5rem' }
		);
	});
}

function changeBookHeight() {
	let books = $('div.book');
	books.each(function() {
		let p = $(this).data('pages');
		if (p < 160) p = 160;
		if (p <= 100) $(this).css(
			{
				'width': '2vw',
				'background-image': 'url("style/images/book_cover-4.png")'
			}
		);
		if (p > 200 && p < 400) $(this).css(
			{
				'width': '3vw',
				'background-image': 'url("style/images/book_cover-3.png")'
			}
		);
		if (p >= 400) $(this).css(
			{
				'width': '3.5vw',
				'background-image': 'url("style/images/book_cover-2.png")'
			}
		);

	});

}

