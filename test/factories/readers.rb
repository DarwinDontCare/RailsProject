FactoryBot.define do
    factory :reader do
      email { 'exemplo@email.com' }
      password { 'senha_secreta' }
    end
end