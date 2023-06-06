class Article < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :content, presence: true, length: { minimum: 3, maximum: 500 }
  validates :user_id, presence: true
end
