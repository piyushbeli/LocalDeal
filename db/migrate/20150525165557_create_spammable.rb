class CreateSpams < ActiveRecord::Migration
  def change
    create_table :spams do |t|
      t.references :spammer, polymorphic: true, index: true
      t.references :spammable, polymorphic: true, index: true
      t.string :reason, null: false
      t.timestamps null:false
    end
  end
end
