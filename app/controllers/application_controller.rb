class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :clean_old_sessions
  before_action :authenticate

  private

  def clean_old_sessions
    Session.clean_old_sessions
  end

  def authenticate
    read_authentication
    unless valid_authentication
      headers['WWW-Authenticate'] = 'Basic realm="api"'
      head :unauthorized
    end
  end

  def read_authentication
    authentication = request.headers['Authorization']
    if authentication.present?
      Rails.logger.error("auth: #{authentication}")

      basic_idx = authentication.index('Basic ')
      @authentication = if (basic_idx)
        ['Basic', Base64.decode64(authentication[basic_idx+6, 100]).strip]
      else
        session_idx = authentication.index('wnauth ')
        if (session_idx)
          ['wnauth', authentication[session_idx+6, 100].strip]
        end
      end
    end
  rescue StandardError
  end

  def valid_authentication
    return unless @authentication && @authentication[0] && @authentication[1]

    auth_mode = @authentication[0]
    if auth_mode == 'Basic'
      username, password = @authentication.last.split(':')

      @user = User.find_by(username: username)
      return true if @user && @user.authenticate(password)
    elsif auth_mode == 'wnauth'
      @session = Session.find_by(key: @authentication[1])
      return true if @session.present?
    end

    false
  rescue StandardError
    false
  end
end
