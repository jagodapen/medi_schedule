Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "patients#index"
  resources :patients, only: [:index] do
    resources :appointments, only: [:new, :destroy]
  end
  resources :appointments, only: [:index, :create, :destroy] do
    collection do
      get "doctor_time_slots"
    end
  end
end
