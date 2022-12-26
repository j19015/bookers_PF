class SearchesController < ApplicationController
  def search
    if params[:search_model].to_i == 1 # userの時
      @users = User.new.search_user(params[:search_method].to_i, params[:search_text])
      render :search_user
    elsif params[:search_model].to_i == 2 # bookの時
      @books = Book.new.search_book(params[:search_method].to_i, params[:search_text])
      render :search_book
    end
  end
end
