require File.expand_path('../../spark_core.rb', __FILE__)
require File.expand_path('../../../config/initializers/cores.rb', __FILE__)
require 'active_record'

namespace :sensors do

	desc "fetch the sensor data from the spark cores"
	task :fetch => :environment do
		begin 
			spark1 = SparkCore.new(SPARK1)
			spark2 = SparkCore.new(SPARK2)
			r1 = Reading.new
			r1.core = "Spark1"
			r1.temprature = spark1.get_temperature
			r1.humidity = spark1.get_humidity
			r1.note = "Rhys's Room"

			r2 = Reading.new
			r2.core = "Spark2"
			r2.temprature = spark2.get_temperature
			r2.humidity = spark2.get_humidity
			r2.note = "Basement great room"

			r1.save
			r2.save

			if spark1 
		  		puts "It works" 
		  		Rails.logger.info "Sensor Rake Worked at #{Time.now}"
			else 
				puts "Didn't work"
			end

		rescue Exception => e
			puts "I'm rescued: #{e}"
			Rails.logger.info "Sensor Rake Failed: #{e} -----------"

		end

	end


	

end