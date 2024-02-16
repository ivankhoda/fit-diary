# frozen_string_literal: true

FactoryBot.define do
  factory :user_workout, class: UserWorkout do
    started_at { DateTime.now }
  end
end
