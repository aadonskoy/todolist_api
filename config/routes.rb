Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :sessions, only: [] do
        post :log_in, on: :collection
        get :log_out, on: :collection
      end
      resources :tasks, except: [:edit, :new]
    end
  end
end
