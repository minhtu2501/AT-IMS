class CreatePermissionsUsers < ActiveRecord::Migration
  def change
    create_table :permissions_users, id: false do |t|
      t.references :permission, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
