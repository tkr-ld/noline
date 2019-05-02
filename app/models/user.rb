class User < ApplicationRecord
  before_save :email_downcase, unless: :uid?

  has_secure_password validations: false

  validates :name, presence: true, unless: :uid?
  validates :email, presence: true, unless: :uid?, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :shops, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :already_relationships, dependent: :destroy
  has_many :reserved_shops, through: :already_relationships, source: :shop

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    email = auth[:info][:email]
    image = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.email = email
      user.image_url = image
    end
  end

  def add_reserved_shop(shop)
    self.already_relationships.find_or_create_by(shop_id: shop.id)
  end

  def reserved?(shop)
    self.reserved_shops.include?(shop)
  end

  private

  def email_downcase
    self.email.downcase!
  end
end
