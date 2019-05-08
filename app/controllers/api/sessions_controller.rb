module Api
  class SessionsController < ApplicationController
    def create
      if (@session)
        @session.save

        head :no_content
      else
        @session = Session.create(key: SecureRandom.uuid.to_s)

        render json: { key: @session.key }
      end
    end
  end
end