class GroupsController < ApplicationController
  before_action :owner_check,only:[:edit,:update]
  def new
    @group=Group.new
  end

  def show
    @book=Book.new
    @group=Group.find(params[:id])
    @user=@group.owner
  end
  
  def index
    @book=Book.new
    @user=current_user
    @groups=Group.all
  end

  def edit
    @group=Group.find(params[:id])
  end

  def update
    @group=Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id),notice:"edit group successfully"
    else
      render :edit
    end
  end

  def create
    @group=current_user.groups.new(group_params)
    if @group.save
      redirect_to group_path(@group),notice:"create group successfully"
    else
      render :new
    end
  end


  def new_mail
    @group=Group.find(params[:group_id])
  end

  def send_mail
    @group=Group.find(params[:group_id])
    @title=params[:title]
    @content=params[:content]
    UserMailer.send_mail(@title,@content,@group.group_user).deliver
  end
  private
  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end

  def owner_check
    if current_user.id!=Group.find(params[:id]).owner_id
      redirect_to groups_path
    end
  end
end
