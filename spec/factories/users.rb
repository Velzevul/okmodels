# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    trait :registered do
      email "ru@gmail.com"
      password "ru@gmail.comru@gmail.com"
      password_confirmation "ru@gmail.comru@gmail.com"
      role "registered"
    end

    trait :admin do
      email "admin@gmail.com"
      password "admin@gmail.comadmin@gmail.com"
      password_confirmation "admin@gmail.comadmin@gmail.com"
      role "admin"
    end
  end
end
