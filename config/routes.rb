Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "foods#index"
  resources :foods, only: [:index, :create, :show, :destory, :new]
  resources :recipes, only: [:index, :new, :create, :destroy, :show, :update] do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
end
