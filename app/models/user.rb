class User < ActiveRecord::Base
	before_save { email.downcase! }
	validates :name, presence: true, 
									 length: { maximum: 50 }

	validates :email, presence: true,
										length: { maximum: 255 },
										format: { with: /\A[\w+\-.]+@[a-z0-9\-.]+\.[a-z]+\z/i },
										uniqueness: { case_sensitive: false }
	has_secure_password
	
	validates :password, presence: true, 
											 length: { minimum: 6 },
											 format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[\W])(?=.*[0-9]).{6,}\z/ }
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost 											 
BCrypt::Password.create(string, cost: cost)
	end

end

