class User < ActiveRecord::Base
  has_many :roles_users, foreign_key: :user_id
  # has_many :roles, through: :roles_users
  has_one :role
  has_many :permissions_users, foreign_key: :user_id
  has_many :permissions, through: :permissions_users
  has_one :api_key
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    self.role.name == "admin"
  end

  def PM?
    self.role.name == "PM"
  end

   def leader?
    self.role.name == "Leader"
  end

  def log_out
    binding.pry
    token = self.api_key
    token.access_token = Digest::MD5.hexdigest("#{Time.now.to_i.to_s}
      #{SecureRandom.hex}
      #{self.id}
      log_out")
    token.save()
  end
end
