class CreateUserExerciseSet < ActiveRecord::Migration[7.0]
  def change
    create_table :user_exercise_sets do |t|
      t.references :user_exercise, index: true
      t.integer :repetitions
      t.integer :weight

      t.timestamps
    end
  end
end
