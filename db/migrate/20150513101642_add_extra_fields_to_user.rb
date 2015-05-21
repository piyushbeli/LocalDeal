class AddExtraFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string, :limit => 10, unique: true
  end
end
