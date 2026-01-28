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
      resources :clients, shallow: true do
        resources :animals do
          resources :appointments
          resources :weights
          resources :vaccines
          resources :tickets do
            resources :ticket_items
          end
        end
      end

      resources :vaccine_types
      resources :users
      resources :clinic_services

      resources :tickets, only: [:index]
    end
  end

  get '/home', to: 'home#index'
end
