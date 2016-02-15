class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    
      t.references :document
      t.integer "position"
      t.timestamps null: false
    end
    #bardo deh 3ashan saving images in database 
    #add_attachment :pages, :avatar
  end
end
