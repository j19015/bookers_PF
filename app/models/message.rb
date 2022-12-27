class Message < ApplicationRecord
  belongs_to :send_user, class_name: 'User'
  belongs_to :receive_user, class_name: 'User'
  validates :chat, presence: true
  validates :caht, length: { maximum: 140 }
end
