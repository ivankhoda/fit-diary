# frozen_string_literal: true

FactoryBot.define do
  factory :workout, class: Workout do
    sequence(:name) { |n| "Workout#{n}" }
    muscle_group { :chest }

    factory :workout_with_exercises do
      workout_exercises do
        Array.new(2) { association :workout_exercise, workout: instance }
      end
    end
  end
end
