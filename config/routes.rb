Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index show]
      resources :ingredients, only: %i[index]
    end
  end

  root 'homepage#index'
end
