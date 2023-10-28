FactoryBot.define do
  factory :subscription do
    association :reader
    association :newsletter, factory: :newsletter
  end
end