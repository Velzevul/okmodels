class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :model

      t.timestamps
    end
    add_index :photos, :model_id
  end
end
