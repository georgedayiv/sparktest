
$(function(){

	var spark_width = document.getElementById("core1").offsetWidth;
	var spark_height = document.getElementById("core1").offsetHeight;

	core = "/spark1"

	var margin = { top: 20, right: 30, bottom: 30, left: 40 },
	    width = spark_width - margin.left - margin.right,
	    height = (spark_width * .75) - margin.top - margin.bottom;

	 var chart = d3.select("#spark1")
	 			   .attr("width", width + margin.left + margin.right)
	 			   .attr("height", height + margin.top + margin.bottom)
	 			 .append("g")
	 			   .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	var x = d3.time.scale().range([0, width]);

	var y = d3.scale.linear().range([height, 0]);

	var xAxis = d3.svg.axis()
				  .scale(x).ticks(d3.time.day, 1)
				  .orient("bottom");

	var yAxis = d3.svg.axis()
				  .scale(y)
				  .orient("left");

	var line = d3.svg.line()
				 .x(function(d) {return x(d.created_at);})
				 .y(function(d) {return y(d.temprature);});


	var parseDate = d3.time.format("%Y-%m-%dT%H:%M:%S.000Z").parse;

	function clear_chart() {
		d3.selectAll("path").data('').exit().remove();
		d3.selectAll(".axis").remove();
	}

	function generate_chart(core) {
		d3.json(core, function(error, data) {
			data.forEach(function(d) {
				d.created_at = parseDate(d.created_at);
				d.temprature = +d.temprature;
			});

			x.domain(d3.extent(data, function(d) {return d.created_at; }));
			y.domain(d3.extent(data, function(d) {return d.temprature;}));

			chart.append("g")
				 .attr("class", "x axis")
				 .attr("transform", "translate(0," + height + ")")
				 .call(xAxis);

			chart.append("g")
				 .attr("class", "y axis")
				 .call(yAxis)
			   .append("text")
			     .attr("transform", "rotate(-90)")
			     .attr("y", 6)
			     .attr("dy", ".71em")
			     .style("text-anchor", "end")
			     .text("Temprature");

			chart.append("path")
				 .datum(data)
				 .attr("class", "line")
				 .attr("d", line);

		});
	}

var aspect = 960 / 500
	$(window).on("resize", function() {
		blah = $('#spark1')
		var targetWidth = blah.parent().width();
		blah.attr("width", targetWidth);
		blah.attr("height", targetWidth / aspect)
	})

	generate_chart(core);

	$("#Rhys").click(function() {
		clear_chart();
		generate_chart("/spark1");
	});

	$("#Basement").click(function() {
		clear_chart();
		generate_chart("/spark2");
	});

});