class CreateWomen < ActiveRecord::Migration
  def change
    create_table :women do |t|
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

      t.timestamps
    end
  end
end
