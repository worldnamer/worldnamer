module Api
  class SessionsController < ApplicationController
    before_action :clean_old_sessions

    def index
      render json: Session.all.map(&:key)
    end

    def create
      authenticated = false

      authentication = request.headers['Authorization']
      begin
        if authentication.present?
          Rails.logger.error("auth: #{authentication}")

          authentication = authentication[authentication.index('Basic ')+6, 100]
          username, password = Base64.decode64(authentication).split(':')

          Rails.logger.error("un: #{username} pw: #{password}")

          user = User.find_by(username: username)
          authenticated = true if user && user.authenticate(password)
        end
      rescue StandardError
      end

      if authenticated
        session = Session.create(key: SecureRandom.uuid.to_s)
        render json: { key: session.key }
      else
        headers['WWW-Authenticate'] = 'Basic realm="api"'
        head :unauthorized
      end
    end

    private

    def clean_old_sessions
      Session.clean_old_sessions
    end
  end
end