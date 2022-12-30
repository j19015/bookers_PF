class Group < ApplicationRecord
  has_one_attached :image
  has_many :group_users
  belongs_to :owner,class_name: "User"
  validates :name,length: {in:2..20}
  validates :introduction,{presence: true,length: {maximum: 50}}
  has_many :group_user, through: "group_users",source: "user"
  has_many :following_user, through: "follower",source: "followed"

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
