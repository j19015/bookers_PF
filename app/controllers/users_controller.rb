class UsersController < ApplicationController
  before_action :currect_user, only: %i[edit update]
  before_action :ensure_guest_user, only: [:edit]
  def index
    @q = User.ransack(params[:q])
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def search
    @q = User.ransack(params[:q])
    @users = @q.result
    @user = current_user
    @book = Book.new
    render :index
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
    params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_code, :address_city, :address_street, :address_building)
  end

  def currect_user
    user = User.find(params[:id])
    return unless current_user.id != user.id

    redirect_to user_path(current_user.id)
  end
end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
  
