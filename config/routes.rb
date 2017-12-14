Rails.application.routes.draw do
  resources :teammates
  
  get 'lunchdates', to: 'lunchdates#index'
  get 'lunchdates/create'

end
