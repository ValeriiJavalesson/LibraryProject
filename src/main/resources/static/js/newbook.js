function checkForm() {
	const form = $("#bookform")[0];
	var formData = new FormData(form);
	$.ajax({
		type: "POST",
		url: 'save_book',
		data: formData,
		contentType: false,
		processData: false,
		complete: function(data) {
			window.location = data.responseText;
		}
	})
}
