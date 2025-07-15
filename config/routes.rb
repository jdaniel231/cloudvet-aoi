Rails.application.routes.draw do
  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout'
    },
    controllers: {
      sessions: 'users/sessions'
    }

  namespace :api do
    namespace :v1 do
      resources :clients do 
        resources :animals
      end
      resources :animals
    end
  end

  get '/home', to: 'home#index'
end
