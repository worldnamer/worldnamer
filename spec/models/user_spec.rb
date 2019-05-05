require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a transient password that encrypts when it is saved' do
    user = User.create(username: 'test', password: 'test')

    expect(user.password_digest).to be_present
  end
end
