require 'rails_helper'

RSpec.describe Api::StickiesController, type: :request do
  context 'index' do
    it 'authorizes requests' do
      get api_stickies_path

      expect(response.code).to eq('401')
      expect(response.headers['WWW-Authenticate']).to eq('Basic realm="api"')
    end

    it 'returns no stickies if none exist' do
      session = create :session
      get api_stickies_path, headers: { 'Authorization' => "wnauth #{session.key}" }

      expect(response.code).to eq('200')

      parsed = JSON.parse(response.body)
      expect(parsed).to eq([])
    end

    it 'returns stickies if they exist' do
      session = create :session
      sticky = create :sticky

      get api_stickies_path, headers: { 'Authorization' => "wnauth #{session.key}" }

      expect(response.code).to eq('200')

      parsed = JSON.parse(response.body)
      expect(parsed.count).to eq(1)
      expect(parsed[0]['id']).to eq(sticky.id)
      expect(parsed[0]['text']).to eq(sticky.text)
      expect(parsed[0]['color']).to eq(sticky.color)
    end
  end
end
