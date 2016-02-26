class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.timestamps null: false
      t.string "text" , null: false
      t.belongs_to :commentable , polymorphic: true
      t.integer "user_id" , null: false
    end
    add_index("comments","user_id")
    add_index :comments , [:commentable_id, :commentable_type]
  end
end
