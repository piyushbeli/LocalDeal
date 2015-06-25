class AddExtraFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string, :limit => 10, unique: true
    add_column :user, :city_id, :string
    add_column :user, :city, :string
  end
end
