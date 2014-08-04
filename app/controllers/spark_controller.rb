require 'spark_core'
class SparkController < ApplicationController

	def index
		@temperature = "unavailable"
		@humidity = "unavailable"

		@temp2 = "unavailable"
		@humid2 = "unavailable"

		@chart = chart
	end

	def index2
		@temp2 = 72
		@humid2 = 45
		@temperature = 66
		@humidity = 31
	end

	def spark1
		@spark1 = Reading.new
		begin
			spark1 = SparkCore.new(SPARK1)
			temperature = spark1.get_temperature
			humidity = spark1.get_humidity
			@spark1.core = "Spark1"
			@spark1.temprature = temperature
			@spark1.humidity = humidity
		rescue
			@spark1.temprature = "unavailable"
			@spark1.humidity = "unavailable"
		end
			
		render json: @spark1
	end

	def spark2
		@spark2 = Reading.new
		begin
			spark2 = SparkCore.new(SPARK2)
			temperature = spark2.get_temperature
			humidity = spark2.get_humidity
			@spark2.core = "Spark2"
			@spark2.temprature = temperature
			@spark2.humidity = humidity
		rescue
			@spark2.temprature = "unavailable"
			@spark2.humidity = "unavailable"
		end
			
		render json: @spark2
	end

	def test
		begin
			spark1 = SparkCore.new(SPARK1)
			temperature = spark1.get_temperature
			humidity = spark1.get_humidity
		rescue DeviceNotConnected	
			temperature = "unavailable"
			humidity = "unavailable"
		end
	end

private
	def chart
		readings = Reading.where(core: "Spark1").order(created_at: :desc).limit(25)
		xaxis = readings.pluck(:created_at).map {|d| d.to_date}
		temp = readings.pluck(:temprature)
		humid = readings.pluck(:humidity)
		LazyHighCharts::HighChart.new('graph') do |f|
			f.title(:text => "Temprature Readings")
			f.xAxis(:categories => xaxis)
			f.series(:name => "Temp", :yAxis => 0, :data => temp )
			f.series(:name => "Humidity", :yAxis => 1, :data => humid )

			f.yAxis [
				{:title => {:text => "Temprature", :margin => 50}},
				{:title => {:text => "Humidity", :opposite => true}}
			]

			f.legend(:align => 'right', :verticalAligh => 'top', :y => 75, :x => -50, :layout => 'vertical')
			f.cart({:defaultSeriesType => 'column'})
		end

	end

	def spark1_temp_now
		begin
			spark1 = SparkCore.new(SPARK1)
			temperature = spark1.get_temperature
			humidity = spark1.get_humidity
		rescue DeviceNotConnected	
			temperature = "unavailable"
			humidity = "unavailable"
		end

	end

end
