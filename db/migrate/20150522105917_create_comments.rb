class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.references :commentator, polymorphic: true, index: true
      t.string :body, :title
      t.timestamps null: false
    end
  end

  def down

  end
end
