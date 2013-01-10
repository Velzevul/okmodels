class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :full_name
      t.date :date_of_birth
      t.string :email
      t.integer :height
      t.integer :shoes
      t.string :hair
      t.string :eyes
      t.boolean :confirmed
      t.integer :bust
      t.integer :waist
      t.integer :heaps

      t.string :type
      t.timestamps
    end
    
    add_index :models, :type
  end
end
