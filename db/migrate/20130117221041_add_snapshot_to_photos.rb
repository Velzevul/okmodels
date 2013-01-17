class AddSnapshotToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :snapshot, :boolean
  end
end
