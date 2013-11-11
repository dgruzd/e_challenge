require 'spec_helper'

describe Topic do

  before(:each) do
    VCR.use_cassette('yandex') do
      @member = FactoryGirl.build(:member, website: 'http://yandex.ru')
    end
  end

  it 'should be valid for heading level' do
    (1..3).each do |l|
      FactoryGirl.build(:topic, level: l, member: @member).should be_valid
    end
  end

  it 'should be invalid for other heading level' do
    [0,4].each do |l|
      FactoryGirl.build(:topic, level: l, member: @member).should_not be_valid
    end
  end
end
