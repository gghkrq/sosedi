class Application < ApplicationRecord
  STATUSES = %w[pending accepted rejected].freeze

  belongs_to :user
  belongs_to :listing

  attribute :status, :string, default: "pending"

  validates :message, presence: true
  validates :status, inclusion: { in: STATUSES }
end
