FactoryBot.define do
    factory :newsletter do
      active { true }
      title { 'Exemplo de Título' }
  
      association :author, factory: :author
      association :book, factory: :book
    end
end