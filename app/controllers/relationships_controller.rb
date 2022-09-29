class RelationshipsController < ApplicationController
  def create
    # follower フォローした人
    # followed フォローされた人
    follower=Relationship.new(follower_id: current_user.id,followed_id: params[:user_id])
    follower.save
    redirect_to request.referer
  end
  
  def destroy
    follower=Relationship.find_by(follower_id: current_user.id,followed_id: params[:user_id])
    follower.destroy
    redirect_to request.referer
  end

  def followings
    user=User.find(params[:user_id])
    @followings_users=user.following_user
  end

  def followers
    user=User.find(params[:user_id])
    @followers_users=user.followed_user
  end
end
