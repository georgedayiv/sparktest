
$(function(){
	$.getJSON('/spark1', function(data) {
		//alert(data.temprature);
		$('#spark1temp').html("<p class='reading' id='spark1temp'> Temprature: " + data.temprature +"&#xb0;")
		$('#spark1humid').html("<p class='reading' id='spark1humid'> Humidity: " + data.humidity +"&#xb0;")
	});
	$.getJSON('/spark2', function(data) {
		$('#spark2temp').html("<p class='reading' id='spark2temp'> Temprature: " + data.temprature +"&#xb0;")
		$('#spark2humid').html("<p class='reading' id='spark2humid'> Humidity: " + data.humidity +"&#xb0;")

	});

});