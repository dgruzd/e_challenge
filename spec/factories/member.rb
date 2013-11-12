require 'factory_girl'

FactoryGirl.define do
  factory :member do
    sequence(:name) {|n| "Name #{n}"}
    sequence(:website) {|n| "http://website#{n}.com"}
  end

  factory :alan, parent: :member do
    website 'http://www.alphasights.com/careers/positions/london/ruby-on-rails-developer'
  end

  factory :dhh, parent: :member do
    name 'David Heinemeier Hansson'
    website 'http://david.heinemeierhansson.com/'
  end
end
