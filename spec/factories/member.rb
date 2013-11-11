require 'factory_girl'

FactoryGirl.define do
  factory :member do
    sequence(:name) {|n| "Name #{n}"}
  end
end