class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.references :commentator, polymorphic: true, index: true
      t.references :offer, index: true
      t.string :body, :title
      t.integer :no_of_comments, default: 0
      t.integer :no_of_likes, default: 0
      t.integer :no_of_spams, default: 0
      t.timestamps null: false
    end
  end

  def down

  end
end
