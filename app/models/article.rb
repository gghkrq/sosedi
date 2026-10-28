class Article < ApplicationRecord
  validates :title, :body, presence: true

  scope :newest, -> { order(created_at: :desc) }
end
