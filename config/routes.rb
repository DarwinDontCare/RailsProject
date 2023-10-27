Rails.application.routes.draw do
  resources :author
  resources :reader
  resources :book
  resources :newsletter
  resources :subscription
  get '/authors', to: 'author#index'
  get '/books', to: 'book#index'
  get '/readers', to: 'reader#index'
  post '/subscribe', to: 'subscription#subscribe'
  post '/unsubscribe', to: 'subscription#unsubscribe'
  post '/loginreader', to: 'reader#authenticate_reader'
end
