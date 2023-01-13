class UsersController < ApplicationController
  before_action :currect_user, only: %i[edit update]
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def day_search_book
    @cnt=User.find(params[:id]).books.where(created_at: params[:created_at].to_date.beginning_of_day..params[:created_at].to_date.end_of_day).count
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def currect_user
    user = User.find(params[:id])
    return unless current_user.id != user.id

    redirect_to user_path(current_user.id)
  end
end
