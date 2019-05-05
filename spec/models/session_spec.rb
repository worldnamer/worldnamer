require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'cleans out old sessions' do
    Session.create(key: 'key')

    Timecop.freeze(Time.current + 1.hour) do
      Session.clean_old_sessions

      expect(Session.count).to eq(0)
    end
  end

  it 'does out clean out active sessions' do
    session = Session.create(key: 'key')

    Timecop.freeze(Time.current + 1.hour) do
      session.touch

      Session.clean_old_sessions
      
      expect(Session.count).to eq(1)
    end
  end
end