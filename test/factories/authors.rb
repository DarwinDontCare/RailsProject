FactoryBot.define do
    factory :author do
      name { 'Nome do Autor' }
      email { 'autor@example.com' }
      birth_date { '2000-01-01' }
    end
end