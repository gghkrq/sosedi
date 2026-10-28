class User < ApplicationRecord
  has_secure_password

  normalizes :email, with: ->(email) { email.strip.downcase }

  has_many :listings, dependent: :destroy
  has_many :applications, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_listings, through: :favorites, source: :listing

  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_one :preference, dependent: :destroy
  accepts_nested_attributes_for :preference, update_only: true

  has_many :written_reviews, class_name: "Review", foreign_key: :author_id,
                             dependent: :destroy, inverse_of: :author
  has_many :received_reviews, class_name: "Review", foreign_key: :recipient_id,
                              dependent: :destroy, inverse_of: :recipient

  attribute :terms_accepted, :boolean
  validate :terms_must_be_accepted

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "имеет неверный формат" }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :age, numericality: { greater_than_or_equal_to: 16 }, allow_nil: true

  scope :regular, -> { where(admin: false) }

  def terms_must_be_accepted
    errors.add(:base, "Нужно согласие на обработку персональных данных") if terms_accepted == false
  end

  def update_rating!
    update_column(:rating, received_reviews.average(:rating)&.round(1) || 0)
  end
end
