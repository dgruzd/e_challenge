require 'spec_helper'

describe Friendship do
  before(:each) do
    VCR.use_cassette('yandex') do
      @member = FactoryGirl.create(:member, website: 'http://yandex.ru')
      @member2 = FactoryGirl.create(:member, website: 'http://yandex.ru')
    end
  end
  it 'should be saved only one way' do
    ids = [@member.id, @member2.id].sort
    @friendship = FactoryGirl.build(:friendship, member_id: ids.first, friend_id: ids.last)
    @friendship.should be_valid

    ids.reverse!
    @friendship = FactoryGirl.build(:friendship, member_id: ids.first, friend_id: ids.last)
    @friendship.should_not be_valid
  end
end
