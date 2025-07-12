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

  get '/home', to: 'home#index'
end
