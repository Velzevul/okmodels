class CreateMen < ActiveRecord::Migration
  def change
    create_table :men do |t|
      t.string :full_name
      t.date :date_of_birth
      t.string :email
      t.integer :height
      t.integer :shoes
      t.string :hair
      t.string :eyes
      t.boolean :confirmed

      t.timestamps
    end
  end
end
