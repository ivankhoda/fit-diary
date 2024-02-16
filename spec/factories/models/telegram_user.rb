# frozen_string_literal: true

FactoryBot.define do
  factory :telegram_user, class: TelegramUser do
    sequence(:name) { |n| "user#{n}" }
    sequence(:telegram_id) { |n| n }
  end
end
