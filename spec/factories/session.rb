FactoryBot.define do
  factory :session do
    key { SecureRandom.uuid.to_s }
  end
end