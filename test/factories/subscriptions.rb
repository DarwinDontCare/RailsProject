FactoryBot.define do
  factory :subscription do
    association :reader
    association :newsletter
  end
end