class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.string :name
      t.datetime :date_for
      t.integer :muscle_group
      t.datetime :started_at
      t.datetime :finished_at
      t.references :workout_exercises, index: true
      t.timestamps
    end
  end
end
