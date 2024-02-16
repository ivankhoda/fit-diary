# frozen_string_literal: true

module Admins
  class Admins::AdminsController < ApplicationController
    def index
      pp(current_admin, '666666')
      render 'admins/admin'
    end
  end
end
