if Rails.env.production?
	CarrierWave.configure do |config|
		config.fog_credentials = {

			:provider 												=> "Google",
			:google_storage_access_key_id			=> ENV["GOOGSGTWYQKTCW3RMR4Z"],
			:google_storage_secret_access_key => ENV["HWSnLQEYecB3YUOpcm8k6CqkZZKK2Ms/Il7LZF9z"]
	}

	config.fog_directory = ENV["sample_app_bucket"]
	end
end