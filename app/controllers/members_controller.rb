class MembersController < ApplicationController
  def index
    @members = Member.includes(:shortened_urls).page(params[:page])
  end

  def new
  end
end
