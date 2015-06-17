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
		$("#reset, #revenue_cat").fadeOut("fast", function(){
			$(".category").not(".no_op").fadeIn("slow");
            $("h2").remove();
		});
	});
	
	var userQuery = {};
	
  	$(".submit_button").click(function(){
		userQuery = {};
		if($(this).attr('id') == 'character_submit') {
			userQuery["query_cat"] = "character";
			
			if($("#cname").is(":checked"))
				userQuery["cname"] = "True";
			else
				userQuery["cname"] = "False";
			if($("#species").is(":checked"))
				userQuery["species"] = "True";
			else
				userQuery["species"] = "False";
			if($("#origin").is(":checked"))
				userQuery["origin"] = "True";
			else
				userQuery["origin"] = "False";
			if($("#aname").is(":checked"))
				userQuery["aname"] = "True";
			else
				userQuery["aname"] = "False";
			if($("#powerc").is(":checked"))
				userQuery["powerc"] = "True";
			else
				userQuery["powerc"] = "False";
						
			userQuery['power'] = $('#power').val();
			userQuery['creator'] = $('#creator').val();
			userQuery['director'] = $('#director').val();
			
			get_response();
		}
		else if($(this).attr('id') == 'movie_submit') {
			userQuery["query_cat"] = "movie";
			
			if($("#m_name").is(":checked"))
				userQuery["m_name"] = "True";
			else
				userQuery["m_name"] = "False";
			if($("#total_rev").is(":checked"))
				userQuery["total_rev"] = "True";
			else
				userQuery["total_rev"] = "False";
			if($("#avg_rev").is(":checked"))
				userQuery["avg_rev"] = "True";
			else
				userQuery["avg_rev"] = "False";
			
			userQuery['miname'] = $('#miname').val();
			userQuery['mename'] = $('#mename').val();
			
			get_response();
		}
		else if($(this).attr('id') == 'book_submit') {
			userQuery["query_cat"] = "book";
			
			if($("#bcount").is(":checked"))
				userQuery["bcount"] = "True";
			else
				userQuery["bcount"] = "False";
			if($("#b_avg").is(":checked"))
				userQuery["b_avg"] = "True";
			else
				userQuery["b_avg"] = "False";
			
			userQuery['less_than'] = $('#less_than').val();
		
			get_response();
		}
		else if($(this).attr('id') == 'update_submit') {
			userQuery["query_cat"] = "update";
		
			userQuery['u_movie'] = $('#u_movie').val();
			userQuery['revenue'] = $('#revenue').val();
					
			update_table();
		}
		
		else if($(this).attr('id') == 'delete_submit') {
			userQuery["query_cat"] = "delete";
			
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
			success: function(data) {
                var json = $.parseJSON(data);

				$(".category").fadeOut("fast");
				$("#reset").fadeIn("slow");
                
                if((json[0].charName != null) || (json[0].personName != null) || (json[0].species != null) || (json[0].power != null) || (json[0].originPlanet != null)) {
                    for(var i = 0; i < json.length; i++) {    
                        $("#content").append("<div class='container'><img title='Name: " + json[i].charName + "\nActual Name: " +
                        json[i].personName + "\nSpecies: " + json[i].species + "\nPower: " + json[i].power + "\nOrigin: " + json[i].originPlanet + "' src='/static/images/Unknown.png'></img></div>");
                    }
                    $(".container").fadeIn("slow").css("display","inline-block");                    
                } else if(json[0].mName != null) {
                    for(var i = 0; i < json.length; i++) {    
                        $("#content").append("<div class='container'><img title='Name: " + json[i].mName + "' src='/static/images/Unknown.png'></img></div>");
                    }
                    $(".container").fadeIn("slow").css("display","inline-block");
                } else if(json[0].sumMovie != null) {
                    for(var i = 0; i < json.length; i++) {    
                        $("#revenue_cat").append("<h2>Total Revenue: $" + json[i].sumMovie + "</h2>");
                    }
                    $("#revenue_cat").fadeIn("slow").css("display","inline-block");                    
                } else if(json[0].avgMovie != null) {
                    for(var i = 0; i < json.length; i++) {    
                        $("#revenue_cat").append("<h2>Average Revenue: $" + json[i].avgMovie + "</h2>");
                    }
                    $("#revenue_cat").fadeIn("slow").css("display","inline-block");                    
                }
                
				
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