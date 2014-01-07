require 'spark'
class SparkController < ApplicationController

	def index
		spark = Spark.new
		if spark
			spark.set_core("53ff6b065067544833151187")
			@temperature = spark.get_temperature
			@humidity = spark.get_humidity
		else
			@temperature = "unavailable"
			@humidity = "unavailable"
		end
	end

end
