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
			if($("#aname").is(":checked"))
				userQuery["aname"] = true;
			else
				userQuery["aname"] = false;
			if($("#powerc").is(":checked"))
				userQuery["powerc"] = true;
			else
				userQuery["powerc"] = false;
						
			userQuery['power'] = $('#power').val();
			userQuery['creator'] = $('#creator').val();
			userQuery['director'] = $('#director').val();
			
			get_response();
		}
		else if($(this).attr('id') == 'movie_submit') {
			if($("#m_name").is(":checked"))
				userQuery["m_name"] = true;
			else
				userQuery["m_name"] = false;
			if($("#total_rev").is(":checked"))
				userQuery["total_rev"] = true;
			else
				userQuery["total_rev"] = false;
			if($("#avg_rev").is(":checked"))
				userQuery["avg_rev"] = true;
			else
				userQuery["avg_rev"] = false;
			
			userQuery['miname'] = $('#miname').val();
			userQuery['mename'] = $('#mename').val();
			
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
			userQuery['u_movie'] = $('#u_movie').val();
			userQuery['revenue'] = $('#revenue').val();
					
			update_table();
		}
		
		else if($(this).attr('id') == 'delete_submit') {
			userQuery['d_creator'] = $('#d_creator').val();
			userQuery['d_cname'] = $('#d_cname').val();
					
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