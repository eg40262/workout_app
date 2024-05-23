class AddIndexToWorkoutsUserIdAndDate < ActiveRecord::Migration[7.0]
  def change
    add_index :workouts, [:user_id, :date], unique: true unless index_exists?(:workouts, [:user_id, :date])
  end
end