# frozen_string_literal: true

require 'openssl'
module Webapp
  class WebappController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      pp('here')
    end

    def authorize
      scope = UserExercise.best_records(user)

      best_records = scope.order('exercise_id, user_exercise_sets.weight DESC')
      last_records = scope.order('exercise_id, user_exercise_sets.created_at DESC')

      render json: { best_records: best_records, last_records: last_records }
    end

    def user
      # data = Rack::Utils.parse_nested_query(params['data'])
      # user_data = JSON.parse(data['user'])
      # id = user_data['id'] ||
      id = 171_671_450
      TelegramUser.find_by(telegram_id: id)
    end
  end
end
