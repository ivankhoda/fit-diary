class CreateUserExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :user_exercises do |t|
      t.string :name
      t.references :exercise, index: true
      t.references :user_workout, index: true
      
      t.timestamps
    end
  end
end
