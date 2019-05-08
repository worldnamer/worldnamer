require 'rails_helper'

RSpec.describe Sticky, type: :model do
  it 'has a default color' do
    sticky = Sticky.create(text: 'asdf')

    expect(sticky.color).to be_present
  end
end
