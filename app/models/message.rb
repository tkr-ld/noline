class Message < ApplicationRecord
  validates :content_type, presence: true
  validates :content_type, presence: true
  
  belongs_to :user
end
