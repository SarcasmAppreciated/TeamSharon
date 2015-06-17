$( document ).ready(function(){
	/*
    var csrftoken = $.cookie('csrftoken');
    
    function csrfSafeMethod(method) {
        // these HTTP methods do not require CSRF protection
        return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
    }
    $.ajaxSetup({
        beforeSend: function(xhr, settings) {
            if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
                xhr.setRequestHeader("X-CSRFToken", csrftoken);
            }
        }
    });
    alert(csrftoken);*/
    
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
        $(".type_box").trigger('reset');
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
			method: 'GET',
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
                        firstItem = true;
                        toAppend = "<div class='container'><img title='";
                        if (json[0].charName != null) {
                            if (firstItem) {
                                firstItem = false;
                            } else {
                                toAppend += "\n";
                            }
                            toAppend += "Name: " + json[i].charName;
                        }
                        if (json[0].personName != null) {
                            if (firstItem) {
                                firstItem = false;
                            } else {
                                toAppend += "\n";
                            }
                            toAppend += "Actual Name: " + json[i].personName;
                        }
                        if (json[0].species != null) {
                            if (firstItem) {
                                firstItem = false;
                            } else {
                                toAppend += "\n";
                            }
                            toAppend += "Species: " + json[i].species;
                        }
                        if (json[0].power != null) {
                            if (firstItem) {
                                firstItem = false;
                            } else {
                                toAppend += "\n";
                            }
                            toAppend += "Power: " + json[i].power;
                        }
                        if (json[0].originPlanet != null) {
                            if (firstItem) {
                                firstItem = false;
                            } else {
                                toAppend += "\n";
                            }
                            toAppend += "Origin: " + json[i].originPlanet;
                        }
                        $("#content").append(toAppend + "' src='/static/images/Unknown.png'></img></div>");
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
                } else if(json[0].cBook != null) {
                    for(var i = 0; i < json.length; i++) {    
                        $("#revenue_cat").append("<h2>Number of books with fewer than " + userQuery['less_than'] + " characters: " + json[i].cBook + "</h2>");
                    }
                    $("#revenue_cat").fadeIn("slow").css("display","inline-block");                    
                } else if(json[0].avgBook != null) {
                    for(var i = 0; i < json.length; i++) {    
                        $("#revenue_cat").append("<h2 style='line-height: 50px;'>Average number of characters in books in less than " + userQuery['less_than'] + " characters: " + json[i].avgBook + "</h2>");
                    }
                    $("#revenue_cat").fadeIn("slow").css("display","inline-block");                    
                } else {
                    alert("Unknown return");                    
                }           
			},
			error: function(e) {
			    console.log(e);
			}		
		});		
	}
	
	function update_table() {
		$.ajax({
			url: '/SuperheroesAndStuff/response/',
			method: 'POST',
			cache: false,
			data: userQuery,
			dataType: 'json',
            success: function(msg) {
			    console.log(msg.request);
                $("#update_message").append("<p style='color: #00b200;'>Changes Sucessful</p>").css("border-color","#00b200");;
                $("#update_message").fadeIn().delay(800).fadeOut(function(){
                    $("#update_message").empty().css("border-color","#999"); 
                });
			},
            error: function(e) {
			    console.log(e);
                $("#update_message").append("<p style='color: #f00;'>Changes Unsucessful</p>").css("border-color","#f00");
                $("#update_message").fadeIn().delay(800).fadeOut(function(){
                    $("#update_message").empty().css("border-color","#999");
                });
			}
		}); 
	}
});