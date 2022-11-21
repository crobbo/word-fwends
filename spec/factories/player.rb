FactoryBot.define do
  factory :player do
    id { SecureRandom.uuid }
    name { 'Christian' }
    ready { true }
    score { 0 }
  end
end