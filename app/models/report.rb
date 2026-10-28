class Report < ApplicationRecord
  STATUSES = %w[new reviewed rejected].freeze
  REASONS = [
    "Неактуальное объявление",
    "Неверная цена",
    "Мошенничество",
    "Оскорбительное содержание",
    "Другое"
  ].freeze

  belongs_to :user
  belongs_to :listing

  validates :reason, inclusion: { in: REASONS }
  validates :listing_id, uniqueness: { scope: :user_id, message: "— вы уже жаловались на это объявление" }
  validates :status, inclusion: { in: STATUSES }
end
