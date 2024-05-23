class Workout < ApplicationRecord
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises, allow_destroy: true

  scope :recent, -> { order(date: :desc) }

  validates :date, presence: true, uniqueness: true

end