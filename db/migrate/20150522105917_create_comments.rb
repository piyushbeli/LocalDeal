class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.references :commentator, polymorphic: true, index: true
      t.string :body, :title

      t.timestamps null: false
    end
  end
end
