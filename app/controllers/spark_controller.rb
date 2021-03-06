require 'spark_core'
class SparkController < ApplicationController

	def index
		if params[:core] && Reading.pluck(:core).include?(params[:core])
			@chart  = chart(params[:core].to_s)
		else
			@chart = chart("Spark1")
		end
	end

	def spark1
		@spark1 = Reading.new
		reading = get_readings(SPARK1)
		@spark1.core = "Spark1"
		@spark1.temprature = reading[:temperature]
		@spark1.humidity = reading[:humidity]
			
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

private
	def chart(core)
		return "Error" unless Reading.pluck(:core).include?(core)
		readings = Reading.where(core: core).order(created_at: :desc).limit(25)
		xaxis = readings.pluck(:created_at).map {|d| d.to_date}
		temp = readings.pluck(:temprature)
		humid = readings.pluck(:humidity)
		LazyHighCharts::HighChart.new('graph') do |f|
			f.title(:text => "#{core} Sensor Readings")
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

	def  get_readings(core)
		begin
			device = SparkCore.new(core)
			t = device.get_temperature
			h = device.get_humidity
			return {:temperature => t, :humidity => h}
		rescue
			return {:temperature => "unavailable", :humidity => "unavailable"}
		end
	end

end
