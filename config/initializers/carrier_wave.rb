if Rails.env.production?
	CarrierWave.configure do |config|
		config.fog_credentials = {

			:provider 												=> "AWS",
			:aws_access_key_id								=> ENV["AKIAIBL5HBIDATDW3JWQ"],
			:aws_secret_access_key 						=> ENV["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"],
			:region														=> ENV["us-west-2"]
	}

	config.fog_directory = ENV["sampappaul"]
	end
end