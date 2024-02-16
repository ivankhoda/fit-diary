# frozen_string_literal: true

FactoryBot.define do
  factory :user_exercise, class: UserExercise do
    sequence(:name) { |n| "Name#{n}" }
    sets { 2 }
    state { :new }
    repetitions { 10 }
    weight { 50 }

    trait :with_state do |st|
      state { st }
    end
  end
end
