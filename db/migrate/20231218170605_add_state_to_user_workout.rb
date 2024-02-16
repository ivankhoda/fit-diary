class AddStateToUserWorkout < ActiveRecord::Migration[7.0]
  def change
    change_table(:user_workouts) do |t|
      t.column :state, :string
    end
  end
end
