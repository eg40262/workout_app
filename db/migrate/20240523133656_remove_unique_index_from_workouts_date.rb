class RemoveUniqueIndexFromWorkoutsDate < ActiveRecord::Migration[7.0]
  def change
    remove_index :workouts, :date
  end
end