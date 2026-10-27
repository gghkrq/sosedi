class Notification < ApplicationRecord
  belongs_to :user

  validates :text, presence: true

  scope :unread, -> { where(read: false) }
  scope :newest, -> { order(created_at: :desc) }
end
