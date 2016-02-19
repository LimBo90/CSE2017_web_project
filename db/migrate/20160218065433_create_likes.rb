class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.integer "user_id"
    	t.integer "page_id"
    	t.integer "likable_id"
    	t.string "likable_type"
      t.timestamps null: false
    end
    add_index :likes, ["user_id","page_id","likable_id","likable_type"]
  end
end
