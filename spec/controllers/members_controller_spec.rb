require 'spec_helper'

describe MembersController do

  before(:all) do
    VCR.use_cassette('yandex') do
      @member = FactoryGirl.create(:member, website: 'http://yandex.ru')
      @member2 = FactoryGirl.create(:member, website: 'http://yandex.ru')
    end
    VCR.use_cassette('dhh') do
      @dhh = FactoryGirl.create(:dhh)
      @dhh.add_friend(@member)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @member.id
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http redirect" do
      VCR.use_cassette('yandex') do
        expect{
          post :create, :member => {:name => 'Name', :website => 'http://yandex.ru'}
        }.to change{Member.count}.by(1)
      end
      response.status.should == 302
    end

    it 'return http success' do
      VCR.use_cassette('yandex') do
        post :create, :member => {:name => '', :website => 'http://yandex.ru'}
      end

      response.should be_success
    end
  end

  describe "post 'add_friend'" do
    it 'return http success' do
      post :add_friend, member_id: @member.id, id: @member2.id, format: :js
      response.should be_success
    end

    it 'return http 400' do
      post :add_friend, member_id: @member.id, id: @member.id, format: :js
      response.should_not be_success
    end
  end

  describe "post 'find_experts'" do
    it 'return http success' do
      post :find_experts, title: 'man', member_id: @member.id
    end
  end

end
