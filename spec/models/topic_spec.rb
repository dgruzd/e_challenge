require 'spec_helper'

describe Topic do

  it 'should be valid for heading level' do
    (1..3).each do |l|
      FactoryGirl.build(:topic, level: l).should be_valid
    end
  end

  it 'should be invalid for other heading level' do
    [0,4].each do |l|
      FactoryGirl.build(:topic, level: l).should_not be_valid
    end
  end
end
