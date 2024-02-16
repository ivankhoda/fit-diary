class CreateTelegramUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :telegram_users do |t|
      t.string :name
      t.integer :telegram_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
