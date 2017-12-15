Rails.application.routes.draw do
  
  root 'application#index'
  resources :teammates
  get 'lunchdates', to: 'lunchdates#index'
  get 'lunchdates/create'

end
