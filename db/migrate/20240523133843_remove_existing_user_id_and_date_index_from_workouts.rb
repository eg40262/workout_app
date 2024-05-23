class RemoveExistingUserIdAndDateIndexFromWorkouts < ActiveRecord::Migration[7.0]
  def change
    if index_exists?(:workouts, [:user_id, :date], name: 'index_workouts_on_user_id_and_date')
      remove_index :workouts, name: 'index_workouts_on_user_id_and_date'
    end
  end
end