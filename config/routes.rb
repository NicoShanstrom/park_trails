Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/asheville_parks", to: "asheville_parks#index"
  get "/asheville_parks/new", to: "asheville_parks#new"
  post "/asheville_parks", to: "asheville_parks#create"
  get "/asheville_parks/:id/edit", to: "asheville_parks#edit"
  patch "/asheville_parks/:id", to: "asheville_parks#update"
  get "/asheville_parks/:id", to: "asheville_parks#show"
  get "/trails", to: "trails#index"
  get "/asheville_parks/:id/trails", to: "asheville_parks_trails#index"
end
