class FavoritesController < ApplicationController
  def create
    favorite = Favorite.create(book_id: params[:book_id], user_id: current_user.id)
    @book_show = Book.find(params[:book_id])
    render :favorite_btn
  end

  def destroy
    Favorite.find_by(book_id: params[:book_id], user_id: current_user.id).destroy
    @book_show = Book.find(params[:book_id])
    render :favorite_btn
  end
end
