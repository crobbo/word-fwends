FactoryBot.define do
  factory :player do
    id { SecureRandom.uuid }
    name { 'Christian' }
    ready { true }
  end
end