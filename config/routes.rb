Rails.application.routes.draw do
  get 'general_shopping_list/index'
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'public_recipes', to: 'recipes#public', as: 'public'
  root "recipes#public"
  resources :foods
  resources :recipes do
    resources :recipe_foods
    end
  resources :public_recipes, only: [:create, :destory] 
  resources :general_shopping_list, only: [:create, :destory] 
end
