class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      #t.references :user
      t.string "name", null: false, limit: 25
      t.string "attachment", null:false
      t.string "description", limit: 125
      t.timestamps null: false
    end

  end
end
