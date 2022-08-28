class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments
  validates :title,presence: true
  validates :body,presence: true
  validates :body,length: {maximum: 200}

  def favorite_by?(user,book)
    favorites.exists?(user_id: user.id,book_id: book.id)
  end
end
