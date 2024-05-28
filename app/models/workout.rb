class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises, allow_destroy: true
  # ネストされたフォームからExerciseの属性を受け入れ、Workoutを更新する際にExerciseの作成、更新、削除が可能になります。
  has_one_attached :image

  scope :recent, -> { order(date: :desc) }

  validates :date, presence: true, uniqueness: { scope: :user_id }
  # scope: :user_idを追加することで、dateの一意性をuser_idごとに制限します。これにより、同じユーザー内では同じ日付のワークアウトを持つことはできませんが、異なるユーザーでは同じ日付を持つことができます。
end