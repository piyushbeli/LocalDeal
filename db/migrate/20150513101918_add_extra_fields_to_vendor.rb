class AddExtraFieldsToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :mobile, :string, :limit => 10
    add_column :vendors, :website, :string
    add_column :vendors, :is_verified, :boolean, null: false, default: false
    add_column :vendors, :about_me, :string
    add_column :vendors, :slug, :string, index: true, unique: true
    add_reference :vendors, :category, index: true
    add_column :vendors, :fb_page, :string
    add_column :vendors, :google_plus_page, :string
    add_column :vendors, :twitter_page, :string
    add_column :vendors, :instagram_page, :string
    add_foreign_key :vendors, :categories
  end
end
