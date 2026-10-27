class Preference < ApplicationRecord
  CLEANLINESS = %w[высокая средняя низкая].freeze
  SCHEDULES   = %w[жаворонок свободный сова].freeze
  GUESTS      = %w[редко иногда часто].freeze
  NOISE       = %w[тишина умеренно не\ важно].freeze
  ALCOHOL     = %w[не\ пью иногда часто].freeze

  belongs_to :user

  validates :cleanliness, inclusion: { in: CLEANLINESS }, allow_blank: true
  validates :schedule,    inclusion: { in: SCHEDULES },   allow_blank: true
  validates :guests,      inclusion: { in: GUESTS },      allow_blank: true
  validates :noise,       inclusion: { in: NOISE },       allow_blank: true
  validates :alcohol,     inclusion: { in: ALCOHOL },     allow_blank: true
end
