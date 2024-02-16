class CreateUserWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_workouts do |t|
      t.references :workout, index: true
      t.references :telegram_user, index: true

      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
