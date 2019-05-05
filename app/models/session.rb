class Session < ActiveRecord::Base
  def self.clean_old_sessions
    Session.where('updated_at < ?', Time.current - 1.hour).destroy_all
  end

  def touch
    self.updated_at = Time.current
    save
  end
end