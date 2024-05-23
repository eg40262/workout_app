class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.date :date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :workouts, [:user_id, :date], unique: true
  end
end