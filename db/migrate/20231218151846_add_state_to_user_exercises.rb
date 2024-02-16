class AddStateToUserExercises < ActiveRecord::Migration[7.0]
  def change
    change_table(:user_exercises) do |t|
      t.column :state, :string
    end
  end
end
