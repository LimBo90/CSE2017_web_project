class FixLikesTable < ActiveRecord::Migration
  def up
  	remove_column :likes , :page_id
  end
  def down
  	add_column :likes, :page_id, :integer
  end
end
