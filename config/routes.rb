Rails.application.routes.draw do
  resources :bank_accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'bank_accounts#index'
end
