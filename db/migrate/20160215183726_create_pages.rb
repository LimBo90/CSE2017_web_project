class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
    
      t.references :document
      t.integer "position", null: false
      t.timestamps null: false
    end
    add_index :pages, 'document_id'
    #bardo deh 3ashan saving pages in database
    #add_attachment :pages, :avatar
  end
end
