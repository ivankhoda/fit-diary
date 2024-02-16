class AddReferencesToUserExercise < ActiveRecord::Migration[7.0]
  def change
    change_table :user_exercises do |t|
      t.references :telegram_user, index: true
    end
  end
end
