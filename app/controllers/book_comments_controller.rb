class BookCommentsController < ApplicationController
  def create
    BookComment.create(book_id: params[:book_id],user_id: current_user.id,comment: params[:book_comment]["comment"])
    @book=Book.find(params[:book_id])
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book=Book.find(params[:book_id])
  end
end
