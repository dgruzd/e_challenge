class MembersController < ApplicationController
  def index
    @member = Member.new
    @members = Member.includes(:shortened_urls).by_friends.page(params[:page])
  end

  def new
  end

  def show
    @member = Member.find(params[:id])
    @topics = @member.topics
    @friends = @member.friends

    @title = @member.name
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to member_url(@member)
    else
      render :index
    end
  end

  private
  def member_params
    params.require(:member).permit(:name, :website)
  end
end
