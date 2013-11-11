require 'spec_helper'

describe Member do

  before(:each) do
    @member = FactoryGirl.build(:member)
    @member2 = @member.dup
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

      @member2.short_url = site
      @member2.should be_valid
    end

  end

  it 'should not be valid with wrong url' do
    %w{htt://ya.ru ftp://ya.ru}.each do |site|
      @member.website = site
      @member.should_not be_valid
      @member.website.should be == site

      @member2.short_url = site
      @member2.should_not be_valid
    end
  end
end
