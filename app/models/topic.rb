class Topic < ActiveRecord::Base
  validates :level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }

  belongs_to :member

  scope :by_level, -> { order(:level) }
end
