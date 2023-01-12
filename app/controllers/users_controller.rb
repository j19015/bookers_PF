class UsersController < ApplicationController
  before_action :currect_user,only:[:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  def index
    @users=User.all
    @user=current_user
    @book=Book.new
  end

  def show
    @book=Book.new
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice:"You have updated user successfully."
    else
      render :edit
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def currect_user
    user=User.find(params[:id])
    if current_user.id!=user.id
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
  
end
