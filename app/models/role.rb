class Role < ActiveRecord::Base
  has_many :roles_users, foreign_key: :role_id
  # has_many :users, through: :roles_users
  belongs_to :user
  has_many :permissions_roles, foreign_key: :role_id
  has_many :permissions, through: :permissions_roles
end
