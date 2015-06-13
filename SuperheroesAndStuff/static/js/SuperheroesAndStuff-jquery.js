$( document ).ready(function(){
  
	$(".filter").click(function(){
		$.ajax({
			type: 'GET',
			url: '/SuperheroesAndStuff/response/',
			cache: false,
			dataType: 'json',
			success: function(json) {
				$.each(json, function(i) {
					alert(json.foo);
				});
			},
			error: function(e) {
			     console.log(e);
			}		
		});		
	});	
});