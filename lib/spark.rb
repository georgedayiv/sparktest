require 'httparty'

class Spark
	def token
		@token = YAML.load_file("#{Rails.root}/config/spark.yml")['access_token']
	end

	def version
		version = "/v1"
	end

	def base
		@base = "https://api.spark.io" + version
	end

	def set_core(core)
		@core = core
	end

	def get_devices
		HTTParty.get("#{base}/devices?access_token=#{token}")
	end
	
	def puts_request
		puts "#{base}/devices?access_token=#{token}"
	end

	def get_temperature
		return unless @core
		response = HTTParty.get("#{base}/devices/#{@core}/temperature?access_token=#{token}")
		temperature = response['TEMPORARY_allTypes']['number']
	end

	def get_humidity
		return unless @core
		response = HTTParty.get("#{base}/devices/#{@core}/humidity?access_token=#{token}")
		temperature = response['TEMPORARY_allTypes']['number']
	end

	def get_variables
		return unless @core
		HTTParty.get("#{base}/devices/#{@core}?access_token=#{token}")
	end

	def confirm_device
		return unless @core
		response = get_devices
		response.each do |device|
			unless device['id'] == @core && device['connected'] == true
				return false
			else
				return true
			end
		end
	end



end


