Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [:index, :create]
      post '/login', to: "users#login"
      resources :requests
      get '/my-requests', to: "requests#my_request"
      resources :volunteers, only: [:index, :create]
      get '/my-volunteerings', to: "volunteers#my_volunteerings"
    end
  end

end
