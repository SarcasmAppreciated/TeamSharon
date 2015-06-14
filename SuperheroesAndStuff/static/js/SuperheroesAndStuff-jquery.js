$( document ).ready(function(){
  	$(".submit_button").click(function(){
		var userQuery = {cname:false, species:false, origin:false};
		
		if($("#cname").is(":checked"))
			userQuery["cname"] = true;
		if($("#species").is(":checked"))
			userQuery["species"] = true;
		if($("#origin").is(":checked"))
			userQuery["origin"] = true;
		
		console.log(userQuery);

		$.ajax({
			type: 'GET',
			url: '/SuperheroesAndStuff/response/',
			cache: false,
			data: userQuery,
			dataType: 'json',
			success: function(json) {
					alert(json.name + " " + json.species + " " + json.origin);
			},
			error: function(e) {
			     console.log(e);
			}		
		});
	});
});