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

  it 'website should be valid' do
    %w{http://ya.ru http://yandex.ru}.each do |site|
      @member.website = site
      @member.should be_valid
    end
  end

  it 'should not be valid with wrong url' do
    %w{htt://ya.ru ftp://ya.ru}.each do |site|
      @member.website = site
      @member.should_not be_valid
      @member.website.should be == site
    end
  end

  it 'should get topics' do
    @alan = FactoryGirl.build(:alan)

    VCR.use_cassette('alphasights') do
      @alan.get_topics.count.should be == 9
    end
  end

  it 'should create topics' do
    @alan = FactoryGirl.build(:alan)

    VCR.use_cassette('alphasights') do
      expect{@alan.save!}.to change{@alan.topics.count}.by(9)
    end
  end

  it 'should create shortened url' do
    @alan = FactoryGirl.build(:alan)

    VCR.use_cassette('alphasights') do
      expect{@alan.save!}.to change{@alan.shortened_urls.count}.by(1)
    end
  end
end
