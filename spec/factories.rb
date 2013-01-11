require 'factory_girl'

FactoryGirl.define do # TODO: DRY
  factory :model do
    sequence("full_name") {|n| "Model #{n}"}
    sequence("date_of_birth") {|n| Date.today - 25.years}
    email {"#{full_name.gsub(' ','')}@gmail.com"}
    sequence("height") { Random.rand(150..200) }
    sequence("shoes") { 38 + Random.rand(0..6) }
    hair {["blond", "black", "brown"].sample}
    eyes {["blue", "brown", "grey", "green"].sample}
    confirmed true

    trait :with_photos do
      ignore do
        photos_count 5
      end

      after(:create) do |model, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photos_count, model: model)
      end
    end
  end

  factory :woman do
    sequence("full_name") {|n| "Inara Serra #{n}"}
    sequence("date_of_birth") {|n| Date.today - Random.rand(18..25).years}
    email {"#{full_name.gsub(' ','')}@gmail.com"}
    sequence("height") { Random.rand(150..180) }
    sequence("shoes") { 35 + Random.rand(0..4) }
    bust { 90 + Random.rand(-20..20) }
    waist { 60 + Random.rand(-10..10) }
    heaps { 90 + Random.rand(-20..20) }
    hair {["blond", "black", "brown"].sample}
    eyes {["blue", "brown", "grey", "green"].sample}
    confirmed true

    trait :with_photos do
      ignore do
        photos_count 5
      end

      after(:create) do |model, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photos_count, model: model)
      end
    end
  end

  factory :man do
    sequence("full_name") {|n| "Malcolm Raynolds #{n}"}
    sequence("date_of_birth") {|n| Date.today - Random.rand(20..30).years}
    email {"#{full_name.gsub(' ','')}@gmail.com"}
    sequence("height") { Random.rand(160..200) }
    sequence("shoes") { 40 + Random.rand(0..4) }
    hair {["blond", "black", "brown"].sample}
    eyes {["blue", "brown", "grey", "green"].sample}
    confirmed true

    trait :with_photos do
      ignore do
        photos_count 5
      end

      after(:create) do |model, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photos_count, model: model)
      end
    end
  end

  factory :child do
    sequence("full_name") {|n| "River Tam #{n}"}
    sequence("date_of_birth") {|n| Date.today - Random.rand(10..17).years}
    email {"#{full_name.gsub(' ','')}@gmail.com"}
    sequence("height") { Random.rand(150..160) }
    sequence("shoes") { 30 + Random.rand(0..8) }
    hair {["blond", "black", "brown"].sample}
    eyes {["blue", "brown", "grey", "green"].sample}
    confirmed true

    trait :with_photos do
      ignore do
        photos_count 5
      end

      after(:create) do |model, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photos_count, model: model)
      end
    end
  end

  factory :photo do
    image Rack::Test::UploadedFile.new(File.join(Rails.root,"spec/100x120.gif"),"image/gif")
    model
  end
end