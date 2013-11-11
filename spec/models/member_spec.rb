require 'spec_helper'

describe Member do

  before(:each) do
    @member = FactoryGirl.build(:member)
  end

  it 'should not be valid without name' do
    @member.should be_valid
    @member.name = nil
    @member.should_not be_valid
  end

  it 'should not be valid without website' do
    @member.should be_valid
    @member.website = nil
    @member.should_not be_valid
  end
end
