class CreateMyfilters < ActiveRecord::Migration
  def change
    create_table :myfilters do |t|
      t.references :user, index: true
      t.text :criteria
      t.timestamps null: false
    end
  end
end
