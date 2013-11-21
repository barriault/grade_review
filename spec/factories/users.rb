FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User#{n}" }
    sequence(:email) { |n| "example#{n}@example.com" }
    sequence(:uid) { |n| "netid#{n}" }
  end
end