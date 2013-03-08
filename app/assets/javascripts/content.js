$(function () {
	$("#new_comment_form").submit(function () {
		var commentInfo = $(this).serialize();
		$("#new_comment_form textarea").val("");
		$.ajax({
			url: "/comments/new",
			data: commentInfo,
			dataType: "HTML"
		}).success(function (response) {
			$("ul.comments-content").append(response);
		});
		return false;
	});
	
	$("form.comment_form").live('submit', function () {
		var commentInfo = $(this).serialize();
		$.ajax({
			url: "/comments/" + $(this).find(".comment-info .comment-options .comment-id").attr('data-value'),
			data: commentInfo,
			type: "PUT"
		}).success(function (response) {
			$('.btn-cancel-comment').click();
		});
		return false;
	});
	
	$("span.comment-delete").live('click', function () {
		var isGood = confirm('are you sure?');
		if (isGood) {
			var commentInfo = $(this).closest('form').serialize();
			$(this).closest('form').hide();
			$.ajax({
				url: "/comments/" + $(this).prev().attr('data-value'),
				data: commentInfo,
				type: "DELETE"
			});
		}
	});
})
