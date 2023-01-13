class Tag < ApplicationRecord
  has_many :books
  validates :name,length: {in:2..20}
end
