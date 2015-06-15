$( document ).ready(function(){
	
	$("#delete_button").click(function(){
		$("#delete_cat").fadeIn("slow", function(){
			$("#delete_submit").click(function(){
				$("#delete_cat").fadeOut("slow");				
			});			
		});					
	});	
	
	$("#update_button").click(function(){
		$("#update_cat").fadeIn("slow", function(){
			$("#update_submit").click(function(){
				$("#update_cat").fadeOut("slow");				
			});		
		});	
	});
	
	$("#close_button").click(function(){
		$(".no_op").fadeOut("slow");	
	});
	
	$("#reset").click(function(){
		$(".container").fadeOut("fast").remove();
		$("#reset").fadeOut("fast", function(){
			$(".category").not(".no_op").fadeIn("slow");
		});
	});
	
	var userQuery = {};
	
  	$(".submit_button").click(function(){
		userQuery = {};
		if($(this).attr('id') == 'character_submit') {
			if($("#cname").is(":checked"))
				userQuery["cname"] = true;
			else
				userQuery["cname"] = false;
			if($("#species").is(":checked"))
				userQuery["species"] = true;
			else
				userQuery["species"] = false;
			if($("#origin").is(":checked"))
				userQuery["origin"] = true;
			else
				userQuery["origin"] = false;
						
			userQuery['power'] = $('#power').val();
			userQuery['creator'] = $('#creator').val();
			userQuery['director'] = $('#director').val();
			
			get_response();
		}
		else if($(this).attr('id') == 'movie_submit') {
			if($("#total_rev").is(":checked"))
				userQuery["total_rev"] = true;
			else
				userQuery["total_rev"] = false;
			if($("#max_rev").is(":checked"))
				userQuery["max_rev"] = true;
			else
				userQuery["max_rev"] = false;
			
			userQuery['miname'] = $('#miname').val();
			userQuery['mename'] = $('#mename').val();
			userQuery['year'] = $('#year').val();
			
			get_response();
		}
		else if($(this).attr('id') == 'book_submit') {
			if($("#bcount").is(":checked"))
				userQuery["bcount"] = true;
			else
				userQuery["bname"] = false;
			
			userQuery['greater_than'] = $('#greater_than').val();
		
			get_response();
		}
		else if($(this).attr('id') == 'update_submit') {
			if($("#animated").is(":checked"))
				userQuery["animated"] = true;
			else
				userQuery["animated"] = false;			
			
			userQuery['with_name'] = $('#with_name').val();
			userQuery['to_name'] = $('#to_name').val();
			userQuery['m_director'] = $('#m_director').val();
			userQuery['release_date'] = $('#release_date').val();
			userQuery['revenue'] = $('#revenue').val();
					
			update_table();
		}
		
		else if($(this).attr('id') == 'delete_submit') {
			if($("#delete").is(":checked"))
				userQuery["kharacter"] = true;
			else
				userQuery["kharacter"] = false;
			if($("#fight").is(":checked"))
				userQuery["fight"] = true;
			else
				userQuery["fight"] = false;	
			
			userQuery['d_cname'] = $('#d_cname').val();
			userQuery['comic_age'] = $('#comic_age').val();
					
			update_table();
		}
		
	});
	
	function get_response() {
		$.ajax({
			type: 'GET',
			url: '/SuperheroesAndStuff/response/',
			cache: false,
			data: userQuery,
			dataType: 'json',
			success: function(json) {
				console.log(json);
				$(".category").fadeOut("fast");
				$("#reset").fadeIn("slow");
				for(var i = 0; i < json.items.length; i++) {
					$("#content").append("<div class='container' id=" + json.items[i].name +"></div>");
				}
				$(".container").fadeIn("slow").css("display","inline-block");
			},
			error: function(e) {
			    console.log(e);
			}		
		});		
	}
	
	function update_table() {
		var request = $.ajax({
			url: '/SuperheroesAndStuff/response/',
			method: "POST",
			data: {},
			dataType: ""
		});

		request.done(function( msg ) {
		});

		request.fail(function( jqXHR, textStatus ) {
			alert( "Request failed: " + textStatus );
		});
	}
});