class BookCommentsController < ApplicationController
  def create
    BookComment.create(book_id: params[:book_id],user_id: current_user.id,comment: params[:book_comment]["comment"])
    redirect_to request.referer
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer
  end
end
