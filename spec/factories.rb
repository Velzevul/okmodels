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
    phone "(+380) 67 167 08 45"
    city "Kiev"
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
    phone "(+380) 67 167 08 45"
    city "Kiev"
    confirmed true

    trait :with_photos do
      ignore do
        photos_count 8
        shapshots_count 4
      end

      after(:create) do |model, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photos_count, :female, model: model)
        FactoryGirl.create_list(:photo, evaluator.shapshots_count, :female_snapshot, model: model)
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
    phone "(+380) 67 167 08 45"
    city "Kiev"
    confirmed true

    trait :with_photos do
      ignore do
        photos_count 5
        shapshots_count 2
      end

      after(:create) do |model, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photos_count, :male, model: model)
        FactoryGirl.create_list(:photo, evaluator.shapshots_count, :male_snapshot, model: model)
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
    phone "(+380) 67 167 08 45"
    city "Kiev"
    confirmed true

    trait :with_photos do
      ignore do
        photos_count 5
      end

      after(:create) do |model, evaluator|
        FactoryGirl.create_list(:photo, evaluator.photos_count, :child, model: model)
      end
    end
  end

  factory :photo do
    image Rack::Test::UploadedFile.new(File.join(Rails.root,"spec/dummies/dummy.gif"),"image/gif")
    snapshot false
    model

    trait :male do
      sequence("image") {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/dummies/male/#{Random.rand(0..17)}.jpg"), "image/jpg")}
    end

    trait :male_snapshot do
      sequence("image") {|n| Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/dummies/male/snapshots/#{Random.rand(0..4)}.jpg"), "image/jpg")}
      snapshot true
    end

    trait :female do
      sequence("image") {|n| Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/dummies/female/#{Random.rand(0..25)}.jpg"), "image/jpg")}
    end

    trait :female_snapshot do
      sequence("image") {|n| Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/dummies/female/snapshots/#{Random.rand(0..11)}.jpg"), "image/jpg")}
      snapshot true
    end

    trait :child do
      sequence("image") {|n| Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/dummies/child/#{Random.rand(0..12)}.jpg"), "image/jpg")}
    end

  end
end