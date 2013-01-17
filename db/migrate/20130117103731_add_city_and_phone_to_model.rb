class AddCityAndPhoneToModel < ActiveRecord::Migration
  def change
    add_column :models, :city, :string
    add_column :models, :phone, :string
  end
end
