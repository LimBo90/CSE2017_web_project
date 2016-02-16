class CreateUsers < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.string "username", :limit => 25
      t.string "first_name", :limit => 50
      t.string "last_name", :limit => 50
      t.string "email", :limit => 50 , :null => false
      t.string "password_digest",  :null => false
      t.date "birth_date", :null => false
      t.timestamps
    end
    add_index("users", "username")
  end

  def down
    drop_table :users
  end

end
