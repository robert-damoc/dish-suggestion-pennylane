Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index show]
      resources :ingredients, only: %i[index]
    end
  end

  # Forward all requests to HomepageController#index but requests must be
  # non-Ajax (!req.xhr?) and HTML Mime type (req.format.html?)
  # This does not include the root ("/") path.
  get '*page', to: 'homepage#index', constraints: ->(req) do
    !req.xhr? && req.format.html?
  end

  # Forward root to HomepageController#index
  root 'homepage#index'
end
