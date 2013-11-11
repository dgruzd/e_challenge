require 'spec_helper'

describe Friendship do

  before(:each) do
    VCR.use_cassette('yandex') do
      @member = FactoryGirl.create(:member, website: 'http://yandex.ru')
      @member2 = FactoryGirl.create(:member, website: 'http://yandex.ru')
    end
    @ids = [@member.id, @member2.id].sort
  end

  it 'should be saved only one way: member_id < friend_id' do
    @friendship = FactoryGirl.build(:friendship, member_id: @ids.first, friend_id: @ids.last)
    @friendship.should be_valid

    @ids.reverse!
    @friendship = FactoryGirl.build(:friendship, member_id: @ids.first, friend_id: @ids.last)
    @friendship.should_not be_valid
  end

  it 'should be friends' do
    expect{
      FactoryGirl.create(:friendship, member_id: @ids.first, friend_id: @ids.last)
    }.to change{ @member.friends.count }.from(0).to(1)
  end

  it 'should be friends inverse' do
    expect{
      FactoryGirl.create(:friendship, member_id: @ids.first, friend_id: @ids.last)
    }.to change{ @member2.friends.count }.from(0).to(1)
  end
end
