class CreateOutletImage < ActiveRecord::Migration
  def change
    create_table :outlet_images do |t|
      t.string :url, null:false
      t.references :outlet, index: true, null:false
      t.references :uploader, polymorphic: true, index: true, null: false
      t.references :comment, index: true
      t.string :caption
    end
  end
end
