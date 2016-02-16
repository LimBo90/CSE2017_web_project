class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :uploader
      t.string "name", null: false, limit: 25
      t.string "attachment", null:false
      t.string "description", limit: 125
      t.timestamps null: false
    end
    add_index :documents, 'uploader_id'
  end
end
