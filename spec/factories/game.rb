FactoryBot.define do
  factory :game do
    id { SecureRandom.uuid }
    word { 'apple' }
    guess_no { 1 }
  end
end