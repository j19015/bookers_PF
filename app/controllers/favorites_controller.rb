class FavoritesController < ApplicationController

  def create
    favorite=Favorite.create(book_id: params[:book_id],user_id: current_user.id)
    redirect_to request.referer
  end

  def destroy
    Favorite.find_by(book_id: params[:book_id],user_id: current_user.id).destroy
    redirect_to request.referer
  end
end
