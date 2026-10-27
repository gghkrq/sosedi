class Listing < ApplicationRecord
  STATUSES = %w[active closed].freeze

  belongs_to :user
  has_many :applications, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :title, :city, presence: true
  validates :status, inclusion: { in: STATUSES }
  validate :active_until_in_future, if: :until_date?

  before_validation { self.active_until = nil if @duration == "unlimited" }

  scope :active, -> {
    where(status: "active").where("active_until IS NULL OR active_until >= ?", Date.current)
  }
  scope :newest, -> { order(created_at: :desc) }

  def residents
    [ user ] + applications.select { |a| a.status == "accepted" }.map(&:user)
  end

  def free_spots
    [ max_people.to_i - residents.size, 0 ].max
  end

  def currently_active?
    status == "active" && (active_until.nil? || active_until >= Date.current)
  end

  def duration
    @duration || (active_until.present? ? "until_date" : "unlimited")
  end

  def duration=(value)
    @duration = value
  end

  def until_date?
    duration == "until_date"
  end

  def tag_names
    tags.map(&:name).join(", ")
  end

  def tag_names=(value)
    names = value.to_s.split(",").map(&:strip).reject(&:blank?).uniq
    self.tags = names.map { |name| tags.find { |tag| tag.name == name } || Tag.new(name: name) }
  end

  private

  def active_until_in_future
    if active_until.blank?
      errors.add(:active_until, "нужно указать, если выбран срок «до даты»")
    elsif active_until < Date.current && will_save_change_to_active_until?
      errors.add(:active_until, "не может быть в прошлом")
    end
  end
end
