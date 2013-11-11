require 'factory_girl'

FactoryGirl.define do
  factory :topic do
    sequence(:title) {|n| "Heading title #{n}" }
  end
end