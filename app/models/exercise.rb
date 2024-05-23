class Exercise < ApplicationRecord
  belongs_to :workout

  # validates :name, :weight, :reps, :sets, presence: true
end