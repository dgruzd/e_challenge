require 'spec_helper'

describe Member do
  it 'member should not be valid without name' do
    @member = FactoryGirl.build(:member)
    @member.name = nil
    @member.should_not be_valid
  end
end
