require 'spark_core'
class SparkController < ApplicationController

	def index
		begin
			spark1 = SparkCore.new(SPARK1)
			@temperature = spark1.get_temperature
			@humidity = spark1.get_humidity
		rescue DeviceNotConnected	
			@temperature = "unavailable"
			@humidity = "unavailable"
		end

		begin
			spark2 = SparkCore.new(SPARK2)
			@temp2 = spark2.get_temperature
			@humid2 = spark2.get_humidity
		rescue DeviceNotConnected
			@temp2 = "unavailable"
			@humid2 = "unavailable"
		end
	end

end
