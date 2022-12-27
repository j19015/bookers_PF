class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments
  # いいねの多い順に表示するためにbookから簡単にいいねしたユーザの情報を取得できるようにしておく
  has_many :favorited_users, through: :favorites, source: :user
  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }

  #PV数
  is_impressionable counter_cache: true

  def favorite_by?(user, book)
    favorites.exists?(user_id: user.id, book_id: book.id)
  end

  def search_book(method, text)
    if method == 1 # 完全一致
      Book.where('title like ?', "#{text}")
    elsif method == 2 # 前方一致
      Book.where('title like ?', "#{text}%")
    elsif method == 3 # 後方一致
      Book.where('title like ?', "%#{text}")
    elsif method == 4 # 部分一致
      Book.where('title like ?', "%#{text}%")
    end
  end
end
