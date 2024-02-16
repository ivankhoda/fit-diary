# == Schema Information
#
# Table name: telegram_users
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  telegram_id :integer
#  user_id     :bigint
#
# Indexes
#
#  index_telegram_users_on_user_id  (user_id)
#
class TelegramUser < ApplicationRecord
  # has_one :user
  has_many :user_workouts
end
