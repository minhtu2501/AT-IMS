class Permission < ActiveRecord::Base
  has_many :permissions_roles, foreign_key: :permission_id
  has_many :roles, through: :permissions_roles
  has_many :permissions_users, foreign_key: :permission_id
  has_many :users, through: :permissions_users
end
