class AddDescriptionAndMediastarToModel < ActiveRecord::Migration
  def change
    add_column :models, :description, :text
    add_column :models, :mediastar, :boolean
  end
end
