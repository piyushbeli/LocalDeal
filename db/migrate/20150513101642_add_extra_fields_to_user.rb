class AddExtraFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string, :limit => 10, unique: true
    add_column :users, :city_id, :string
    add_column :users, :city, :string
    add_column :users, :is_verified, :boolean, null: false, default: false

    add_column :users, :no_of_comments, :integer
    add_column :users, :no_of_followings, :integer
    add_column :users, :no_of_followers, :integer
    add_column :users, :no_of_favorite_outlets, :integer
    add_column :users, :slug, :string, null: false
    add_column :users, :badge, :string, default: :beginner
  end
  add_index :users, [:slug], :unique => true
end
