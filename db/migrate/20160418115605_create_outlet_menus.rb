class CreateOutletMenus < ActiveRecord::Migration
  def change
    create_table :outlet_menus do |t|
      t.string :url, null:false
      t.references :outlet, index: true, null:false
      t.string :caption
      t.timestamps null: false
    end
  end
end
