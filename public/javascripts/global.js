function email_exists(email){
	$.ajax({
        url:'/application/email_exists',
        type:'POST',
        data: 'email=' + email,
        error:function(response) {
            //alert_message('error','An error occured while attempting to remove the user.');
        },
        success:function(response) {
            if(response == 'true'){
                alert_message('alert', 'The email is already taken. Please use another email.');
            }
       	}
    });
}

function alert_message(response, message) {
	//display alert message.
    $('.' + response).text(message);
    
    if ( $('.' + response).html().length > 0 ) {
		$('.' + response).show();
		setTimeout(function(){
			$('.' + response).fadeOut('slow');
		},2000);
	}
}

jQuery(document).ready(function($){
	// Select Lists
	$('.custom-select-list-header').click(function(){
		$(this).next('.custom-select-list-content').show();
		$('body').prepend('<div class="close-custom-select"/>');
	});
	
	$('body').on('click','.close-custom-select', function(){
		$('.custom-select-list-content').hide();
		$(this).remove();
	});
	
	/* Horizontal tabbing */
	$('.custom-horizontal-tabs .tab-menu ul li').click(function(){
		var tabActive = $(this).attr('target');
		$(this).parent().find('li').removeClass('active');
		$(this).addClass('active');
		$('.custom-horizontal-tabs .tab-content').removeClass('active');
		$('.custom-horizontal-tabs .tab-body').find('.' + tabActive).addClass('active');
	
	});

	/*-------------- Edit Comments ------------*/
	$('#new_comment_form textarea').ajaxComplete(function(){ 
		$('.comments-content textarea').autosize();  
	});
	
	$('.comments textarea').autosize();  
	$('.comments-content').on('click', '.comment-edit', function(){
		$(this).closest('.table-right').find('.comment textarea').removeAttr('disabled');
		$(this).closest('form').find('.btn-update-options').removeClass('hidden');
	});
	
	$('.comments-content').on('click', '.btn-cancel-comment', function(){
		$(this).closest('.table-right').find('.comment textarea').attr('disabled','disabled');
		$(this).closest('.table-right').find('.btn-update-options').addClass('hidden');
	});
	
	//********** check if email exists **********
	$('#user_email.check_email').change(function(){
		email_exists($(this).val());
	});
	//*******************************************

  // button submits push the submit button they are hiding
  $('.button.submit').not('a, input').click(function(e){
    $(this).parents('form').submit();
  });
	
});