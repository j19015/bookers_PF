class BooksController < ApplicationController
  before_action :currect_user, only: %i[edit update]
  def index
    if params[:method]=="0"
      @books=Book.order(created_at: "DESC")
    elsif params[:method]=="1"
      @books=Book.order(star: "DESC")
    else
     # 変数toにTimeメソッドを用いて今日の最後日時を計算して挿入
    to = Time.current.at_end_of_day
    # 変数fromにTimeメソッドを用いて今日の0時の日時を挿入
    from = (to - 6.day).at_beginning_of_day
    # fromからtoまでで一週間分のデータを取得
    # @books = Book.where(created_at: from...to)
    # 孫モデルのいいねをしたユーザの情報まで同時に取得。
    @books = Book.includes(:favorited_users, :favorites)
                 .sort do |a, b|
      # 自分で書いた記述
      b.favorites.where(created_at: from...to).size <=>
        a.favorites.where(created_at: from...to).size
      # 下記は記事の記述だが、間違っている説が濃厚である。
      # b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
      # a.favorited_users.includes(:favorites).where(created_at: from...to).size
    end
    end
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = @book_show.user
    impressionist(@book_show, nil, unique: [:user_id]) 
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :tag_list)
  end

  def currect_user
    user = Book.find(params[:id]).user
    return unless current_user.id != user.id

    redirect_to books_path
  end
end
