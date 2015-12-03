if Rails.env.production?
	CarrierWave.configure do |config|
		config.fog_credentials = {

			:provider 												=> "AWS",
			:aws_access_key_id								=> ["AKIAIBL5HBIDATDW3JWQ"],
			:aws_secret_access_key 						=> ENV["I2BjXDIrL683i9QU8Cwst7pQ/l5Kp1/FZWl9b4V"]
	}

	config.fog_directory = ENV["sampappaul"]
	end
end