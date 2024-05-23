class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :weight
      t.integer :reps
      t.integer :sets
      t.integer :duration
      t.integer :distance
      t.references :workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
