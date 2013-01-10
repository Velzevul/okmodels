require 'factory_girl'

FactoryGirl.define do
  factory :man do
    sequence("full_name") {|n| "John Smith #{n}"}
    sequence("date_of_birth") {|n| Date.today - Random.rand(20..30).years}
    email {"#{full_name.gsub(' ','')}@gmail.com"}
    sequence("height") { Random.rand(160..200) }
    sequence("shoes") { 40 + Random.rand(0..4) }
    hair {["blond", "black", "brown"].sample}
    eyes {["blue", "brown", "grey", "green"].sample}
    confirmed true
  end
end