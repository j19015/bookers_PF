class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments
  validates :title,presence: true
  validates :body,presence: true
  validates :body,length: {maximum: 200}

  #本日の投稿数
  scope :created_today,->{where(created_at: Time.zone.now.all_day).count}
  #昨日の投稿数
  scope :created_yesterday,->{where(created_at: 1.day.ago.all_day).count}
  #今週の投稿数
  scope :created_this_week,->{where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day).count}
  #先週の投稿数
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day).count}

  scope :created_ago_day,->(day){where(created_at: day.day.ago.all_day).count}
  
  
  
  def favorite_by?(user,book)
    favorites.exists?(user_id: user.id,book_id: book.id)
  end

  def search_book(method,text)
    if method==1 #完全一致
      Book.where('title like ?',"#{text}")
    elsif method==2#前方一致
      Book.where('title like ?',"#{text}%")
    elsif method==3#後方一致
      Book.where('title like ?',"%#{text}")
    elsif method==4#部分一致
      Book.where('title like ?',"%#{text}%")
    end
  end

end
