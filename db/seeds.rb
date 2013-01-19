# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


FactoryGirl.create_list(:man, 5, :with_photos)
FactoryGirl.create_list(:man, 2, :with_photos, :confirmed => false)

FactoryGirl.create_list(:woman, 15, :with_photos)
FactoryGirl.create_list(:woman, 5, :with_photos, :confirmed => false)

FactoryGirl.create_list(:child, 5, :with_photos)
FactoryGirl.create_list(:child, 2, :with_photos, :confirmed => false)

FactoryGirl.create(:user, :registered)
FactoryGirl.create(:user, :admin)