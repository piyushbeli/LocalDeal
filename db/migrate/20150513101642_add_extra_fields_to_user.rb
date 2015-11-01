class AddExtraFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string, :limit => 10, unique: true
    add_column :users, :city_id, :string
    add_column :users, :city, :string
    add_column :users, :is_verified, :boolean, null: false, default: false
  end
end
