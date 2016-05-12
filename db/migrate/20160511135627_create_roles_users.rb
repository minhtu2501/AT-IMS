class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table :roles_users, id: false do |t|
      t.references :user, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true
    end
  end
end
