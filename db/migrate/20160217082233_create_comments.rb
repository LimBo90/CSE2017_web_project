class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.timestamps null: false
      t.string "text" , null: false
      t.string "user_name" , null: false
      #t.integer "page_id" , null: false
      t.integer "user_id" , null: false
    end
    add_index("comments","user_id")
    #add_index("comments","page_id")
  end
end
