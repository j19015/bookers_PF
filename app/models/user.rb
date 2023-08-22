class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  has_many :favorites
  has_many :book_comments

  # RelationShipに定義されている仮想テーブルの「follower」が子要素であること(外部キーをfollower_idとユーザが一致しているものとする)
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # RelationShipに定義されている仮想テーブルの「followed」が子要素であること(外部キーをfollowed_idとユーザが一致しているものとする)
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  # following_userと入力すると子要素であるfollowerを飛ばして,followedを取得する。
  has_many :following_user, through: 'follower', source: 'followed'

  ## followed_userと入力すると子要素であるfollowedを飛ばして、followerを取得する。

  has_many :followed_user, through: 'followed', source: 'follower'

  has_many :groups,class_name: "Group",foreign_key: "owner_id", dependent: :destroy 

  has_one_attached :profile_image
  
  validates :name,uniqueness: true
  validates :name,length: {in:2..20}
  validates :introduction,length: {maximum: 50}

  # ransack
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow_confirm?(follower_id,followed_id)
    Relationship.exists?(follower_id: follower_id, followed_id: followed_id)
  end

  def group_in?(group_id)
    GroupUser.exists?(user_id: self.id,group_id: group_id)
  end

  def group_in?(group_id)
    GroupUser.exists?(user_id: self.id,group_id: group_id)
  end

  def search_user(method, text)
    if method == 1 # 完全一致
      User.where('name like ?', "#{text}")
    elsif method == 2 # 前方一致
      User.where('name like ?', "#{text}%")
    elsif method == 3 # 後方一致
      User.where('name like ?', "%#{text}")
    elsif method == 4 # 部分一致
      User.where('name like ?', "%#{text}%")
    end
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  #google map api
  include JpPrefecture
  jp_prefecture :prefecture_code


  geocoded_by :address_city
  after_validation :geocode, if: :address_city_changed?
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def join_address
    "#{self.prefecture_name}#{self.address_city}#{self.address_street}#{self.address_building}"
  end

  def start_time
    created_at
  end

end
