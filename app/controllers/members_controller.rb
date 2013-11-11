class MembersController < ApplicationController
  def index
    @members = Member.includes(:shortened_urls).by_create.page(params[:page])
  end

  def new
  end
end
