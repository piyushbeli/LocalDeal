class AddExtraFieldsToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :mobile, :string, :limit => 10
    add_column :vendors, :website, :string
    add_reference :vendors, :category, index: true
    add_foreign_key :vendors, :categories
  end
end
