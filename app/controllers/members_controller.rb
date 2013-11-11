class MembersController < ApplicationController
  def index
    @members = Member.includes(:shortened_urls).by_friends.page(params[:page])
  end

  def new
  end

  def show
    @member = Member.find(params[:id])
  end
end
