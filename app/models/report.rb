class Report < ApplicationRecord
  STATUSES = %w[new reviewed rejected].freeze

  belongs_to :user
  belongs_to :listing

  validates :reason, presence: true
  validates :status, inclusion: { in: STATUSES }
end
