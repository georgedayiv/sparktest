require 'httparty'

class DeviceNotConnected < Exception ; end


class SparkCore

	def initialize(core_id)
		raise unless core_id.class == String
		@core = core_id
		unless confirm_device == true
			raise DeviceNotConnected
		end
	end

	def token
		@token = YAML.load_file("#{Rails.root}/config/spark.yml")['access_token']
	end

	def version
		version = "/v1"
	end

	def base
		@base = "https://api.spark.io" + version
	end

	def confirm_device
		response = HTTParty.get("#{base}/devices?access_token=#{token}")
		response.each do |device|
			if device['id'] == @core
				if device['connected'] == true
					return true
				end
			end
		end
		false
	end

	def get_temperature
		response = HTTParty.get("#{base}/devices/#{@core}/temperature?access_token=#{token}")
		temperature = response['TEMPORARY_allTypes']['number']
	end

	def get_humidity
		response = HTTParty.get("#{base}/devices/#{@core}/humidity?access_token=#{token}")
		temperature = response['TEMPORARY_allTypes']['number']
	end

end
