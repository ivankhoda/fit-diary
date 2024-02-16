class AddColumnsToUsersExercises < ActiveRecord::Migration[7.0]
  def change
    change_table(:user_exercises) do |t|
      t.column :sets, :integer
      t.column :repetitions, :integer
      t.column :weight, :integer
    end
  end
end
