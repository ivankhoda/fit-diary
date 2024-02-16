class CreateWorkoutExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_exercises do |t|
      t.references :exercise, index: true
      t.references :workout, index: true
      t.integer :sets
      t.integer :repetitions
      t.integer :weight

      t.integer :sets_done
      t.integer :repetitions_done
      t.integer :weight_done

      t.timestamps
    end
  end
end
