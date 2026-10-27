class Review < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :rating, inclusion: { in: 1..5 }
  validate :author_is_not_recipient

  after_save :refresh_recipient_rating
  after_destroy :refresh_recipient_rating, unless: :destroyed_by_association

  private

  def refresh_recipient_rating
    recipient.update_rating!
  end

  def author_is_not_recipient
    errors.add(:recipient, "не может совпадать с автором") if author_id.present? && author_id == recipient_id
  end
end
