class MembersController < ApplicationController
  def index
    @member = Member.new
    @members = Member.includes(:shortened_urls).by_friends.page(params[:page])
  end

  def new
  end

  def show
    @member = Member.find(params[:id])
    @topics = @member.topics.by_level
    @friends = @member.friends
    @not_friends = not_friends

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

  def add_friend
    @member = Member.find(params[:member_id])
    @friend = Member.find(params[:id])
    if @member.add_friend(@friend)
      @friends = @member.friends
      @not_friends = not_friends
      respond_to do |format|
        format.js
      end
    else
      render nothing: true, status: 400
    end
  end

  def find_experts
    @member = Member.find(params[:member_id])
    @result = []

    if params[:title].present?
      @topics = Topic.search_by_title(params[:title])
      member_ids = @topics.map(&:member_id).uniq

      bfs = BFS.new
      paths = bfs.bfs(@member.id, *member_ids)
      logger.debug paths.inspect


      if paths
        @members = Member.find(paths.flatten.uniq)
        @topics.each do |t|
          path = paths.find{|f| f.last == t.member_id}
          if path
            members_path = path.map{|id| @members.find{|f| f.id == id} }
            @result << { path: members_path, topic: t, names: members_path.map(&:name)}
          end
        end
        logger.debug @result.inspect
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def member_params
    params.require(:member).permit(:name, :website)
  end

  def not_friends
    Member.where('id NOT IN (?)', @friends.map(&:id) << @member.id)
  end
end
