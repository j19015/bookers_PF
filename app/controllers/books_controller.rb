class BooksController < ApplicationController
  before_action :currect_user,only:[:edit, :update]
  def index
    if params[:method]=="0"
      @books=Book.order(created_at: "DESC")
    elsif params[:method]=="1"
      @books=Book.order(star: "DESC")
    elsif params[:method]=="2"
      @books=Book.where(tag_id: params[:tag_id])
    elsif params[:method]=="3"
      if Tag.exists?(name: params[:tag_name])
        tag=Tag.find_by(name: params[:tag_name])
        @books=Book.where(tag_id: tag.id)
      else
        @books=Book.all
        flash[:error]="該当するタグは見つかりませんでした"
      end
    else
     @books=Book.all
    end
    @user=current_user
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if Tag.exists?(name: params[:book][:tag_name])
      @book.tag_id=Tag.find_by(name: params[:book][:tag_name]).id
    else
      tag=Tag.new(name: params[:book][:tag_name])
      tag.save
      @book.tag_id=tag.id
    end
    if @book.save
      redirect_to book_path(@book.id),notice:"You have created book successfully."
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end

  def show
    @book=Book.new
    @book_show=Book.find(params[:id])
    @user=@book_show.user
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id),notice:"You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:star)
  end

  def currect_user
    user=Book.find(params[:id]).user
    if current_user.id!=user.id
      redirect_to books_path
    end
  end
end
