require "spec_helper"

describe MembersHelper do
  before(:each) do
    VCR.use_cassette('yandex') do
      @member = FactoryGirl.create(:member, website: 'http://yandex.ru')
    end
    @t1 = FactoryGirl.create(:topic, member: @member, level: 1)
    @t3 = FactoryGirl.create(:topic, member: @member, level: 3)
  end
  describe "sort_experts" do
    it "sort experts by heading levels" do
      result = [{path: [1,2,3], topic: @t3}, {path: [1,5,3], topic: @t1}]
      sort_experts(result).first.should be == result.last
    end

    it "sort experts by deep level" do
      result = [{path: [1,2,4,3], topic: @t1}, {path: [1,5,3], topic: @t3}]
      sort_experts(result).first.should be == result.last
    end
  end
end
