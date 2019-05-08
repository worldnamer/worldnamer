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

  context 'create' do
    it 'authorizes requests' do
      post api_stickies_path

      expect(response.code).to eq('401')
      expect(response.headers['WWW-Authenticate']).to eq('Basic realm="api"')
    end

    it 'creates blank stickies' do
      session = create :session

      post api_stickies_path, headers: { 'Authorization' => "wnauth #{session.key}" }

      expect(response.code).to eq('200')

      parsed = JSON.parse(response.body)
      expect(parsed['id']).to be_present
      expect(parsed['text']).to eq('')
      expect(parsed['color']).to eq('yellow lighten-3')
    end
  end

  context 'destroy' do
    it 'authorizes requests' do
      delete api_sticky_path(1)

      expect(response.code).to eq('401')
      expect(response.headers['WWW-Authenticate']).to eq('Basic realm="api"')
    end

    it 'removes a sticky' do
      session = create :session
      sticky = create :sticky

      delete api_sticky_path(sticky.id), headers: { 'Authorization' => "wnauth #{session.key}" }

      expect(response.code).to eq('204')
      expect(Sticky.count).to eq(0)
    end

    it 'succeeds even if the sticky does not exist' do
      session = create :session

      delete api_sticky_path(1), headers: { 'Authorization' => "wnauth #{session.key}" }

      expect(response.code).to eq('204')
      expect(Sticky.count).to eq(0)
    end
  end

  context 'update' do
    it 'authorizes requests' do
      put api_sticky_path(1)

      expect(response.code).to eq('401')
      expect(response.headers['WWW-Authenticate']).to eq('Basic realm="api"')
    end

    it 'updates an existing sticky' do
      session = create :session
      sticky = create :sticky

      updated_text = 'new text'
      updated_color = 'red lighten-4'

      put api_sticky_path(sticky.id), params: { text: updated_text, color: updated_color }, headers: { 'Authorization' => "wnauth #{session.key}" }
      sticky.reload

      expect(response.code).to eq('204');
      expect(sticky.text).to eq(updated_text);
      expect(sticky.color).to eq(updated_color);
    end

    it 'returns a 404 when the sticky is missing' do
      session = create :session

      updated_text = 'new text'
      updated_color = 'red lighten-4'

      put api_sticky_path(1), params: { text: updated_text, color: updated_color }, headers: { 'Authorization' => "wnauth #{session.key}" }

      expect(response.code).to eq('404');
    end
  end
end
