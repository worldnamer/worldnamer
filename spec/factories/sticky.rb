FactoryBot.define do
  factory :sticky do
    text { SecureRandom.uuid.to_s }
  end
end