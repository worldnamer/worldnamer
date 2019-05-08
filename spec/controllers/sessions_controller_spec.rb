require 'rails_helper'

RSpec.describe Api::SessionsController, type: :request do
  context 'create' do
    it 'requires a username and password' do
      post api_sessions_path

      expect(response.code).to eq('401')
      expect(response.headers['WWW-Authenticate']).to eq('Basic realm="api"')
    end

    it 'rejects improper authentication' do
      post api_sessions_path, headers: { 'Authorization' => "Basic #{Base64.encode64('worldnamer:badpassword')}" }

      expect(response.code).to eq('401')
      expect(response.headers['WWW-Authenticate']).to eq('Basic realm="api"')
    end

    it 'handles malformed authentication' do
      post api_sessions_path, headers: { 'Authorization' => Base64.encode64('worldnamerpassword') }

      expect(response.code).to eq('401')
      expect(response.headers['WWW-Authenticate']).to eq('Basic realm="api"')
    end

    it 'accepts proper authentication' do
      user = create :user
      post api_sessions_path, headers: { 'Authorization' => "Basic #{Base64.encode64(user.username + ':' + user.password)}" }

      expect(response.code).to eq('200')
      
      parsed = JSON.parse(response.body)
      expect(parsed['key']).to be_present

      expect(Session.count).to eq(1)
    end

    it 'logging in twice produces two sessions' do
      user = create :user
      post api_sessions_path, headers: { 'Authorization' => "Basic #{Base64.encode64(user.username + ':' + user.password)}" }
      post api_sessions_path, headers: { 'Authorization' => "Basic #{Base64.encode64(user.username + ':' + user.password)}" }

      expect(Session.count).to eq(2)
    end

    it 'logging in with an existing session touches the session' do
      session = create :session

      post api_sessions_path, headers: { 'Authorization' => "wnauth #{session.key}" }

      expect(response.code).to eq('204')
      expect(Session.count).to eq(1)
    end
  end
end
