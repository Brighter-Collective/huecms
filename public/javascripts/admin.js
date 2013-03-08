function remove_user(user_id){
	if (confirm('Are you sure want to delete this user?')){
		$.ajax({
	        url:'/admin/users/' + user_id + '/remove_user',
	        type:'POST',
	        error:function(response) {
	            //alert_message('error','An error occured while attempting to remove the user.');
	        },
	        success:function(response) {
	            if(response == "success"){
	                //remove the user from the list.
	                //alert_message('notice', 'You have successfully removed the user.');
	                $('#' + user_id).closest('tr').remove();
	            } else {
	            	//alert_message('alert', 'Can\'t delete yourself.');
	            }
	       	}
	    });
	}
}

$(document).ready(function(){
	//********** bof user page **********
	$('.remove-user').click(function(){
		remove_user($(this).attr('id'));
	});
	//********** eof user page **********
	
	
	
});
